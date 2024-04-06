import express from "express";
import mongoose from "mongoose";
import { get_next_message_from_Alicia } from "./model_requests.js";

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

const session = new mongoose.Schema({
    text: [String],
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
    if(!usr){
        res.status(400).send();
        return;
    }
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

app.get('/get_session', async(req, res)=>{
    const session = await Session.findById(req.body.session_id);
    const usr = await User.findById(req.body.user_id);
    if(!session || !usr){
        res.status(400).send();
        return;
    }
    const prev_session = usr.sessions[usr.sessions.indexOf(session)-1];
    const response_data = {prev_session_id: prev_session.session_id, messages: session.text};
    res.status(200).send(JSON.stringify(response_data));
});

app.post('/end_session', (req, res)=>{
    console.log(req);
    res.status(200).send("hello");
});

app.post('/message', (req, res)=>{
    console.log(req);
    res.status(200).send("hello");
});