const {createPool}=require("mysql");
const pool=createPool({
    host:"localhost",
    user:"root",
    password:"abc123",
    database:"one_time_chat",
    connectionLimit:10,
    insecureAuth : true
})

function database_query(query,res){

    pool.query(query,(err,result,fields)=>{
        if(err){
            res.json({"status":"failed"});
            return console.log(err);
        }
        res.json({"status":"success"});
        return console.log(result);
    });
};

function login_query(number,pass,res){
    var query="SELECT password FROM user_data WHERE phone_number=\'"+number.toString()+"\';"
    pool.query(query,(err,result,fields)=>{
        if(err){
            res.json({"status":"failed"});
            return console.log(err);
        }
       
        if(result.length!=0 && result[0].password==pass){
            res.json({"status":"success"});
        }
        else{
            res.json({"status":"unsuccessful"});
        }
        return console.log(result);
    });
}

function add_msg(sender,receiver,msg,res){
    var check="SELECT phone_number FROM user_data WHERE phone_number=\'"+receiver+"\';";
    pool.query(check,(err,result,fields)=>{
        if(err){
            res.json({"status":"failed"});
            return console.log(err);
        }

        if(result.length!=0){
            
            var query="INSERT INTO message_data(sender,receiver,message) VALUES (\'"+sender+"\',\'"+receiver+"\',\'"+msg+"\');";
            console.log(query);
            database_query(query,res);
            
        }
        else{
            res.json({"status":"failed"});
        }
    })

};

function get_msg(user,res){
    var query="SELECT * FROM message_data WHERE receiver=\'"+user+"\';";
    var check_query="SELECT u.phone_number,u.name,m.message FROM user_data as u , message_data as m WHERE m.sender=u.phone_number;";
    pool.query(check_query,(err,result,fields)=>{
        var data=[];
        if(err){
            return console.log(err);
        }
        console.log(result);
        for (i=0;i<result.length;i++){
            
            var cur_data={"sender":result[i].phone_number,"message":result[i].message,"name":result[i].name};
            data.push(cur_data);
        }
        var obj={"status":"success","msg":data};
        
        res.json(obj);
        return console.log(obj);
    });
}
module.exports.get_msg=get_msg;
module.exports.add_msg=add_msg;
module.exports.login_query=login_query;
module.exports.database_query=database_query;