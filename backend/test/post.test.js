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


test("Should get posts with pagenation", async () => {
    const response = await request(app)
        .post("/posts")
        .send({ page: 1 })
        .expect(200)

        console.log(response.body)

        expect(response.body.posts[0].title).toBe("post for test 11")
})
