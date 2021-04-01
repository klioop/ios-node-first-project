const mongoose = require("mongoose")
const validator = require("validator")
const jwt = require("jsonwebtoken")
const bcrypt = require("bcryptjs")

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

userSchema.virtual("post", {
    ref: "Post",
    localField: "_id",
    foreignField: "userId"
})

userSchema.methods.toJSON = function () {
    const user = this
    const userObject = user.toObject()

    delete userObject.password
    delete userObject.authToken

    return userObject
}

userSchema.methods.generateAuthToken = async function () {
    const user  = this
    const token = jwt.sign({ _id: user._id.toString() }, process.env.JWT_SECRET)

    user.authToken = token
    await user.save()

    return token
}

userSchema.pre("save", async function(next) {
    const user = this

    if (user.isModified("password")) {
        user.password = await bcrypt.hash(user.password, 8)
    }

    next()
})

userSchema.statics.findByCredentials = async (email, password) => {
    const user = await User.findOne({ email })

    if (!user) throw new Error("Invalid Eamil")

    const isMatch = await bcrypt.compare(password, user.password)

    if (!isMatch) throw new Error("Invalid password")

    return user
}

const User = mongoose.model("User", userSchema)

module.exports = User