const mongoose = require("mongoose")

const roomSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
    },
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
        ref: "User"
    },
    lastMessageId:{
        type: mongoose.Types.ObjectId,
        ref: "Message"
    },
    lastMessageContent: {
        type: String
    },
    lastMessage: {
        type: Date,
    }
}, {
    timestamps: true
})

const Room = mongoose.model("Room", roomSchema)

module.exports = Room