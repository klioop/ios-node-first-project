const express = require("express")
const app = express()

app.use(express.json()) // It allows the express to automatically parse json

module.exports = { app }
