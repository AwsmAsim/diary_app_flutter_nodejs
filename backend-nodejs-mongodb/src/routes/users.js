const bcryptjs = require('bcryptjs');
const express = require('express')
const router = express.Router();
const User = require('../models/users')

router.post('/users', async (request, response)=>{
    console.log(request.body);
    
    const user = new User(request.body);
    try{
        await user.save();
        // console.log(user)
        response.status(201).send(user)
    }catch(error){
        response.status(400).send({error})
    }

})

router.patch('/users/:id', async (request, response) =>{
    
    const updates = ['names', 'email', 'password'] // Allowed fields 
    const reqFields = Object.keys(request.body)
    const isValidRequest = reqFields.every((update)=>{
        return updates.includes(update)
    })
    if(!isValidRequest){
        return response.status(404).send({error : 'Invalid Fields'})
    }

    try{
        const user = await User.findById(request.params.id)
        if(Object.keys(user).length==0){
            return response.status(404).send({error: 'User does not exist'});
        }
        response.status(200).send(user);
    }catch(error){
        response.status(500).send(error)
    }
})

// GET ALL USERS
router.get('/users', async (request, response)=>{

    try{
        const users = await User.find({});
        response.status(200).send(users);
    }catch(error){
        response.status(400).send({error});
    }

})

router.post('/users/login', async (request, response) =>{
    // request.body = {email: email, password: password}

    try{
        console.log(request.body);
        const user = await User.findOne({email: request.body.email});

        // No such email exists in database
        if(Object.keys(user).length == 0) return response.status(400).send({error: 'Invalid User id'})

        // validating password
        const validation = await bcryptjs.compare(request.body.password, user.password);
        if(validation){
            return response.status(200).send(user);
        }else{
            // console.log('Not Working');
            response.status(400).send({error: 'Invalid Credentials'});
        }
    }catch(error){
        response.status(500).send({error: 'Internal Server Error'})
    }
})

// GET USER WITH ID
router.get('/users/:id', async (request, response)=>{

    try{
        const users = await User.findById(request.body.id);
        if(Object.keys(users).length == 0){
            return response.status(400).send({error: 'User does not exist.'})
        }
        response.status(200).send(users);
    }catch(error){
        response.status(400).send({error});
    }

})



module.exports = router