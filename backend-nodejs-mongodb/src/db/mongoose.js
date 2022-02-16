const mongoose = require('mongoose');
const databaseURL = 'mongodb://127.0.0.1:27017/';
const databaseName = 'diary-app';

mongoose.connect(databaseURL+databaseName, (error)=>{
    if(error){
        throw Error(error)
    }
});

mongoose.createConnection(databaseURL+databaseName, (error, result)=>{
    if(error){
        throw Error(error);
    }
    console.log('Connected to database ! ');
});