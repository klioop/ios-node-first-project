const express = require("express")
const router  = new express.Router()
const auth = require("../middleware/auth")
const Post    = require("../models/post")

// API for getting posts wiht pagenation; for info, http post method is used
router.post("/posts", async (req, res) => {
    const POST_ITEM_PER_PAGE = 20

    let page = req.body.page
    console.log(req.body);

    try {
        const posts = await Post.find()
        .limit(POST_ITEM_PER_PAGE)
        .skip( POST_ITEM_PER_PAGE * page)
        .sort({
            createdAt: -1
        })

        res.send({
            success: true,
            posts
        })
    } catch(e) {
        res.status(400).send({
            success: false,
            message: e.message
        })
    }
})



module.exports = router