*graphql.txt*  GraphQL Reference

==============================================================================
CONTENTS                                                    *graphql-contents*

1. Basics ................................ |graphql-basics|
   - What is GraphQL ..................... |graphql-what|
   - Schema .............................. |graphql-schema|
   - Types ............................... |graphql-types|
2. Queries ............................... |graphql-queries|
   - Basic Query ......................... |graphql-query-basic|
   - Arguments ........................... |graphql-arguments|
   - Aliases ............................. |graphql-aliases|
   - Fragments ........................... |graphql-fragments|
   - Variables ........................... |graphql-variables|
   - Directives .......................... |graphql-directives|
3. Mutations ............................. |graphql-mutations|
   - Basic Mutation ...................... |graphql-mutation-basic|
   - Multiple Mutations .................. |graphql-mutation-multiple|
   - Input Types ......................... |graphql-input-types|
4. Subscriptions ......................... |graphql-subscriptions|
5. Schema Definition ..................... |graphql-schema-def|
   - Type Definition ..................... |graphql-type-def|
   - Scalar Types ........................ |graphql-scalars|
   - Enums ............................... |graphql-enums|
   - Interfaces .......................... |graphql-interfaces|
   - Unions .............................. |graphql-unions|
6. Resolvers ............................. |graphql-resolvers|
7. Common Patterns ....................... |graphql-patterns|
   - Pagination .......................... |graphql-pagination|
   - Error Handling ...................... |graphql-errors|
   - Authentication ...................... |graphql-auth|
8. Tools ................................. |graphql-tools|
   - Apollo Server ....................... |graphql-apollo-server|
   - Apollo Client ....................... |graphql-apollo-client|
   - Introspection ....................... |graphql-introspection|

==============================================================================
1. BASICS                                                      *graphql-basics*

What is GraphQL~                                                *graphql-what*
>
    GraphQL is a query language for APIs that allows clients to request
    exactly what data they need.

    Key benefits:
    - Request only needed fields
    - Strongly typed schema
    - Single endpoint
    - Built-in documentation
    - Better developer experience
<

Schema~                                                        *graphql-schema*
>
    A GraphQL schema defines the structure and capabilities of the API.

    type Query {
      user(id: ID!): User
      users: [User!]!
      post(id: ID!): Post
    }

    type User {
      id: ID!
      name: String!
      email: String!
      posts: [Post!]!
    }

    type Post {
      id: ID!
      title: String!
      content: String
      author: User!
    }
<

Types~                                                          *graphql-types*
>
    # Scalars
    String      # Text
    Int         # 32-bit integer
    Float       # Floating point
    Boolean     # true/false
    ID          # Unique identifier
    DateTime    # ISO 8601 timestamp

    # Custom scalar
    scalar DateTime
    scalar JSON

    # Modifiers
    Type!       # Non-null (required)
    [Type]      # List (array)
    [Type!]!    # Non-null list of non-null items
<

==============================================================================
2. QUERIES                                                    *graphql-queries*

Basic Query~                                              *graphql-query-basic*
>
    # Simple query
    {
      user(id: "1") {
        name
        email
      }
    }

    # Response
    {
      "data": {
        "user": {
          "name": "John",
          "email": "john@example.com"
        }
      }
    }

    # Multiple root fields
    {
      user(id: "1") {
        name
      }
      post(id: "1") {
        title
      }
    }
<

Arguments~                                                  *graphql-arguments*
>
    # With arguments
    {
      user(id: "1") {
        name
      }
      posts(limit: 10, offset: 0) {
        id
        title
      }
    }

    # Multiple arguments
    {
      users(first: 10, after: "cursor", sort: "name") {
        id
        name
      }
    }
<

Aliases~                                                      *graphql-aliases*
>
    {
      user1: user(id: "1") {
        name
      }
      user2: user(id: "2") {
        name
      }
    }

    # Response
    {
      "data": {
        "user1": { "name": "John" },
        "user2": { "name": "Jane" }
      }
    }
<

Fragments~                                                  *graphql-fragments*
>
    fragment UserFields on User {
      id
      name
      email
    }

    {
      user(id: "1") {
        ...UserFields
      }
    }

    # Named fragments
    fragment UserInfo on User {
      id
      name
      email
      createdAt
    }

    {
      author: user(id: "1") {
        ...UserInfo
      }
      editor: user(id: "2") {
        ...UserInfo
      }
    }

    # Inline fragments (for unions/interfaces)
    {
      search(term: "graphql") {
        ... on Post {
          title
          content
        }
        ... on User {
          name
          email
        }
      }
    }
<

Variables~                                                  *graphql-variables*
>
    # Query with variables
    query GetUser($userId: ID!) {
      user(id: $userId) {
        id
        name
        email
      }
    }

    # Variables object
    {
      "userId": "1"
    }

    # Multiple variables with defaults
    query GetUserAndPosts($userId: ID!, $limit: Int = 10) {
      user(id: $userId) {
        name
        posts(limit: $limit) {
          title
        }
      }
    }
<

Directives~                                                *graphql-directives*
>
    # @include directive (include if true)
    query GetUser($userId: ID!, $includeEmail: Boolean!) {
      user(id: $userId) {
        name
        email @include(if: $includeEmail)
      }
    }

    # @skip directive (skip if true)
    query GetUser($userId: ID!, $skipEmail: Boolean!) {
      user(id: $userId) {
        name
        email @skip(if: $skipEmail)
      }
    }

    # Custom directives
    query GetUser {
      user(id: "1") {
        name @deprecated(reason: "Use fullName")
      }
    }
<

==============================================================================
3. MUTATIONS                                                *graphql-mutations*

Basic Mutation~                                        *graphql-mutation-basic*
>
    # Define mutation in schema
    type Mutation {
      createUser(input: CreateUserInput!): User
      updateUser(id: ID!, input: UpdateUserInput!): User
      deleteUser(id: ID!): Boolean
    }

    # Execute mutation
    mutation CreateUser($name: String!, $email: String!) {
      createUser(input: { name: $name, email: $email }) {
        id
        name
        email
      }
    }

    # Variables
    {
      "name": "John",
      "email": "john@example.com"
    }
<

Multiple Mutations~                                  *graphql-mutation-multiple*
>
    mutation CreateUserAndPost {
      createUser: createUser(input: { name: "John" }) {
        id
        name
      }
      createPost: createPost(input: { title: "Hello" }) {
        id
        title
      }
    }
<

Input Types~                                              *graphql-input-types*
>
    # Define input type
    input CreateUserInput {
      name: String!
      email: String!
      age: Int
    }

    input UpdateUserInput {
      name: String
      email: String
      age: Int
    }

    # Use in mutation
    mutation CreateUser($input: CreateUserInput!) {
      createUser(input: $input) {
        id
        name
      }
    }
<

==============================================================================
4. SUBSCRIPTIONS                                        *graphql-subscriptions*

Real-time updates via WebSocket.~                 *graphql-subscriptions-usage*
>
    # Define subscription
    type Subscription {
      userCreated: User
      postUpdated(id: ID!): Post
      messageReceived: Message
    }

    # Subscribe
    subscription OnUserCreated {
      userCreated {
        id
        name
      }
    }

    # Server sends updates
    {
      "data": {
        "userCreated": {
          "id": "123",
          "name": "John"
        }
      }
    }
<

==============================================================================
5. SCHEMA DEFINITION                                       *graphql-schema-def*

Type Definition~                                            *graphql-type-def*
>
    # Object type
    type User {
      id: ID!
      name: String!
      email: String!
      createdAt: DateTime!
    }

    # Query type (entry point)
    type Query {
      user(id: ID!): User
      users: [User!]!
    }

    # Mutation type
    type Mutation {
      createUser(input: CreateUserInput!): User
    }

    # Subscription type
    type Subscription {
      userCreated: User
    }

    # Root types must be defined
    schema {
      query: Query
      mutation: Mutation
      subscription: Subscription
    }
<

Scalar Types~                                                *graphql-scalars*
>
    # Built-in scalars
    String
    Int
    Float
    Boolean
    ID

    # Custom scalars
    scalar DateTime
    scalar JSON
    scalar Upload
    scalar BigInt

    # Implementation
    import { GraphQLScalarType } from 'graphql';

    const DateTimeScalar = new GraphQLScalarType({
      name: 'DateTime',
      parseValue(value) {
        return new Date(value);
      },
      serialize(value) {
        return value.toISOString();
      },
      parseLiteral(ast) {
        return new Date(ast.value);
      }
    });
<

Enums~                                                          *graphql-enums*
>
    # Enum type
    enum UserRole {
      ADMIN
      USER
      GUEST
    }

    enum OrderStatus {
      PENDING
      PROCESSING
      COMPLETED
      CANCELLED
    }

    # Use in type
    type User {
      role: UserRole!
      status: OrderStatus!
    }

    # In query
    {
      users(role: ADMIN) {
        name
      }
    }
<

Interfaces~                                                *graphql-interfaces*
>
    # Interface definition
    interface Node {
      id: ID!
      createdAt: DateTime!
    }

    # Implement interface
    type User implements Node {
      id: ID!
      createdAt: DateTime!
      name: String!
      email: String!
    }

    type Post implements Node {
      id: ID!
      createdAt: DateTime!
      title: String!
      content: String
    }

    # Query interface
    {
      nodes {
        id
        ... on User {
          name
        }
        ... on Post {
          title
        }
      }
    }
<

Unions~                                                        *graphql-unions*
>
    # Union type
    union SearchResult = Post | User | Comment

    # Query union
    type Query {
      search(term: String!): [SearchResult!]!
    }

    # Use in query
    {
      search(term: "graphql") {
        ... on Post {
          title
          content
        }
        ... on User {
          name
          email
        }
        ... on Comment {
          text
        }
      }
    }
<

==============================================================================
6. RESOLVERS                                                *graphql-resolvers*

Resolvers are functions that return data for fields.~   *graphql-resolvers-def*
>
    // Apollo Server example
    const resolvers = {
      Query: {
        user: (parent, args, context, info) => {
          return db.user.findById(args.id);
        },
        users: () => {
          return db.user.findAll();
        },
      },

      User: {
        posts: (parent) => {
          return db.post.findByUserId(parent.id);
        },
      },

      Mutation: {
        createUser: (parent, args) => {
          return db.user.create(args.input);
        },
        updateUser: (parent, args) => {
          return db.user.update(args.id, args.input);
        },
      },
    };

    // Resolver parameters
    const resolvers = {
      Query: {
        user: (parent, args, context, info) => {
          // parent - parent object (unused in root Query)
          // args - arguments passed to field
          // context - shared context (auth, db, etc)
          // info - field info and query details
        },
      },
    };
<

==============================================================================
7. COMMON PATTERNS                                          *graphql-patterns*

Pagination~                                                *graphql-pagination*
>
    # Offset-based pagination
    type Query {
      users(limit: Int = 10, offset: Int = 0): UserConnection!
    }

    type UserConnection {
      total: Int!
      items: [User!]!
      hasMore: Boolean!
    }

    # Cursor-based pagination (better for large datasets)
    type Query {
      users(first: Int, after: String): UserEdge!
    }

    type UserEdge {
      edges: [UserNode!]!
      pageInfo: PageInfo!
    }

    type UserNode {
      cursor: String!
      node: User!
    }

    type PageInfo {
      hasNextPage: Boolean!
      endCursor: String
      hasPreviousPage: Boolean!
      startCursor: String
    }

    # Query
    {
      users(first: 10, after: "cursor_token") {
        pageInfo {
          hasNextPage
          endCursor
        }
        edges {
          cursor
          node {
            id
            name
          }
        }
      }
    }
<

Error Handling~                                               *graphql-errors*
>
    # Errors are always included in response
    {
      "data": {
        "user": null
      },
      "errors": [
        {
          "message": "User not found",
          "extensions": {
            "code": "NOT_FOUND"
          }
        }
      ]
    }

    # Custom error type
    type Error {
      message: String!
      code: String!
    }

    type UserResult {
      user: User
      error: Error
    }

    type Query {
      user(id: ID!): UserResult!
    }
<

Authentication~                                                 *graphql-auth*
>
    // Context with authenticated user
    const context = async ({ req }) => {
      const token = req.headers.authorization?.replace("Bearer ", "");
      const user = await verifyToken(token);

      return { user };
    };

    // Protected resolver
    const resolvers = {
      Query: {
        me: (parent, args, context) => {
          if (!context.user) {
            throw new Error("Not authenticated");
          }
          return context.user;
        },
      },
      Mutation: {
        updateUser: (parent, args, context) => {
          if (!context.user || context.user.role !== "ADMIN") {
            throw new Error("Not authorized");
          }
          return db.user.update(args.id, args.input);
        },
      },
    };
<

==============================================================================
8. TOOLS                                                       *graphql-tools*

Apollo Server (Node.js)~                              *graphql-apollo-server*
>
    npm install apollo-server graphql

    const { ApolloServer, gql } = require("apollo-server");

    const typeDefs = gql`
      type Query {
        hello: String
      }
    `;

    const resolvers = {
      Query: {
        hello: () => "Hello world",
      },
    };

    const server = new ApolloServer({
      typeDefs,
      resolvers,
    });

    server.listen().then(({ url }) => {
      console.log(`Server ready at ${url}`);
    });
<

Apollo Client (Frontend)~                             *graphql-apollo-client*
>
    npm install @apollo/client graphql

    import { ApolloClient, InMemoryCache, gql, useQuery } from "@apollo/client";
    import { HttpLink } from "@apollo/client/link/http";

    const client = new ApolloClient({
      link: new HttpLink({
        uri: "http://localhost:4000/graphql",
      }),
      cache: new InMemoryCache(),
    });

    const GET_USER = gql`
      query GetUser($id: ID!) {
        user(id: $id) {
          id
          name
          email
        }
      }
    `;

    function UserComponent() {
      const { loading, error, data } = useQuery(GET_USER, {
        variables: { id: "1" },
      });

      if (loading) return <p>Loading...</p>;
      if (error) return <p>Error: {error.message}</p>;

      return <h1>{data.user.name}</h1>;
    }
<

Introspection~                                          *graphql-introspection*
>
    # Query schema
    {
      __schema {
        types {
          name
          description
        }
      }
    }

    # Query type
    {
      __type(name: "User") {
        name
        fields {
          name
          type {
            name
          }
        }
      }
    }

    # Enables IDE autocompletion and documentation
<

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
