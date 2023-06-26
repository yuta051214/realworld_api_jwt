# 参考記事・教材
[RealWorld Documentation](https://realworld-docs.netlify.app/docs/intro)  
GitHub 上の RealWorld のコードを参考に、User と Article に関する機能を実装。
Rails API モード、JWT(JSON Web Token) に関する実装を学習。

# User
- ユーザ登録 ( POST http://localhost:3000/api/users )  
  リクエスト Body ( JSON )  
  ```
  {
    "user": {
      "username": "foo bar",
      "email": "test1@test.com",
      "password": "password"
    }
  }
  ```
  ***

- ログイン ( POST http://localhost:3000/api/auth/login )  
  リクエスト Body ( JSON )  
  ```
  {
    "user": {
      "email": "test1@test.com",
      "password": "password"
    }
  }
  ```
  ***

# Article
- 投稿 ( POST http://localhost:3000/api/articles )  
  リクエスト Body ( JSON )  
  ```
  {
    "article": {
      "title": "How to train your dragon",
      "description": "Ever wonder how?",
      "body": "You have to believe"
    }
  }
  ```
  Authentication required
  ***

- 詳細 ( GET http://localhost:3000/api/articles/how-to-train-your-dragon )  
  No authentication required
  ***

- 一覧 ( GET http://localhost:3000/api/articles )  
  No authentication required
  ***

- 更新 ( PUT http://localhost:3000/api/articles/how-to-train-your-dragon )  
  リクエスト Body ( JSON )  
  ```
  {
    "article": {
      "title": "Did you train your dragon?"
    }
  }
  ```
  Authentication required
  ***

- 削除 ( POST http://localhost:3000/api/articles/did-you-train-your-dragon )  
  Authentication required
  ***
