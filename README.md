# Messenger

A GraphQL API for chatting.

# Setup

This project uses PostgreSQL database. So be sure to have that install before hand. You can install it via homebrew as follows, then follow the instructions on the screen to start the service:
```bash
$ brew install postgresql
```

I also use [Puma-dev](https://github.com/puma/puma-dev) to get a .test domain for the app. Install as follows, then follow the instructions on screen to setup.
```bash
$ brew install puma-dev
```

Finally, I use [GraphQL IDE](https://github.com/andev-software/graphql-ide), to run queries. [Download](https://github.com/andev-software/graphql-ide/releases/download/v1.1.1/GraphQL.IDE.zip)

Environment Options
Title: Development
Method: POST
URL: https://www.messenger.test/graphql

Clone the repo, setup the database and run migrations.

```bash
$ git clone git@github.com:aaronprice/messenger.git
$ cd messenger
$ bundle
$ bundle exec rails db:create
$ bundle exec rails db:migrate
```


# Queries to run

### Create a user
```
mutation UserSignUp {
  userSignUp(input: { name: "John Smith" }) {
    user {
      id
      name
      authToken
    }
    errors {
      field
      messages
    }
  }
}
```

After you've created a user, add the value of `authToken` to the environment header in GraphQL IDE with the key `X-USER-TOKEN`. You will be signed in as this user from this point on.

### Create a message
```
mutation ChatMessageCreate {
  chatMessageCreate(input: { 
    channelName: "general", 
    body: "Hello World!" 
  }) {
    message {
      body
      imageUrl
      author {
        id
        name
      }
      channel {
        name
      }
    }
    errors {
      field
      messages
    }
  }
}
```