const express = require("express")
const router = new express.Router()
const User = require("../models/user")

router.post("/users", async (req, res) => {
    try {
        const user = new User(req.body)
        
        await user.save()

        const token = await user.generateAuthToken()

        res.status(201).send({
            success: true,
            user,
            token
        })
    } catch (e) {
        res.status(400).send({
            success: false,
            error: e.message
        })
    }
})

router.post("/users/signin", async (req, res) => {

    try {
        const user = await User.findByCredentials(req.body.email, req.body.password)
        const token = await user.generateAuthToken()

        res.send({ 
            success: true,
            user,
            token })
    } catch {
        res.status(400).send({
            success: false,
            message: e.message
        })
    }

})

module.exports = router