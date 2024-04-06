import OpenAI from "openai";
import fs from "fs";

import "dotenv/config";

const openai = new OpenAI({apiKey: process.env.OPENAI_KEY});

const Alicia_base_system_prompt = fs.readFileSync("./prompts/Alicia_system_prompt.txt").toString();
const Mauro_system_prompt = fs.readFileSync("./prompts/Mauro_system_prompt.txt").toString();

function message_list_to_conversation_list(messages) {
    return messages.map((message) => {
        const out = {role: (!message.user_id) ? "assistant" : "user", content: message.content};
        return out;
    });
}

function message_list_to_conversation_string(messages) {
    const conversation = "";

    messages.forEach((message) => {
        conversation += `${(!message.user_id) ? "ALICIA" : "USUARIO"}: ${message.content}`;
    });

    return conversation;
}

async function get_next_message_from_Alicia(messages, prev_summary) {
    const messages_as_conversation = message_list_to_conversation_list(messages);
    const system_prompt = Alicia_base_system_prompt + prev_summary ? `Ten en cuenta el siguiente resumen de la última conversación que tuviste con el usuario:\n${prev_summary}` : "";

    const completion = await openai.chat.completions.create({
        messages: [{role: "system", content: system_prompt}, ...messages_as_conversation],
        model: "gpt-3.5-turbo"
    })

    return completion.choices[0].message;
}

async function get_session_summary_from_Mauro(messages) {
    const messages_as_conversation_string = message_list_to_conversation_string(messages);

    const completion = await openai.chat.completions.create({
        messages: [{role: "system", content: Mauro_system_prompt}, {role: "user", content: messages_as_conversation_string}],
        model: "gpt-3.5-turbo"
    })

    return completion.choices[0].message;
}

export {get_next_message_from_Alicia, get_session_summary_from_Mauro};
