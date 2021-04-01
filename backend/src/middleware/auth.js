const jwt = require("jsonwebtoken")
const User = require("../models/user")

const auth = async (req, res, next) => {

    try {
        const token   = req.header("Authorization").replace("Bearer ", "")
        const decoded = jwt.verify(token, process.env.JWT_SECRET)
        const user    = await User.findOne( { _id: decoded._id, authToken: token })

        if (!user) throw new Error()

        req.token = token
        req.user  = user
        next()

    } catch(e) {
        res.send(401).send({
             auth: false,
             error: "Please Authenticate"
             })
    }
}

module.exports = auth