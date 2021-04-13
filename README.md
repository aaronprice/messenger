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


### Reasoning, Assumptions, and Growth

I chose to focus on the Back-end primarily because that's where you said that you need to most help. It is also where I'm strongest. 

For the type of chat, I considered live chat via ActionCable, a simple REST API, and GraphQL. Ultimately I chose GraphQL because I believe it's the most powerfull, flexible, and full featured API to worked with. I've setup mutations and form objects, and namespaced them under each feature set (Users, and Chats) to be prepare for scale. 

Namespaces are consistent across GraphQL (front-end of the back-end) and Services (back-end of the back-end).

All endpoints have been tested via RSpec.

I've created a simple service that updates that stats for a channel after a message has been posted. I realize the functionality could be pulled off by cache counters in Rails, but I built the service to illustrate how I would implement a service in this architecture.

I am definitely looking forward to some feedback on the work, though. Likes, dislikes, etc.

I see many areas in which this application could grow. It could very well be the foundation of an app like slack, with direct messaging, threads, emojies, mentions, etc.

# Setup

This project uses PostgreSQL database. So be sure to have that installed before hand. You can install it via homebrew as follows, then follow the instructions on the screen to start the service:
```bash
$ brew install postgresql
```

I also use [Puma-dev](https://github.com/puma/puma-dev) to get a `.test` domain for the app. Install as follows, then follow the instructions on screen to setup.
```bash
$ brew install puma-dev
```
**NOTE:** Be sure to symlink the app directory into `~/.puma-dev/`

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

To run the tests:
```bash
$ bundle exec rspec spec
```

Because this app uses background jobs, you'll need to spin up a sidekiq worker as follows:
```
bundle exec sidekiq
```

You can then monitor and manage the jobs at [https://www.messenger.test/sidekiq](https://www.messenger.test/sidekiq).


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

**NOTE:** I do not consider this type of authentication production ready.


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
        usersCount
        messagesCount
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
        usersCount
        messagesCount
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

GraphQL comes with pagination built in, see [here](https://graphql.org/learn/pagination/#pagination-and-edges) for how to use it.

Both Channels, and Messages are paginated.

An easy improvement to this would be to filter channels by name.

### Search for images

Images from Giphy. 

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
    edges {
      node {
        id
        name
      }
    }
  }
}
```

Users has also been paginated, see [here](https://graphql.org/learn/pagination/#pagination-and-edges) for how to use it.

An easy way to improve this feature would be to filter users based on name.