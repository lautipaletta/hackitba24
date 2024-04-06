import OpenAI from "openai";
import fs from "fs";

import "dotenv/config";

const openai = new OpenAI({apiKey: process.env.OPENAI_KEY});

const Alicia_base_system_prompt = fs.readFileSync("./prompts/Alicia_system_prompt.txt").toString();
const Mauro_system_prompt = fs.readFileSync("./prompts/Mauro_system_prompt.txt").toString();
const Javier_system_prompt = fs.readFileSync("./prompts/Javier_system_prompt.txt").toString();

function message_list_to_conversation_list(messages) {
    return messages.map((message) => {
        const out = {content: message.content, role: message.role};
        return out;
    });
}

function message_list_to_conversation_string(messages) {
    let conversation = "";

    messages.forEach((message) => {
        conversation += `${(message.role == "user") ?  "USUARIO" : "ALICIA"}: ${message.content}`;
    });

    return conversation;
}

async function get_next_message_from_Alicia(messages, prev_summary) {
    const message_conversation_list = message_list_to_conversation_list(messages);
    const system_prompt = Alicia_base_system_prompt + (prev_summary ? `Ten en cuenta el siguiente resumen de la última conversación que tuviste con el usuario:\n${prev_summary}` : "");

    const completion = await openai.chat.completions.create({
        messages: [{role: "system", content: system_prompt}, ...message_conversation_list],
        model: "gpt-3.5-turbo"
    })

    return completion.choices[0].message.content;
}

async function get_session_summary_from_Mauro(messages) {
    const messages_as_conversation_string = message_list_to_conversation_string(messages);

    const completion = await openai.chat.completions.create({
        messages: [{role: "system", content: Mauro_system_prompt}, {role: "user", content: messages_as_conversation_string}],
        model: "gpt-3.5-turbo"
    })

    return completion.choices[0].message.content;
}

async function get_user_summary_from_Javier(current_summary, last_session_summary) {
    const user_prompt = "Current summary:\n" + (current_summary ?? "") + "\nLast session summary:\n" + last_session_summary;

    const completion = await openai.chat.completions.create({
        messages: [{role: "system", content: Javier_system_prompt}, {role: "user", content: user_prompt}],
        model: "gpt-3.5-turbo"
    })

    return completion.choices[0].message.content;
}

export {get_next_message_from_Alicia, get_session_summary_from_Mauro, get_user_summary_from_Javier};
