# GraphQL Reference

Quick reference for GraphQL (query language and runtime). Use `/` to search in vim.

## Table of Contents

- [GraphQL Reference](#graphql-reference)
  - [Table of Contents](#table-of-contents)
  - [Basics](#basics)
    - [What is GraphQL](#what-is-graphql)
    - [Schema](#schema)
    - [Types](#types)
  - [Queries](#queries)
    - [Basic Query](#basic-query)
    - [Arguments](#arguments)
    - [Aliases](#aliases)
    - [Fragments](#fragments)
    - [Variables](#variables)
    - [Directives](#directives)
  - [Mutations](#mutations)
    - [Basic Mutation](#basic-mutation)
    - [Multiple Mutations](#multiple-mutations)
    - [Input Types](#input-types)
  - [Subscriptions](#subscriptions)
  - [Schema Definition](#schema-definition)
    - [Type Definition](#type-definition)
    - [Scalar Types](#scalar-types)
    - [Enums](#enums)
    - [Interfaces](#interfaces)
    - [Unions](#unions)
  - [Resolvers](#resolvers)
  - [Common Patterns](#common-patterns)
    - [Pagination](#pagination)
    - [Error Handling](#error-handling)
    - [Authentication](#authentication)
  - [Tools](#tools)
    - [Apollo Server (Node.js)](#apollo-server-nodejs)
    - [Apollo Client (Frontend)](#apollo-client-frontend)
    - [Introspection](#introspection)

## Basics

### What is GraphQL

GraphQL is a query language for APIs that allows clients to request exactly what data they need.

```
Key benefits:
- Request only needed fields
- Strongly typed schema
- Single endpoint
- Built-in documentation
- Better developer experience
```

### Schema

A GraphQL schema defines the structure and capabilities of the API.

```graphql
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
```

### Types

GraphQL has several built-in scalar types:

```graphql
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
```

## Queries

### Basic Query

```graphql
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
```

### Arguments

Pass arguments to fields.

```graphql
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
```

### Aliases

Rename fields in response.

```graphql
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
```

### Fragments

Reuse field selections.

```graphql
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
```

### Variables

Pass dynamic values to queries.

```graphql
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

# Multiple variables
query GetUserAndPosts($userId: ID!, $limit: Int = 10) {
  user(id: $userId) {
    name
    posts(limit: $limit) {
      title
    }
  }
}
```

### Directives

Conditionally include/skip fields.

```graphql
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
```

## Mutations

### Basic Mutation

```graphql
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
```

### Multiple Mutations

Execute multiple mutations in order.

```graphql
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
```

### Input Types

```graphql
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
```

## Subscriptions

Real-time updates via WebSocket.

```graphql
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
```

## Schema Definition

### Type Definition

```graphql
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
```

### Scalar Types

```graphql
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
```

### Enums

```graphql
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
```

### Interfaces

```graphql
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
```

### Unions

```graphql
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
```

## Resolvers

Resolvers are functions that return data for fields.

```javascript
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
```

## Common Patterns

### Pagination

```graphql
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
```

### Error Handling

```graphql
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
```

### Authentication

```javascript
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
```

## Tools

### Apollo Server (Node.js)

```bash
npm install apollo-server graphql
```

```javascript
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
```

### Apollo Client (Frontend)

```bash
npm install @apollo/client graphql
```

```javascript
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
```

### Introspection

```graphql
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
```
