import mongoose from "mongoose";

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

export {Message, User, Session};
