const mongoose = require("mongoose")
const User = require("../../src/models/user")

const userOneId = new mongoose.Types.ObjectId()
const userOne = {
    _id: userOneId,
    name: "Sam",
    email: "sam@email.com",
    password: "123456",
} 

const setupDatabase = async () => {
    await User.deleteMany()
    await new User(userOne).save()
}

module.exports = {
    userOneId,
    userOne,
    setupDatabase
}
