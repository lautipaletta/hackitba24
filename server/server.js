import express from "express";
import mongoose from "mongoose";
import { get_next_message_from_Alicia, get_session_summary_from_Mauro } from "./model_requests.js";

const app = express(); 
const PORT = 3000; 

app.use(express.json());

app.listen(PORT, (error) =>{ 
    if(!error) 
        console.log("Server is Successfully Running, and App is listening on port "+ PORT) 
    else 
        console.log("Error occurred, server can't start", error); 
    } 
);

mongoose.connect('mongodb://127.0.0.1:27017/database');
console.log("connected to database")

const message = new mongoose.Schema({
    content: String,
    role: String,
    timestamp: Number
});

const Message = mongoose.model("Message", message);

const session = new mongoose.Schema({
    messages: [message],
    summary: String,
    timestamp: Number
});

const Session = mongoose.model("Session", session);

const user = new mongoose.Schema({
    name: String,
    sessions: [session]
});

const User = mongoose.model("User", user);

app.post('/start_session', async (req, res)=>{
    const usr = await User.findById(req.body.user_id).exec();
    const prev_session = usr.sessions[usr.sessions.length-1];
    const response_data = {prev_session_id: prev_session._id, messages: prev_session.text};
    const prev_summary = prev_session.summary;
    const opening_message = await get_next_message_from_Alicia([], prev_summary);
    const session = new Session({text: [opening_message], summary: null, timestamp: Date.now()});
    await session.save();
    usr.sessions.push(session);
    await usr.save();
    res.status(200).send(JSON.stringify(response_data));
});

app.get('/get_session', (req, res)=>{
    console.log(req);
    res.status(200).send("hello");
});

app.post('/end_session', async (req, res)=>{
    const usr = await User.findById(req.body.user_id).exec();
    const session = usr.sessions[usr.sessions.length - 1];

    if (session.messages.length <= 1) 
        usr.sessions.pop();
    else 
        session.summary = await get_session_summary_from_Mauro(session.messages);

    usr.save();

    res.sendStatus(200);
});

app.post('/message', async (req, res)=>{
    const { user_id, content } = req.body;

    const usr = await User.findById(user_id).exec();
    if (!usr) return res.sendStatus(400);

    const message = new Message({content: content, role: "user", timestamp: Date.now()});

    usr.sessions.push(message);

    const prev_summary = usr.sessions[usr.sessions.length - 2].summary;
    const session = usr.sessions[usr.sessions.length - 1];

    const next_message_str = await get_next_message_from_Alicia(session.messages, prev_summary);

    const next_message = new Message({content: next_message_str, role: "assistant", timestamp: Date.now()});

    usr.sessions.push(next_message);

    usr.save();

    res.status(200).send({content: next_message.content, role: next_message.role, timestamp: next_message.timestamp});
});
