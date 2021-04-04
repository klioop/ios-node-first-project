/**
 * @jest-environment node
 */
 const request  = require("supertest")
 const { app }  = require("../src/app")
const Post = require("../src/models/post")
 const {
     userOneId,
     userOne,
     postOne,
     postOneId,
     setupDatabase
 } = require("./fixtures/db")

beforeEach(setupDatabase)

test("Should sign up a user", async () => {
    await request(app).post("/users")
        .send({
            email: "c@d.com",
            name: "a",
            password: "123456"
        })
        .expect(201)
})

test("Should sign in a user", async () => {
    await request(app).post("/users/signin")
        .send({
            email: userOne.email,
            password: userOne.password
        })
        .expect(200)
})

test("Should create a post", async () => {
    const response = await request(app)
    .post("/users/posts")
    .set("Authorization", `Bearer ${userOne.authToken}`)
    .send({
            title: "test",
            body: "This is a temporary body for testing"
        })
        .expect(201)

    expect(response.body.success).toBe(true)
})

test("Should update a post", async() => {

    const response = await request(app)
        .post(`/users/posts/${postOneId}`)
        .set("Authorization",`Bearer ${userOne.authToken}`)
        .send({
            title: "Title has to be updated as this",
            body: "The body also has to be updated!"
        })
        .expect(200)

        expect(response.body.post.title).toBe("Title has to be updated as this")
})

test("Should delete a post", async() => {
    const response = await request(app)
        .delete(`/users/posts/${postOneId}`)
        .set("Authorization", `Bearer ${userOne.authToken}`)
        .send()
        .expect(200)

    expect(response.body.success).toBe(true)
})

