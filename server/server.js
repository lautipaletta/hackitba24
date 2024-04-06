const express = require('express'); 

const app = express(); 
const PORT = 3000; 

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

app.listen(PORT, (error) =>{ 
    if(!error) 
        console.log("Server is Successfully Running, and App is listening on port "+ PORT) 
    else 
        console.log("Error occurred, server can't start", error); 
    } 
);