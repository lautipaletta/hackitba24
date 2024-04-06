import express from "express";
import mongoose from "mongoose";

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
    let usr = await User.findById(req.body.user_id).exec();
    console.log(usr);
    res.status(200).send("hello");
});

app.get('/get_session', (req, res)=>{
    console.log(req);
    res.status(200).send("hello");
});

app.post('/end_session', (req, res)=>{
    console.log(req);
    res.status(200).send("hello");
});

app.post('/message', (req, res)=>{
    console.log(req);
    res.status(200).send("hello");
});