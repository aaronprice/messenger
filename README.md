# Messenger

A GraphQL API for chatting.

### Exercise

Implement a chat application that supports the following features:

1. As a consumer of the API, I can persist my chat messages
1. As a consumer of the API, I can persist messages in specific channels I join.
1. As a consumer of the API, I can see the list of all the available channels
1. As a consumer of the API, I can receive gif suggestions
1. As a consumer of the API, I can look up other users and channels
1. As a consumer of the API, I can see chat statistics of users and channels


### Reasoning and assumptions

I chose to focus on the Back-end primarily because that's where you said that you need to most help. It is also where I'm strongest. 

For the type of chat, I considered live chat via ActionCable, a simple REST API, and GraphQL. Ultimately I chose GraphQL because I believe it's the most powerfull, flexible, and full featured API I've worked with. I've setup mutations, and form objects to be build for scale. 

I've namespaced things to do with Users separately from Chat to demonstrate an easy way to prepare for scale.

All endpoints have been tested via RSpec.

In terms of service objects. I don't really see a need to include service objects in this application because of the simplicity, but for insight into how I would implement service objects, they would be setup as operations under each namespace as seen in the [back_ops](https://github.com/aaronprice/back_ops) gem I created.

In my opinion, services are only called after all data has been validated and persisted. 


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

### Query all messages in all channels

```
query Channels {
  channels {
    edges {
      node {
        id
        name
        messages {
          edges {
            node {
              id
              body
              imageUrl
              author {
                id
                name
              }
            }
          }
        }
      }
    }
  }
}
```

### Search for images
```
query Images {
  images(search: "funny") {
    id
    url
  }
}
```

### Query all users
```
query Users {
  users {
    id
    name
  }
}
```