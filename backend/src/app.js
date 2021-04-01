const express = require("express")
const app = express()
require("./db/mongoose")

const userRouter = require("./routers/user")
const postRouter = require("./routers/post")

app.use(express.json()) // It allows the express to automatically parse json
app.use(userRouter)
app.use(postRouter)

module.exports = { app }
