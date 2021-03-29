const jwt = require("jsonwebtoken")
const User = require("../models/user")

const auth = async (req, res, next) => {

    try {
        const token   = req.header("Authorization").replace("Bearer ", "")
        const decoded = jwt.verify(token, "secret")
        const user    = await User.findOne( { _id: decoded._id, authToken: token })

        if (!user) throw new Error()

        req.token = token
        req.user  = user

    } catch(e) {
        res.send(401).send({ error: "Please Authenticate" })
    }
}

module.exports = auth