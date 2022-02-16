const mongoose = require('mongoose');
const validator = require('validator');
const bcryptjs = require('bcryptjs');

const userSchema = mongoose.Schema({
    name : {
        type: String,
        required: true,
        trim: true
    },
    email : {
        type: String,
        required: true,
        unique: true,
        trim: true,
        lowercase: true,
        validate(email){
            if(!validator.isEmail(email)){
                throw new Error('Invalid Email')
            }
        }
    },
    password: {
        type: String,
        required: true,
        trim: true,
        minLength: [8, 'Password too short']
    }
    // diaries: [{
    //     type: mongoose.Schema.Types.ObjectId,
    //     ref: 'Diary'
    // }]
},
{timestamps: true}
)



userSchema.pre('save', async function(next){

    const user = this;
    if(user.isModified('password')){
        user.password = await bcryptjs.hash(user.password, 8);
        console.log(user.password)
    }

    next()
})

const User = mongoose.model('User', userSchema)

module.exports = User;