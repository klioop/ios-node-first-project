const mongoose = require("mongoose")

const messageSchema = new mongoose.Schema({
    content: {
        type: String
    },
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
        ref: "User"
    },
    roomId: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
        ref: "Room"
    }
}, {
    timestamps: true
})