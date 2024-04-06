import OpenAI from "openai";

function messageListToConversationString(messages) {
    const conversation = "";

    messages.forEach((message) => { 
        conversation += `${(!message.sender) ? "ALICIA" : "USER"}: ${message.content}`;
    });

    return conversation;
}
