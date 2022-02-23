const express = require('express');
const router = express.Router();
const Diary = require('../models/diary')

// GET ALL DIARIES FOR A USER
router.get('/diary/:user', async (request, response)=>{
    console.log(request.params.user)

    const filter = {
        user : request.params.user
    }
    try{
        // request.body = {user : ObjectId}
        const diaries = await Diary.find(filter).sort({createdAt:-1});
        if(diaries.length == 0){
            return response.status(404).send({error: 'Invalid Request'})
        }
        response.status(200).send(diaries);
    }catch(error){
        response.status(500).send({error})
    }
})

// GET DIARY OF SPECIFIC DATE
router.get('/diary/:date', async (request, response)=>{
    const date = request.params.date;


    try{
        const diaries = await Diary.find({date});
        if(diaries.length == 0){
            return response.status(404).send({error: 'Invalid Request'})
        }
        response.status(200).send(diaries);
    }catch(error){
        response.status(500).send({error})
    }
})


router.patch('/diary/:id', async(request, response)=>{

    const allowedKeys = ['content']
    const providedKeys = Object.keys(request.body)
    const isValid = providedKeys.every((key)=>{{
        return allowedKeys.includes(key)
    }})
    if(!isValid){
        return response.status(404).send({error:'Invalid Request'})
    }

    try{
        const diary = await Diary.findById(request.params.id);

        // If no such diary exists
        if(Object.keys(diary).length == 0) return response.status(404).send({error : 'Invalid Request'})

        // Updating Diary
        providedKeys.forEach((key)=>{
            diary[key] = request.body[key];
        })
        await diary.save()
        response.status(200).send(diary);
    }catch(error){
        response.status(500).send({error})
    }

})

router.delete('/diary/:id', async (request, response)=>{
    try{
        const diary = await Diary.findByIdAndDelete(request.params.id);
        response.status(200).send(diary);
    }catch(error){
        response.status(500).send({error})
    }
})

router.post('/diary', async (request, response) => {

    const providedKeys = Object.keys(request.body);
    const allowedKeys = ['content',  'user', 'date'];
    const isValid = providedKeys.every((key)=>{
        console.log(key)
        return allowedKeys.includes(key)
    })

    if(!isValid){
        return response.status(404).send({error: 'Invlaid Request'})
    }

    const data = {
        date: request.body.date,
        content: request.body.content,
        user: request.body.user
    }

    try{
        const diary = new Diary(data);
        
        await diary.save();
        response.status(201).send(diary);
    }catch(error){
        response.status(500).send({error});
    }
})

module.exports = router;