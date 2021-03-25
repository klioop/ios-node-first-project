const mongoose = require("mongoose")
const validator = require("validator")

const userSchema = new mongoose.Schema({
    email: {
        type: String,
        unique: true,
        trim: true,
        required: true,
        lowercase: true,
        validate(value) {
            if (!validator.isEmail(value)) throw new Error ("Invalid Email!")
        }
    },
    password: {
        type: String,
        trim: true,
        required: true,
    },
    name: {
        type: String,
        trim: true,
    },
    authToken: {
        type: String
    }
}, {
    timestamps: true
})

const User = mongoose.model("User", userSchema)

module.exports = User