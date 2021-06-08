const { query } = require("express");
const express=require("express");

const server=express();
const bodyParser = require('body-parser');
const database=require("./database.js");



server.use(bodyParser.json());

// APIs for contacts
server.post("/signup",function(req,res){
    res.send("world");
    var data=req.body;
    var query="INSERT INTO user_data(name,phone_number,password) VALUES (\'"+data.name.toString()+"\',\'"+data.phone_number.toString()+"\',\'"+data.password.toString()+"\');";
    database.database_query(query);
});

server.post("/login",function(req,res){
    var data=req.body;
    database.login_query(data.phone_number,data.password,res);
});


server.post("/send_msg",function(req,res){
    var data=req.body;
    database.add_msg(data.sender,data.receiver,data.message,res);
});

server.get("/get_msg",function(req,res){
    var data=req.query;
    database.get_msg(data.receiver,res);
})

server.get("/conv_end",(req,res)=>{
    var data=req.query;
    var query="DELETE FROM message_data WHERE receiver=\'"+data.receiver+"\';";
    database.database_query(query,res);
})

server.listen(9000,'0.0.0.0')