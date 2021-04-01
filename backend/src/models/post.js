const mongoose = require("mongoose")

const PostSchema = new mongoose.Schema({
    
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
        ref: "User"
    },
    title:{
        type: String
    },
    body: {
        type: String
    },
}, {
    timestamps: true
})

const Post = mongoose.model("Post", PostSchema)

module.exports = Post