import express from "express";
import mongoose from "mongoose";

const app = express(); 
const PORT = 3000; 

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

const database = new mongoose.Schema({
    users: [user]
});

const Database = mongoose.model("Database", database);

// Juan
const juan = new User({_id: "1234", name:"juan", sessions: []});

const db = new Database({users:[juan]});
console.log(db);

app.get('/start_session', (req, res)=>{ 
    console.log(req);
    res.status(200).send("hello");
});

app.get('/get_session', (req, res)=>{ 
    console.log(req);
    res.status(200).send("hello");
});

app.get('/end_session', (req, res)=>{ 
    console.log(req);
    res.status(200).send("hello");
});

app.get('/message', (req, res)=>{ 
    console.log(req);
    res.status(200).send("hello");
});