
const express = require("express");
const app = express();
const user = [{"id":1,"name":"harini"}];
app.use(express.json());
app.get("/",(req,res)=>
{
    // res.status(200).send("Hello");
    res.send("Hello, Welcome");
});

app.get("/users",(req,res)=>{
    res.json(user);
});

app.post("/users",(req,res)=>{
    user.push(req.body);
    res.send("Data Entered");
});




// const http = require('http');
// const fs = require('fs');

// const data = fs.readFileSync("./example.txt",{encoding:"utf8", flag:"r"});
// console.log(data);

// const server = http.createServer((req,res)=>
// {
//     const fs = require('fs');

//     fs.readFile('example.txt', 'utf8', (err, data) => {
//     if (err) {
//         console.error('Error reading file:', err);
//     return;
//     }
//     console.log('File contents:', data);
// });



    // const url = req.url;
    // if(url=="/")
    // {
    //     res.writeHead(200,{'content-type':'text/html'});
    //     res.end('<h1>Welcome to home page</h1>');
    // }
    // if(url=="/about")
    // {
    //     res.writeHead(200,{'content-type':'text/html'});
    //     res.end("<h1>Welcome to about page</h1>");
    // }
//     res.writeHead(200,{'content-type':'text/plain'});
//     res.end("Hello world");
// });

app.listen(3000,()=>
{
    console.log("Server is running...");
});