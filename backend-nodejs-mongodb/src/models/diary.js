const mongoose = require('mongoose')

// console.log(Date().now())

const diarySchema = mongoose.Schema({
    date: {
        type: String,
    },
    content: {
        type: String,
        trim: true,
        required: true
    },

    // Foreign field to the User Collection
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User'
    }
},
{timestamps: true}
)

const Diary = mongoose.model('Diary', diarySchema);

module.exports = Diary;