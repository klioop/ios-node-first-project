# First ios Project ๐

This is my first ios project not follwoing tutorial.

ํํ ๋ฆฌ์ผ์ ๋ฌด์์  ๋ฐ๋ผ ์ฝ๋๋ฅผ ์น์ง ์๊ณ  ์ค์ค๋ก ๋ง๋ค์ด๋ณธ ์ฒซ ๋ฒ์งธ ios ํ๋ก์ ํธ ์๋๋ค.

## Stack

### Swift, NodeJs, MongoDB, Moongoose, JsonWebToken(JWT), BcryptJS


## MVP

The project is for building a MVP blog ios app with backend with nodeJS.<br>
It is for showcasing my swift skill and backend understanding to land a first ios developer job.

๊ฐ๋จํ ๋ธ๋ก๊ทธ MVP ์ดํ์ ๋ง๋ค์ด ๋ณด์์ต๋๋ค. Backend ๋ nodejs ๋ก ๊ตฌํํ์ต๋๋ค. ์ด ํ๋ก์ ํธ๋ ios junior ๊ฐ๋ฐ์๋ก์จ ์ ๊ฐ ๊ฐ์ง๊ณ  ์๋  swift ์คํฌ๊ณผ backend ์ดํด๋ฅผ ๋ณด์ฌ์ฃผ๋ ๊ฒ์๋๋ค. 


## Overall Functions (๊ธฐ๋ณธ ๊ธฐ๋ฅ๋ค)

1. Sign up (ํ์๊ฐ์)
2. Sign in (๋ก๊ทธ์ธ)
3. Create a post (ํฌ์คํธ ์์ฑํ๊ธฐ)
4. Read posts (ํฌ์คํธ  ๋ถ๋ฌ์ค๊ธฐ)
5. Update a post (ํฌ์คํธ ์์ ํ๊ธฐ)
6. Delete a post (ํฌ์คํธ ์ญ์ ํ๊ธฐ)


## Details (๊ตฌํํ ๊ธฐ๋ฅ์ ๊ดํ ๊ตฌ์ฒด์  ์ค๋ช)

1. Users who only are signed up can write, read, update and delete posts.
2. To authenticate a users, after a user signs in, he or she is going to be given a access token, json web token, by the server.
3. Writing, reading a specific post, editing, and deleting a post requires the user to request with the access token.
4. The server checks the request and sees if the user has the autorizaton or not, and responds the each case.

1. ์ค์ง ํ์๊ฐ์ํ ์ ์ ๋ง  ๋ธ๋ก๊ทธ ํฌ์คํ์ ์ฐ๊ณ  ์ฝ๊ณ  ์์ ํ๊ณ  ์ญ์ ํ  ์ ์๋ค.
2. ๋ก๊ทธ์ธ ์ฌ๋ถ๋ฅผ ํ์ธํ๊ธฐ ์ํด ์๋ฒ๋ ๋ก๊ทธ์ธํ ์ ์ ์๊ฒ access ํ ํฐ์ ๋ฐํํ๋ค. access ํ ํฐ์ json ์น ํ ํฐ์ด๋ค.
3. ๋ธ๋ก๊ทธ ํฌ์คํ์ ์ฐ๊ฑฐ๋ ์ฝ๊ฑฐ๋ ์์ ํ๊ฑฐ๋ ์ญ์ ํ๊ธฐ ์ํด์ ์ ์ ์ ์์ฒญ์ ํญ์ ํ ํฐ์ ๊ฐ์ง๊ณ  ์์ด์ผ ํ๋ค.
4. ์๋ฒ๋ ์์ฒญ์ ํ์ธํ๊ณ  ์ ์ ๊ฐ ํด๋น ์์ฒญ์ ๊ถํ์ ๊ฐ์ง๊ณ  ์๋์ง ํ์ธํ๋ค. ๊ทธ๋ฆฌ๊ณ  ๊ถํ์ฌ๋ถ์ ๋ฐ๋ผ ๋์๊ฐ์ ๋ณด๋ด์ค๋ค.


### [ios]
1. Http post request not using library such as Almorfire. I am also able to do it with Almorfire. 
2. I try to follow MVC pattern for organizing overall code, but not strictly.
3. Delegate pattern is used to transer data between view controllers.
4. Storyboard is used for layout.
5. I try to keep retain cycle from taking place.

### [backend]
1. Endpoints are made.
2. Basic unit tests are executed.
3. To authenticate a user, the way of using middle ware is used.
4. Arcitecture is not that strictly organized. The main focus of this project is on swift.

## Design and functions

This is a mvp app.
Design and functions would be continuously updated.

