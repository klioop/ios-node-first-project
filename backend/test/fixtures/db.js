const mongoose = require("mongoose")

const jwt = require("jsonwebtoken")
const User = require("../../src/models/user")
const Post = require("../../src/models/post")


const userOneId = new mongoose.Types.ObjectId()
const userOne = {
    _id: userOneId,
    name: "Sam",
    email: "sam@email.com",
    authToken: jwt.sign({ _id: userOneId }, process.env.JWT_SECRET),
    password: "1234",
}

const postOneId = new mongoose.Types.ObjectId()

const postOne = {
    _id: postOneId,
    userId: userOneId,
    title: "post for test",
    body: "This is a body of this posting"
}

let posts = []
for (let i = 0; i < 30; i ++) {
    posts.push({
        userId: userOneId,
        title: `post for test ${i + 1}`,
        body: `This is ${i + 1} testing post.`
    })
}

const setupDatabase = async () => {
    await User.deleteMany()
    await Post.deleteMany()
    await new Post(postOne).save()
    await new User(userOne).save()
    posts.forEach( async (el) => {
        await new Post(el).save()
    })
}

module.exports = {
    userOneId,
    userOne,
    postOneId,
    postOne,
    setupDatabase
}
