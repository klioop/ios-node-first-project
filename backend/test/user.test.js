/**
 * @jest-environment node
 */
 const request  = require("supertest")
 const { app }  = require("../src/app")
 const {
     userOneId,
     userOne,
     setupDatabase
 } = require("./fixtures/db")

beforeEach(setupDatabase)

test("Should signUp a user", async () => {
    await request(app).post("/users")
        .send({
            email: "c@d.com",
            name: "a",
            password: "123456"
        })
        .expect(201)
})
