# First ios Project 😀

This is my first ios project not follwoing tutorial.

튜토리얼을 무작정 따라 코드를 치지 않고 스스로 만들어본 첫 번째 ios 프로젝트 입니다.

## Stack

### Swift, NodeJs, MongoDB, Moongoose, JsonWebToken(JWT), BcryptJS


## MVP

The project is for building a MVP blog ios app with backend with nodeJS.<br>
It is for showcasing my swift skill and backend understanding to land a first ios developer job.

간단한 블로그 MVP 어플을 만들어 보았습니다. Backend 는 nodejs 로 구현했습니다. 이 프로젝트는 ios junior 개발자로써 제가 가지고 있는  swift 스킬과 backend 이해를 보여주는 것입니다. 


## Overall Functions (기본 기능들)

1. Sign up (회원가입)
2. Sign in (로그인)
3. Create a post (포스트 생성하기)
4. Read posts (포스트  불러오기)
5. Update a post (포스트 수정하기)
6. Delete a post (포스트 삭제하기)


## Details (구현한 기능에 관한 구체적 설명)

1. Users who only are signed up can write, read, update and delete posts.
2. To authenticate a users, after a user signs in, he or she is going to be given a access token, json web token, by the server.
3. Writing, reading a specific post, editing, and deleting a post requires the user to request with the access token.
4. The server checks the request and sees if the user has the autorizaton or not, and responds the each case.

1. 오직 회원가입한 유저만  블로그 포스팅을 쓰고 읽고 수정하고 삭제할 수 있다.
2. 로그인 여부를 확인하기 위해 서버는 로그인한 유저에게 access 토큰을 발행한다. access 토큰은 json 웹 토큰이다.
3. 블로그 포스팅을 쓰거나 읽거나 수정하거나 삭제하기 위해서 유저의 요청은 항상 토큰을 가지고 있어야 한다.
4. 서버는 요청을 확인하고 유저가 해당 요청의 권한을 가지고 있는지 확인한다. 그리고 권한여부에 따라 대응값을 보내준다.


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

