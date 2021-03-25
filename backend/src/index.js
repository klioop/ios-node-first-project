const { app } = require("./app")

const port = process.env.PORT || 3000

app.get("", async (req, res) => {
    res.send({
        firstMessage: "Hello World!"
    })
})

app.listen(port, () => {
    console.log("Server is up on port " + port)
})