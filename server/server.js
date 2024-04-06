import express from "express";
import mongoose from "mongoose";
import { get_next_message_from_Alicia, get_session_summary_from_Mauro } from "./model_requests.js";
import { Message, User, Session } from "./schemas.js";
import { ObjectId } from "bson";

const app = express(); 
const PORT = 3000; 

app.use(express.json());

app.listen(PORT, (error) => { 
    if(!error) console.log("Server is Successfully Running, and App is listening on port "+ PORT) 
    else console.log("Error occurred, server can't start", error); 
});

mongoose.connect('mongodb://127.0.0.1:27017/database');
console.log("connected to database")

//const juan = new User({name: "Juan", sessions: [], _id: new ObjectId("6610ebbe9a26fa276452bfae")});
//console.log(juan);
//juan.save();

app.get('/hi', (req, res) => res.send("Hi!"));

app.post('/create_user', async (req, res) => {
    const usr = new User({name: req.body.name});
    await usr.save();

    res.status(200).send({user_id: usr._id});
});

app.post('/start_session', async (req, res) => {
    const usr = await User.findById(req.body.user_id).exec();

    if (!usr) return res.sendStatus(400);
    
    const prev_session = usr.sessions[usr.sessions.length - 1];

    const opening_text = await get_next_message_from_Alicia([], prev_session?.summary);

    const opening_message = new Message({content: opening_text, timestamp: Date.now(), role:"assistant"});
    await opening_message.save();

    const session = new Session({messages: [opening_message], timestamp: Date.now()});
    await session.save();

    usr.sessions.push(session);
    await usr.save();

    res.status(200).send({prev_session_id: prev_session?._id, messages: [opening_message]});
});

app.get('/get_session', async (req, res) => {
    const session = await Session.findById(req.query.session_id);
    const usr = await User.findById(req.query.user_id);

    if (!session || !usr) return res.sendStatus(400);

    const prev_session = usr.sessions[usr.sessions.indexOf(session) - 1];

    res.status(200).send({prev_session_id: prev_session?.session_id, messages: session.messages});
});

app.post('/end_session', async (req, res) => {
    const usr = await User.findById(req.body.user_id).exec();
    if (!usr) return res.sendStatus(400);

    const session = usr.sessions[usr.sessions.length - 1];
    if (!session) return res.sendStatus(400);

    if (session.messages.length <= 1) {
        usr.sessions.pop();
        await Session.deleteOne({_id: session._id});
    }
    else {
        session.summary = await get_session_summary_from_Mauro(session.messages);
        await session.save();
    }

    await usr.save();

    res.sendStatus(200);
});

app.post('/message', async (req, res) => {
    const { user_id, content } = req.body;

    const usr = await User.findById(user_id).exec();
    if (!usr) return res.sendStatus(400);

    const message = new Message({content: content, role: "user", timestamp: Date.now()});
    await message.save();

    const session = usr.sessions[usr.sessions.length - 1];
    
    session.messages.push(message);

    const prev_summary = usr.sessions[usr.sessions.length - 2]?.summary;

    const next_message_str = await get_next_message_from_Alicia(session.messages, prev_summary);

    const next_message = new Message({content: next_message_str, role: "assistant", timestamp: Date.now()});
    await next_message.save();

    session.messages.push(next_message);

    await session.save();
    await usr.save();

    res.status(200).send(next_message);
});
