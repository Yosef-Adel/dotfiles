# React Reference

Quick reference for React. Use `/` to search in vim.

## Table of Contents

- [React Reference](#react-reference)
  - [Table of Contents](#table-of-contents)
  - [Hooks](#hooks)
    - [useState](#usestate)
    - [useEffect](#useeffect)
    - [useContext](#usecontext)
    - [useRef](#useref)
    - [useMemo](#usememo)
    - [useCallback](#usecallback)
    - [useReducer](#usereducer)
    - [Custom Hooks](#custom-hooks)
  - [Component Patterns](#component-patterns)
    - [Conditional Rendering](#conditional-rendering)
    - [Lists and Keys](#lists-and-keys)
    - [Forms](#forms)
    - [Children Props](#children-props)
    - [Render Props](#render-props)
    - [Higher-Order Components (HOC)](#higher-order-components-hoc)
  - [Performance Optimization](#performance-optimization)
    - [React.memo](#reactmemo)
    - [Lazy Loading](#lazy-loading)
  - [Error Boundaries](#error-boundaries)
  - [Portals](#portals)
  - [React Router (v6)](#react-router-v6)
  - [Testing](#testing)
  - [State Management](#state-management)
  - [useLayoutEffect vs useEffect](#uselayouteffect-vs-useeffect)
  - [Server Components \& Next.js](#server-components--nextjs)
  - [Component Design Patterns](#component-design-patterns)
  - [Concurrent Features](#concurrent-features)
  - [Form Libraries](#form-libraries)
  - [Accessibility](#accessibility)

## Hooks

### useState

Manage state in functional components.

```jsx
import { useState } from "react";

function Counter() {
  const [count, setCount] = useState(0);

  return (
    <div>
      <p>Count: {count}</p>
      <button onClick={() => setCount(count + 1)}>Increment</button>
      <button onClick={() => setCount((c) => c + 1)}>
        Increment (functional)
      </button>
    </div>
  );
}

// With object state
function Form() {
  const [form, setForm] = useState({ name: "", email: "" });

  const updateField = (field, value) => {
    setForm((prev) => ({ ...prev, [field]: value }));
  };

  return (
    <input
      value={form.name}
      onChange={(e) => updateField("name", e.target.value)}
    />
  );
}
```

### useEffect

Side effects (data fetching, subscriptions, DOM manipulation).

```jsx
import { useEffect } from "react";

// Runs after every render
useEffect(() => {
  console.log("Component rendered");
});

// Runs once on mount
useEffect(() => {
  console.log("Component mounted");
}, []);

// Runs when dependencies change
useEffect(() => {
  console.log("Count changed:", count);
}, [count]);

// Cleanup function
useEffect(() => {
  const timer = setInterval(() => {
    console.log("Tick");
  }, 1000);

  return () => {
    clearInterval(timer);
  };
}, []);

// Fetch data example
useEffect(() => {
  async function fetchData() {
    const response = await fetch("/api/data");
    const data = await response.json();
    setData(data);
  }
  fetchData();
}, []);
```

### useContext

Access context values.

```jsx
import { createContext, useContext } from "react";

const ThemeContext = createContext("light");

function App() {
  return (
    <ThemeContext.Provider value="dark">
      <Child />
    </ThemeContext.Provider>
  );
}

function Child() {
  const theme = useContext(ThemeContext);
  return <div className={theme}>Content</div>;
}
```

### useRef

Reference DOM elements or persist values without re-rendering.

```jsx
import { useRef, useEffect } from "react";

// DOM reference
function Input() {
  const inputRef = useRef(null);

  useEffect(() => {
    inputRef.current.focus();
  }, []);

  return <input ref={inputRef} />;
}

// Persist value without re-render
function Timer() {
  const countRef = useRef(0);

  const increment = () => {
    countRef.current += 1;
    console.log(countRef.current); // Doesn't cause re-render
  };

  return <button onClick={increment}>Increment</button>;
}
```

### useMemo

Memoize expensive computations.

```jsx
import { useMemo } from "react";

function ExpensiveComponent({ items }) {
  const total = useMemo(() => {
    console.log("Calculating total...");
    return items.reduce((sum, item) => sum + item.price, 0);
  }, [items]); // Only recalculate when items change

  return <div>Total: {total}</div>;
}
```

### useCallback

Memoize callback functions.

```jsx
import { useCallback } from "react";

function Parent() {
  const [count, setCount] = useState(0);

  // Without useCallback, this creates new function on every render
  const handleClick = useCallback(() => {
    setCount((c) => c + 1);
  }, []); // Dependencies

  return <Child onClick={handleClick} />;
}

// Useful with React.memo
const Child = React.memo(({ onClick }) => {
  console.log("Child rendered");
  return <button onClick={onClick}>Click</button>;
});
```

### useReducer

Complex state logic (alternative to useState).

```jsx
import { useReducer } from "react";

const initialState = { count: 0 };

function reducer(state, action) {
  switch (action.type) {
    case "increment":
      return { count: state.count + 1 };
    case "decrement":
      return { count: state.count - 1 };
    case "reset":
      return initialState;
    default:
      throw new Error();
  }
}

function Counter() {
  const [state, dispatch] = useReducer(reducer, initialState);

  return (
    <>
      <p>Count: {state.count}</p>
      <button onClick={() => dispatch({ type: "increment" })}>+</button>
      <button onClick={() => dispatch({ type: "decrement" })}>-</button>
      <button onClick={() => dispatch({ type: "reset" })}>Reset</button>
    </>
  );
}
```

### Custom Hooks

Create reusable hooks.

```jsx
// useFetch hook
function useFetch(url) {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    async function fetchData() {
      try {
        const response = await fetch(url);
        const json = await response.json();
        setData(json);
      } catch (err) {
        setError(err);
      } finally {
        setLoading(false);
      }
    }
    fetchData();
  }, [url]);

  return { data, loading, error };
}

// Usage
function User({ userId }) {
  const { data, loading, error } = useFetch(`/api/users/${userId}`);

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error.message}</div>;
  return <div>{data.name}</div>;
}

// useLocalStorage hook
function useLocalStorage(key, initialValue) {
  const [value, setValue] = useState(() => {
    const item = localStorage.getItem(key);
    return item ? JSON.parse(item) : initialValue;
  });

  useEffect(() => {
    localStorage.setItem(key, JSON.stringify(value));
  }, [key, value]);

  return [value, setValue];
}

// Usage
function App() {
  const [name, setName] = useLocalStorage("name", "");
  return <input value={name} onChange={(e) => setName(e.target.value)} />;
}
```

## Component Patterns

### Conditional Rendering

```jsx
// If/else
function Greeting({ isLoggedIn }) {
  if (isLoggedIn) {
    return <h1>Welcome back!</h1>;
  }
  return <h1>Please sign in.</h1>;
}

// Ternary
function Status({ isActive }) {
  return <div>Status: {isActive ? "Active" : "Inactive"}</div>;
}

// Logical &&
function Notifications({ count }) {
  return <div>{count > 0 && <Badge count={count} />}</div>;
}
```

### Lists and Keys

```jsx
function UserList({ users }) {
  return (
    <ul>
      {users.map((user) => (
        <li key={user.id}>{user.name}</li>
      ))}
    </ul>
  );
}
```

### Forms

```jsx
function LoginForm() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  const handleSubmit = (e) => {
    e.preventDefault();
    console.log({ email, password });
  };

  return (
    <form onSubmit={handleSubmit}>
      <input
        type="email"
        value={email}
        onChange={(e) => setEmail(e.target.value)}
        placeholder="Email"
      />
      <input
        type="password"
        value={password}
        onChange={(e) => setPassword(e.target.value)}
        placeholder="Password"
      />
      <button type="submit">Login</button>
    </form>
  );
}

// Controlled checkbox
function Checkbox() {
  const [checked, setChecked] = useState(false);

  return (
    <input
      type="checkbox"
      checked={checked}
      onChange={(e) => setChecked(e.target.checked)}
    />
  );
}
```

### Children Props

```jsx
function Card({ children, title }) {
  return (
    <div className="card">
      <h2>{title}</h2>
      <div className="content">{children}</div>
    </div>
  );
}

// Usage
<Card title="My Card">
  <p>This is the content</p>
  <button>Click me</button>
</Card>;
```

### Render Props

```jsx
function Mouse({ render }) {
  const [position, setPosition] = useState({ x: 0, y: 0 });

  useEffect(() => {
    const handleMove = (e) => {
      setPosition({ x: e.clientX, y: e.clientY });
    };
    window.addEventListener("mousemove", handleMove);
    return () => window.removeEventListener("mousemove", handleMove);
  }, []);

  return render(position);
}

// Usage
<Mouse
  render={({ x, y }) => (
    <div>
      Mouse position: {x}, {y}
    </div>
  )}
/>;
```

### Higher-Order Components (HOC)

```jsx
function withLoading(Component) {
  return function WithLoadingComponent({ isLoading, ...props }) {
    if (isLoading) return <div>Loading...</div>;
    return <Component {...props} />;
  };
}

// Usage
const UserListWithLoading = withLoading(UserList);

<UserListWithLoading isLoading={loading} users={users} />;
```

## Performance Optimization

### React.memo

Prevent unnecessary re-renders.

```jsx
const ExpensiveComponent = React.memo(({ data }) => {
  console.log("Rendering ExpensiveComponent");
  return <div>{data}</div>;
});

// Only re-renders if data changes
```

### Lazy Loading

Code splitting for routes/components.

```jsx
import { lazy, Suspense } from "react";

const LazyComponent = lazy(() => import("./LazyComponent"));

function App() {
  return (
    <Suspense fallback={<div>Loading...</div>}>
      <LazyComponent />
    </Suspense>
  );
}
```

## Error Boundaries

```jsx
class ErrorBoundary extends React.Component {
  constructor(props) {
    super(props);
    this.state = { hasError: false };
  }

  static getDerivedStateFromError(error) {
    return { hasError: true };
  }

  componentDidCatch(error, errorInfo) {
    console.log("Error:", error, errorInfo);
  }

  render() {
    if (this.state.hasError) {
      return <h1>Something went wrong.</h1>;
    }
    return this.props.children;
  }
}

// Usage
<ErrorBoundary>
  <MyComponent />
</ErrorBoundary>;
```

## Portals

Render children into a different DOM node.

```jsx
import { createPortal } from "react-dom";

function Modal({ children }) {
  return createPortal(
    <div className="modal">{children}</div>,
    document.getElementById("modal-root")
  );
}
```

## React Router (v6)

````jsx
import {
  BrowserRouter,
  Routes,
  Route,
  Link,
  useNavigate,
  useParams,
} from "react-router-dom";

function App() {
  return (
    <BrowserRouter>
      <nav>

```jsx
// Custom Context Hook
const ThemeContext = createContext("light");

function ThemeProvider({ children }) {
  const [theme, setTheme] = useState("light");

  const toggleTheme = () => {
    setTheme((prev) => (prev === "light" ? "dark" : "light"));
  };

  return (
    <ThemeContext.Provider value={{ theme, toggleTheme }}>
      {children}
    </ThemeContext.Provider>
  );
}

function useTheme() {
  const context = useContext(ThemeContext);
  if (!context) {
    throw new Error("useTheme must be used within ThemeProvider");
  }
  return context;
}

// Usage
function App() {
  return (
    <ThemeProvider>
      <Header />
    </ThemeProvider>
  );
}

function Header() {
  const { theme, toggleTheme } = useTheme();
  return (
    <div className={theme}>
      <button onClick={toggleTheme}>Toggle Theme</button>
    </div>
  );
}

// Multiple Contexts
const AuthContext = createContext();
const NotificationContext = createContext();

function AppProviders({ children }) {
  return (
    <AuthProvider>
      <NotificationProvider>{children}</NotificationProvider>
    </AuthProvider>
  );
}
````

## Testing

```jsx
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import userEvent from '@testing-library/user-event';

// Basic test
test('renders greeting', () => {
  render(<Greeting name="John" />);
  expect(screen.getByText(/hello john/i)).toBeInTheDocument();
});

// Query methods
test('query examples', () => {
  render(<MyComponent />);

  // getBy - throws if not found
  screen.getByRole('button', { name: /submit/i });
  screen.getByLabelText('Username');
  screen.getByPlaceholderText('Enter name');
  screen.getByDisplayValue('existing value');

  // queryBy - returns null if not found
  expect(screen.queryByText('Not here')).not.toBeInTheDocument();

  // findBy - async, waits for element
  const button = await screen.findByRole('button');
});

// User interactions
test('user events', async () => {
  const user = userEvent.setup();
  render(<LoginForm />);

  await user.type(screen.getByLabelText('Email'), 'test@example.com');
  await user.click(screen.getByRole('button', { name: /login/i }));

  await waitFor(() => {
    expect(screen.getByText('Welcome')).toBeInTheDocument();
  });
});

// Testing hooks
test('useCounter hook', () => {
  const { result } = renderHook(() => useCounter());

  expect(result.current.count).toBe(0);

  act(() => {
    result.current.increment();
  });

  expect(result.current.count).toBe(1);
});
```

## State Management

```jsx
// Zustand (simple state management)
import create from "zustand";

const useStore = create((set) => ({
  count: 0,
  increment: () => set((state) => ({ count: state.count + 1 })),
  decrement: () => set((state) => ({ count: state.count - 1 })),
}));

function Counter() {
  const { count, increment, decrement } = useStore();
  return (
    <div>
      <p>{count}</p>
      <button onClick={increment}>+</button>
      <button onClick={decrement}>-</button>
    </div>
  );
}

// Redux (complex state)
const counterSlice = createSlice({
  name: "counter",
  initialState: { value: 0 },
  reducers: {
    increment: (state) => {
      state.value += 1;
    },
    decrement: (state) => {
      state.value -= 1;
    },
  },
});

function App() {
  return (
    <Provider store={store}>
      <Counter />
    </Provider>
  );
}
```

## useLayoutEffect vs useEffect

```jsx
// useEffect - runs after paint (preferred for most cases)
function Component() {
  useEffect(() => {
    // Runs AFTER DOM painted, won't block rendering
    console.log("After paint");
  }, []);

  return <div>Content</div>;
}

// useLayoutEffect - runs before paint (for DOM measurements)
function Tooltip() {
  const [position, setPosition] = useState(null);
  const ref = useRef();

  useLayoutEffect(() => {
    // Runs BEFORE paint, can measure DOM
    const rect = ref.current.getBoundingClientRect();
    setPosition({ x: rect.x, y: rect.y });
  }, []);

  return (
    <div ref={ref}>
      Tooltip at {position?.x}, {position?.y}
    </div>
  );
}

// Typical use cases:
// useEffect: data fetching, subscriptions, logging
// useLayoutEffect: DOM measurements, animations, style calculations
```

## Server Components & Next.js

```jsx
// Server Component (default in Next.js 13+)
// Can access database, secrets directly
async function PostList() {
  const posts = await db.post.findMany();
  return (
    <ul>
      {posts.map((post) => (
        <li key={post.id}>{post.title}</li>
      ))}
    </ul>
  );
}

// Client Component - enable interactivity
("use client");

function SearchPosts({ posts }) {
  const [search, setSearch] = useState("");
  return (
    <div>
      <input value={search} onChange={(e) => setSearch(e.target.value)} />
      {/* filter posts by search */}
    </div>
  );
}

// Server Actions - call server from client
("use server");

export async function createPost(formData) {
  const title = formData.get("title");
  await db.post.create({ title });
  revalidatePath("/posts");
}

// Use in client component
("use client");

function NewPostForm() {
  return (
    <form action={createPost}>
      <input name="title" />
      <button type="submit">Create</button>
    </form>
  );
}
```

## Component Design Patterns

```jsx
// Compound Components Pattern
const Tabs = ({ children }) => {
  const [active, setActive] = useState(0);
  return (
    <TabsContext.Provider value={{ active, setActive }}>
      {children}
    </TabsContext.Provider>
  );
};

Tabs.List = ({ children }) => <div className="tabs-list">{children}</div>;
Tabs.Tab = ({ children, index }) => {
  const { active, setActive } = useContext(TabsContext);
  return (
    <button
      className={active === index ? "active" : ""}
      onClick={() => setActive(index)}
    >
      {children}
    </button>
  );
};

Tabs.Content = ({ children, index }) => {
  const { active } = useContext(TabsContext);
  return active === index ? children : null;
};

// Usage
<Tabs>
  <Tabs.List>
    <Tabs.Tab index={0}>Tab 1</Tabs.Tab>
    <Tabs.Tab index={1}>Tab 2</Tabs.Tab>
  </Tabs.List>
  <Tabs.Content index={0}>Content 1</Tabs.Content>
  <Tabs.Content index={1}>Content 2</Tabs.Content>
</Tabs>;
```

## Concurrent Features

```jsx
// useTransition - mark updates as non-urgent
function SearchUsers() {
  const [query, setQuery] = useState("");
  const [isPending, startTransition] = useTransition();

  const handleChange = (e) => {
    startTransition(() => {
      setQuery(e.target.value);
    });
  };

  return (
    <div>
      <input onChange={handleChange} />
      {isPending && <Spinner />}
    </div>
  );
}

// useDeferredValue - deferred state update
function SearchResults({ query }) {
  const deferredQuery = useDeferredValue(query);
  const results = useMemo(
    () => expensiveSearch(deferredQuery),
    [deferredQuery]
  );

  return (
    <div>
      {deferredQuery !== query && <span>Updating...</span>}
      <Results results={results} />
    </div>
  );
}
```

## Form Libraries

```jsx
// React Hook Form
import { useForm } from "react-hook-form";

function LoginForm() {
  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm({
    mode: "onChange",
  });

  const onSubmit = (data) => {
    console.log(data); // { email: '...', password: '...' }
  };

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input
        {...register("email", {
          required: "Email is required",
          pattern: { value: /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$/i },
        })}
      />
      {errors.email && <span>{errors.email.message}</span>}

      <input {...register("password", { minLength: 8 })} />
      {errors.password && <span>Min 8 characters</span>}

      <button type="submit">Login</button>
    </form>
  );
}
```

## Accessibility

```jsx
// Using semantic HTML
function Navigation() {
  return (
    <nav aria-label="Main navigation">
      <ul>
        <li>
          <a href="/">Home</a>
        </li>
        <li>
          <a href="/about">About</a>
        </li>
      </ul>
    </nav>
  );
}

// ARIA attributes
function Modal({ isOpen, onClose }) {
  return (
    <div
      role="dialog"
      aria-modal="true"
      aria-labelledby="dialog-title"
      aria-hidden={!isOpen}
    >
      <h2 id="dialog-title">Dialog Title</h2>
      <button aria-label="Close dialog" onClick={onClose}>
        ×
      </button>
    </div>
  );
}

// Keyboard navigation
function Button({ children, onClick }) {
  return (
    <button
      onClick={onClick}
      onKeyDown={(e) => {
        if (e.key === "Enter" || e.key === " ") {
          onClick();
        }
      }}
    >
      {children}
    </button>
  );
}
```

```

```
