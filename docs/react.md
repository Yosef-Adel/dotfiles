*react.txt*  React Reference

==============================================================================
CONTENTS                                                     *react-contents*

1. JSX Basics ............................ |react-jsx|
2. Components ............................ |react-components|
3. Hooks ................................. |react-hooks|
4. State Management ...................... |react-state|
5. Effects ............................... |react-effects|
6. Context ............................... |react-context|
7. Refs .................................. |react-refs|
8. Memoization ........................... |react-memo|
9. Forms ................................. |react-forms|
10. Router ............................... |react-router|
11. Patterns ............................. |react-patterns|
12. Performance .......................... |react-performance|
13. Testing .............................. |react-testing|

==============================================================================
1. JSX Basics                                                *react-jsx*

JSX Syntax~                                              *react-jsx-syntax*
    JavaScript XML. Write HTML-like code in JavaScript.
>
    // JSX elements
    const element = <h1>Hello World</h1>;
    const div = <div className="container">Content</div>;

    // JSX expressions
    const name = 'John';
    const greeting = <h1>Hello {name}</h1>;
    const sum = <p>Sum: {1 + 2}</p>;

    // Attributes
    <img src={imageUrl} alt="Description" />
    <button onClick={handleClick}>Click</button>
    <input type="text" value={value} onChange={handleChange} />

    // className (not class)
    <div className="my-class">Content</div>

    // Style as object
    <div style={{ color: 'red', fontSize: '20px' }}>Styled</div>

    // Self-closing tags
    <img src="image.jpg" />
    <input type="text" />
    <Component />
<

JSX Expressions~                                         *react-jsx-expressions*
>
    function Greeting({ user }) {
      return (
        <div>
          <h1>Hello {user.name}</h1>
          <p>Age: {user.age}</p>
          <p>Adult: {user.age >= 18 ? 'Yes' : 'No'}</p>
          <p>Math: {2 + 2}</p>
          <p>Call function: {formatDate(date)}</p>
        </div>
      );
    }
<

Conditional Rendering~                                  *react-conditional*
>
    // && operator
    function Greeting({ isLoggedIn, user }) {
      return (
        <div>
          {isLoggedIn && <p>Welcome back!</p>}
          {user && <p>Hello {user.name}</p>}
        </div>
      );
    }

    // Ternary operator
    function Status({ isOnline }) {
      return (
        <div>
          {isOnline ? <span>Online</span> : <span>Offline</span>}
        </div>
      );
    }

    // Early return
    function Dashboard({ user }) {
      if (!user) {
        return <div>Please log in</div>;
      }

      return <div>Welcome {user.name}</div>;
    }

    // Element variable
    function LoginButton({ isLoggedIn, onLogin, onLogout }) {
      let button;
      if (isLoggedIn) {
        button = <button onClick={onLogout}>Logout</button>;
      } else {
        button = <button onClick={onLogin}>Login</button>;
      }
      return button;
    }
<

List Rendering~                                          *react-lists*
>
    function UserList({ users }) {
      return (
        <ul>
          {users.map(user => (
            <li key={user.id}>
              {user.name} - {user.age}
            </li>
          ))}
        </ul>
      );
    }

    // With index (only if no stable id)
    function TodoList({ todos }) {
      return (
        <ul>
          {todos.map((todo, index) => (
            <li key={index}>{todo}</li>
          ))}
        </ul>
      );
    }

    // Filtering before rendering
    function ActiveUsers({ users }) {
      return (
        <ul>
          {users
            .filter(user => user.active)
            .map(user => (
              <li key={user.id}>{user.name}</li>
            ))}
        </ul>
      );
    }
<

Keys in Lists~                                           *react-keys*
    Keys help React identify changed/added/removed items.
>
    // Good - stable unique ID
    {items.map(item => (
      <Item key={item.id} data={item} />
    ))}

    // Bad - index as key (only if no other option)
    {items.map((item, index) => (
      <Item key={index} data={item} />
    ))}

    // Keys must be unique among siblings
    {users.map(user => (
      <div key={user.id}>
        {user.posts.map(post => (
          <Post key={post.id} {...post} />
        ))}
      </div>
    ))}
<

Event Handling~                                          *react-events*
>
    function Button() {
      // Event handler
      const handleClick = (e) => {
        e.preventDefault();
        console.log('Clicked!');
      };

      return <button onClick={handleClick}>Click</button>;
    }

    // Inline handler
    function Button() {
      return (
        <button onClick={() => console.log('Clicked')}>
          Click
        </button>
      );
    }

    // Passing arguments
    function List({ items }) {
      const handleDelete = (id) => {
        console.log('Delete', id);
      };

      return (
        <ul>
          {items.map(item => (
            <li key={item.id}>
              {item.name}
              <button onClick={() => handleDelete(item.id)}>
                Delete
              </button>
            </li>
          ))}
        </ul>
      );
    }

    // Event object
    function Form() {
      const handleSubmit = (e) => {
        e.preventDefault();
        e.stopPropagation();
        console.log(e.target);
        console.log(e.currentTarget);
      };

      const handleChange = (e) => {
        console.log(e.target.value);
      };

      return (
        <form onSubmit={handleSubmit}>
          <input onChange={handleChange} />
          <button type="submit">Submit</button>
        </form>
      );
    }
<

Common Events~                                           *react-events-common*
>
    // Mouse events
    onClick, onDoubleClick, onMouseEnter, onMouseLeave,
    onMouseMove, onMouseDown, onMouseUp

    // Form events
    onChange, onSubmit, onFocus, onBlur, onInput

    // Keyboard events
    onKeyDown, onKeyUp, onKeyPress

    // Clipboard events
    onCopy, onPaste, onCut

    // Drag events
    onDrag, onDragStart, onDragEnd, onDrop
<

==============================================================================
2. Components                                            *react-components*

Function Component~                                      *react-component*
>
    function Greeting({ name }) {
      return <h1>Hello {name}</h1>;
    }

    // With TypeScript
    interface Props {
      name: string;
    }
    function Greeting({ name }: Props) {
      return <h1>Hello {name}</h1>;
    }
<

Props~                                                   *react-props*
    Data passed to components. Immutable.
>
    <Greeting name="John" age={30} />

    function Greeting({ name, age, children }) {
      return <div>{name} ({age}): {children}</div>;
    }
<

Children~                                                *react-children*
>
    function Card({ children }) {
      return <div className="card">{children}</div>;
    }

    <Card>
      <h1>Title</h1>
      <p>Content</p>
    </Card>
<

Default Props~                                           *react-default-props*
>
    function Button({ variant = "primary", children }) {
      return <button className={variant}>{children}</button>;
    }
<

Fragment~                                                *react-Fragment*
    Group elements without extra DOM node.
>
    import { Fragment } from 'react';

    // Long form
    <Fragment>
      <h1>Title</h1>
      <p>Content</p>
    </Fragment>

    // Short form
    <>
      <h1>Title</h1>
      <p>Content</p>
    </>

    // With key (lists)
    {items.map(item => (
      <Fragment key={item.id}>
        <dt>{item.term}</dt>
        <dd>{item.description}</dd>
      </Fragment>
    ))}
<

Error Boundaries~                                        *react-error-boundary*
    Catch errors in component tree. Must be class component.
>
    class ErrorBoundary extends React.Component {
      constructor(props) {
        super(props);
        this.state = { hasError: false };
      }

      static getDerivedStateFromError(error) {
        return { hasError: true };
      }

      componentDidCatch(error, errorInfo) {
        console.error('Error:', error, errorInfo);
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
    </ErrorBoundary>
<

Portals~                                                 *react-portals*
    Render children into different DOM node.
>
    import { createPortal } from 'react-dom';

    function Modal({ children }) {
      return createPortal(
        <div className="modal">{children}</div>,
        document.getElementById('modal-root')
      );
    }

    // Events still bubble through React tree
<

Class Components~                                        *react-class-components*
    Class-based components. Prefer function components with hooks.
>
    class Counter extends React.Component {
      constructor(props) {
        super(props);
        this.state = { count: 0 };
        this.handleClick = this.handleClick.bind(this);
      }

      handleClick() {
        this.setState({ count: this.state.count + 1 });
      }

      render() {
        return (
          <div>
            <p>Count: {this.state.count}</p>
            <button onClick={this.handleClick}>Increment</button>
          </div>
        );
      }
    }
<

Class Component Lifecycle~                              *react-lifecycle*
    Lifecycle methods in class components.
>
    class UserProfile extends React.Component {
      constructor(props) {
        super(props);
        this.state = { user: null };
      }

      // Mounting - called after component inserted into DOM
      componentDidMount() {
        fetch(`/api/users/${this.props.userId}`)
          .then(res => res.json())
          .then(user => this.setState({ user }));
      }

      // Updating - called after props or state changes
      componentDidUpdate(prevProps, prevState) {
        if (prevProps.userId !== this.props.userId) {
          fetch(`/api/users/${this.props.userId}`)
            .then(res => res.json())
            .then(user => this.setState({ user }));
        }
      }

      // Unmounting - called before component removed from DOM
      componentWillUnmount() {
        // Cleanup: cancel requests, clear timers, unsubscribe
        this.subscription.unsubscribe();
        clearInterval(this.timer);
      }

      // Error handling - see |react-error-boundary|
      componentDidCatch(error, errorInfo) {
        console.error('Error:', error, errorInfo);
      }

      render() {
        if (!this.state.user) return <div>Loading...</div>;
        return <div>{this.state.user.name}</div>;
      }
    }

    // Equivalent with hooks
    function UserProfile({ userId }) {
      const [user, setUser] = useState(null);

      useEffect(() => {
        fetch(`/api/users/${userId}`)
          .then(res => res.json())
          .then(user => setUser(user));

        return () => {
          // Cleanup
        };
      }, [userId]);

      if (!user) return <div>Loading...</div>;
      return <div>{user.name}</div>;
    }
<

PropTypes~                                               *react-PropTypes*
    Runtime type checking for props (non-TypeScript projects).
>
    import PropTypes from 'prop-types';

    function Greeting({ name, age, email, onSave }) {
      return <div>{name} is {age} years old</div>;
    }

    Greeting.propTypes = {
      name: PropTypes.string.isRequired,
      age: PropTypes.number.isRequired,
      email: PropTypes.string,
      onSave: PropTypes.func,
      children: PropTypes.node,
      user: PropTypes.shape({
        id: PropTypes.number,
        name: PropTypes.string
      }),
      items: PropTypes.arrayOf(PropTypes.string),
      status: PropTypes.oneOf(['active', 'inactive']),
      value: PropTypes.oneOfType([
        PropTypes.string,
        PropTypes.number
      ])
    };

    Greeting.defaultProps = {
      email: 'default@example.com'
    };

    // Common PropTypes
    PropTypes.array
    PropTypes.bool
    PropTypes.func
    PropTypes.number
    PropTypes.object
    PropTypes.string
    PropTypes.symbol
    PropTypes.node            // Anything renderable
    PropTypes.element         // React element
    PropTypes.any             // Any type
<

==============================================================================
3. Hooks                                                     *react-hooks*

useState()~                                              *react-useState()*
    Add state to function component. Returns [value, setter].
>
    const [count, setCount] = useState(0);
    setCount(count + 1);
    setCount(prev => prev + 1);  // Functional update

    // With object
    const [user, setUser] = useState({ name: '', age: 0 });
    setUser({ ...user, name: 'John' });
<

useEffect()~                                             *react-useEffect()*
    Side effects (data fetching, subscriptions). See |react-effects|.
>
    useEffect(() => {
      // Run on mount and updates
      document.title = `Count: ${count}`;
    });

    useEffect(() => {
      // Run only on mount
      fetchData();
    }, []);

    useEffect(() => {
      // Run when deps change
      fetchUser(userId);
    }, [userId]);

    useEffect(() => {
      // Cleanup
      const timer = setInterval(tick, 1000);
      return () => clearInterval(timer);
    }, []);
<

useContext()~                                            *react-useContext()*
    Access context value. See |react-context|.
>
    const theme = useContext(ThemeContext);
    const user = useContext(UserContext);
<

useReducer()~                                            *react-useReducer()*
    Complex state logic. Alternative to |react-useState()|.
>
    const [state, dispatch] = useReducer(reducer, initialState);

    function reducer(state, action) {
      switch (action.type) {
        case 'increment':
          return { count: state.count + 1 };
        case 'decrement':
          return { count: state.count - 1 };
        default:
          return state;
      }
    }

    dispatch({ type: 'increment' });
<

useCallback()~                                           *react-useCallback()*
    Memoize callback. See |react-memo|.
>
    const handleClick = useCallback(() => {
      doSomething(a, b);
    }, [a, b]);
<

useMemo()~                                               *react-useMemo()*
    Memoize computed value. See |react-memo|.
>
    const expensiveValue = useMemo(() => {
      return computeExpensiveValue(a, b);
    }, [a, b]);
<

useRef()~                                                *react-useRef()*
    Reference DOM element or mutable value. See |react-refs|.
>
    const inputRef = useRef(null);
    inputRef.current.focus();

    // Mutable value (doesn't trigger re-render)
    const countRef = useRef(0);
    countRef.current += 1;
<

useLayoutEffect()~                                       *react-useLayoutEffect()*
    Like |react-useEffect()| but fires synchronously after DOM mutations.
    Use for DOM measurements.
>
    useLayoutEffect(() => {
      const height = divRef.current.getBoundingClientRect().height;
      setHeight(height);
    }, []);
<

useId()~                                                 *react-useId()*
    Generate unique IDs for accessibility.
>
    const id = useId();
    return (
      <>
        <label htmlFor={`${id}-email`}>Email</label>
        <input id={`${id}-email`} type="email" />
      </>
    );
<

useImperativeHandle()~                                   *react-useImperativeHandle()*
    Customize ref exposure.
>
    const Input = forwardRef((props, ref) => {
      const inputRef = useRef();
      useImperativeHandle(ref, () => ({
        focus: () => inputRef.current.focus(),
        getValue: () => inputRef.current.value
      }));
      return <input ref={inputRef} {...props} />;
    });
<

useSyncExternalStore()~                                  *react-useSyncExternalStore()*
    Subscribe to external store.
>
    const value = useSyncExternalStore(
      store.subscribe,
      store.getSnapshot
    );
<

useTransition()~                                         *react-useTransition()*
    Mark state updates as non-urgent (React 18+).
>
    const [isPending, startTransition] = useTransition();

    function handleClick() {
      startTransition(() => {
        setTab('posts');  // Non-urgent update
      });
    }

    return (
      <div>
        <button onClick={handleClick}>Posts</button>
        {isPending && <Spinner />}
        <TabContent tab={tab} />
      </div>
    );
<

useDeferredValue()~                                      *react-useDeferredValue()*
    Defer updating non-urgent parts of UI (React 18+).
>
    const [query, setQuery] = useState('');
    const deferredQuery = useDeferredValue(query);

    // Input updates immediately, search results lag behind
    return (
      <>
        <input value={query} onChange={e => setQuery(e.target.value)} />
        <SearchResults query={deferredQuery} />
      </>
    );
<

Suspense~                                                *react-Suspense*
    Show fallback while children load.
>
    import { Suspense } from 'react';

    // Code splitting
    const Dashboard = lazy(() => import('./Dashboard'));

    <Suspense fallback={<div>Loading...</div>}>
      <Dashboard />
    </Suspense>

    // Data fetching (React 18+, requires Suspense-enabled library)
    <Suspense fallback={<Spinner />}>
      <UserProfile id={userId} />
    </Suspense>
<

StrictMode~                                              *react-StrictMode*
    Highlights problems during development. No effect in production.
>
    import { StrictMode } from 'react';

    <StrictMode>
      <App />
    </StrictMode>

    // Enables:
    // - Extra re-renders to find bugs
    // - Warnings about deprecated APIs
    // - Warnings about side effects in render
<

Custom Hooks~                                            *react-custom-hooks*
    Extract reusable logic. Must start with "use".
>
    function useWindowWidth() {
      const [width, setWidth] = useState(window.innerWidth);
      useEffect(() => {
        const handleResize = () => setWidth(window.innerWidth);
        window.addEventListener('resize', handleResize);
        return () => window.removeEventListener('resize', handleResize);
      }, []);
      return width;
    }

    // Usage
    const width = useWindowWidth();
<

==============================================================================
3. State Management                                          *react-state*

Local State~                                             *react-state-local*
    Use |react-useState()| or |react-useReducer()|.

Lifting State Up~                                        *react-state-lift*
    Move state to common parent when multiple components need it.
>
    function Parent() {
      const [value, setValue] = useState('');
      return (
        <>
          <Child1 value={value} onChange={setValue} />
          <Child2 value={value} />
        </>
      );
    }
<

Derived State~                                           *react-state-derived*
    Compute from existing state/props. Don't store in separate state.
>
    function UserProfile({ user }) {
      // Good - derived
      const fullName = `${user.firstName} ${user.lastName}`;

      // Bad - unnecessary state
      // const [fullName, setFullName] = useState(...)

      return <div>{fullName}</div>;
    }
<

State Updates~                                           *react-state-updates*
    State updates are asynchronous and batched.
>
    // Wrong - may not work as expected
    setCount(count + 1);
    setCount(count + 1);

    // Correct - functional update
    setCount(prev => prev + 1);
    setCount(prev => prev + 1);
<

==============================================================================
4. Effects                                                  *react-effects*

Effect Dependencies~                                     *react-effect-deps*
    Second argument to |react-useEffect()|.
>
    useEffect(() => {...});              // Every render
    useEffect(() => {...}, []);          // Mount only
    useEffect(() => {...}, [a, b]);      // When a or b change
<

Effect Cleanup~                                          *react-effect-cleanup*
    Return cleanup function from effect.
>
    useEffect(() => {
      const id = setInterval(() => {...}, 1000);
      return () => clearInterval(id);
    }, []);

    useEffect(() => {
      const sub = observable.subscribe(data => {...});
      return () => sub.unsubscribe();
    }, []);
<

Effect Best Practices~                                   *react-effect-best-practices*
    - Include all dependencies in dependency array
    - Use cleanup for subscriptions/timers
    - Separate concerns (multiple effects)
    - Don't lie about dependencies
>
    // Bad - missing dependency
    useEffect(() => {
      fetch(`/api/users/${userId}`);
    }, []);  // Missing userId!

    // Good
    useEffect(() => {
      fetch(`/api/users/${userId}`);
    }, [userId]);
<

Data Fetching~                                           *react-data-fetching*
>
    function UserProfile({ userId }) {
      const [user, setUser] = useState(null);
      const [loading, setLoading] = useState(true);
      const [error, setError] = useState(null);

      useEffect(() => {
        let cancelled = false;
        setLoading(true);
        fetch(`/api/users/${userId}`)
          .then(res => res.json())
          .then(data => {
            if (!cancelled) {
              setUser(data);
              setLoading(false);
            }
          })
          .catch(err => {
            if (!cancelled) {
              setError(err);
              setLoading(false);
            }
          });
        return () => { cancelled = true; };
      }, [userId]);

      if (loading) return <div>Loading...</div>;
      if (error) return <div>Error: {error.message}</div>;
      return <div>{user.name}</div>;
    }
<

==============================================================================
5. Context                                                  *react-context*

Creating Context~                                        *react-context-create*
>
    const ThemeContext = createContext('light');

    function App() {
      return (
        <ThemeContext.Provider value="dark">
          <Toolbar />
        </ThemeContext.Provider>
      );
    }
<

Consuming Context~                                       *react-context-consume*
>
    function Button() {
      const theme = useContext(ThemeContext);
      return <button className={theme}>Click</button>;
    }
<

Context Pattern~                                         *react-context-pattern*
>
    const UserContext = createContext(null);

    export function UserProvider({ children }) {
      const [user, setUser] = useState(null);

      const login = (credentials) => {...};
      const logout = () => setUser(null);

      return (
        <UserContext.Provider value={{ user, login, logout }}>
          {children}
        </UserContext.Provider>
      );
    }

    export function useUser() {
      const context = useContext(UserContext);
      if (!context) throw new Error('useUser must be within UserProvider');
      return context;
    }

    // Usage
    function Profile() {
      const { user, logout } = useUser();
      return <div>{user.name} <button onClick={logout}>Logout</button></div>;
    }
<

Context Performance~                                     *react-context-performance*
    All consumers re-render when context value changes. Split contexts or
    use |react-memo| to optimize.
>
    // Bad - everything re-renders when count changes
    <AppContext.Provider value={{ user, count, setCount }}>

    // Good - split contexts
    <UserContext.Provider value={user}>
      <CountContext.Provider value={{ count, setCount }}>
<

==============================================================================
6. Refs                                                         *react-refs*

DOM Refs~                                                *react-refs-dom*
>
    function Input() {
      const inputRef = useRef(null);

      useEffect(() => {
        inputRef.current.focus();
      }, []);

      return <input ref={inputRef} />;
    }
<

Forwarding Refs~                                         *react-refs-forward*
>
    const FancyInput = forwardRef((props, ref) => {
      return <input ref={ref} className="fancy" {...props} />;
    });

    // Usage
    function Parent() {
      const inputRef = useRef();
      return <FancyInput ref={inputRef} />;
    }
<

Refs vs State~                                           *react-refs-vs-state*
    - Refs: Mutable, doesn't trigger re-render
    - State: Immutable, triggers re-render
>
    // Ref - doesn't re-render
    const countRef = useRef(0);
    countRef.current += 1;

    // State - re-renders
    const [count, setCount] = useState(0);
    setCount(count + 1);
<

==============================================================================
7. Memoization                                                  *react-memo*

React.memo()~                                            *react-memo-component*
    Memoize component to prevent re-renders when props unchanged.
>
    const ExpensiveComponent = React.memo(function Component({ data }) {
      return <div>{/* expensive render */}</div>;
    });

    // With custom comparison
    const Component = React.memo(Component, (prevProps, nextProps) => {
      return prevProps.id === nextProps.id;
    });
<

useMemo()~                                               *react-useMemo-hook*
    Memoize computed value. Recompute only when dependencies change.
>
    const sortedList = useMemo(() => {
      return items.sort((a, b) => a.value - b.value);
    }, [items]);
<

useCallback()~                                           *react-useCallback-hook*
    Memoize callback function. Create new function only when dependencies
    change. Useful for passing to memoized child components.
>
    const handleClick = useCallback(() => {
      doSomething(a, b);
    }, [a, b]);

    return <MemoizedChild onClick={handleClick} />;
<

When to Memoize~                                         *react-memo-when*
    - Expensive computations
    - Large lists
    - Props passed to memoized children
    - Prevent unnecessary re-renders in child tree

Don't~
    - Premature optimization
    - Simple computations
    - Components that always change

==============================================================================
8. Forms                                                       *react-forms*

Controlled Components~                                   *react-forms-controlled*
    React state is source of truth.
>
    function Form() {
      const [name, setName] = useState('');

      const handleSubmit = (e) => {
        e.preventDefault();
        console.log('Submit:', name);
      };

      return (
        <form onSubmit={handleSubmit}>
          <input
            value={name}
            onChange={(e) => setName(e.target.value)}
          />
          <button type="submit">Submit</button>
        </form>
      );
    }
<

Multiple Inputs~                                         *react-forms-multiple*
>
    function Form() {
      const [form, setForm] = useState({ name: '', email: '', age: 0 });

      const handleChange = (e) => {
        const { name, value, type } = e.target;
        setForm({
          ...form,
          [name]: type === 'number' ? Number(value) : value
        });
      };

      return (
        <form>
          <input name="name" value={form.name} onChange={handleChange} />
          <input name="email" value={form.email} onChange={handleChange} />
          <input name="age" type="number" value={form.age} onChange={handleChange} />
        </form>
      );
    }
<

Form Validation~                                         *react-forms-validation*
>
    function Form() {
      const [email, setEmail] = useState('');
      const [error, setError] = useState('');

      const validate = (value) => {
        if (!value.includes('@')) {
          setError('Invalid email');
        } else {
          setError('');
        }
      };

      return (
        <>
          <input
            value={email}
            onChange={(e) => {
              setEmail(e.target.value);
              validate(e.target.value);
            }}
          />
          {error && <span>{error}</span>}
        </>
      );
    }
<

Uncontrolled Components~                                 *react-forms-uncontrolled*
    DOM is source of truth. Use refs.
>
    function Form() {
      const inputRef = useRef();

      const handleSubmit = (e) => {
        e.preventDefault();
        console.log('Value:', inputRef.current.value);
      };

      return (
        <form onSubmit={handleSubmit}>
          <input ref={inputRef} defaultValue="initial" />
          <button type="submit">Submit</button>
        </form>
      );
    }
<

==============================================================================
9. Router                                                     *react-router*

React Router v6~                                         *react-router-v6*
>
    import { BrowserRouter, Routes, Route, Link } from 'react-router-dom';

    function App() {
      return (
        <BrowserRouter>
          <nav>
            <Link to="/">Home</Link>
            <Link to="/about">About</Link>
            <Link to="/users/123">User</Link>
          </nav>

          <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/about" element={<About />} />
            <Route path="/users/:id" element={<User />} />
            <Route path="*" element={<NotFound />} />
          </Routes>
        </BrowserRouter>
      );
    }
<

Navigation~                                              *react-router-navigation*
>
    import { useNavigate, useParams, useSearchParams } from 'react-router-dom';

    function User() {
      const navigate = useNavigate();
      const { id } = useParams();
      const [searchParams] = useSearchParams();
      const tab = searchParams.get('tab');

      return (
        <div>
          <h1>User {id}</h1>
          <button onClick={() => navigate('/')}>Home</button>
          <button onClick={() => navigate(-1)}>Back</button>
        </div>
      );
    }
<

Nested Routes~                                           *react-router-nested*
>
    import { Outlet } from 'react-router-dom';

    function App() {
      return (
        <Routes>
          <Route path="/" element={<Layout />}>
            <Route index element={<Home />} />
            <Route path="about" element={<About />} />
            <Route path="users" element={<Users />}>
              <Route path=":id" element={<User />} />
            </Route>
          </Route>
        </Routes>
      );
    }

    function Layout() {
      return (
        <div>
          <nav>...</nav>
          <Outlet />  {/* Child routes render here */}
        </div>
      );
    }
<

Protected Routes~                                        *react-router-protected*
>
    function ProtectedRoute({ children }) {
      const { user } = useUser();
      const navigate = useNavigate();

      useEffect(() => {
        if (!user) navigate('/login');
      }, [user, navigate]);

      return user ? children : null;
    }

    <Route path="/dashboard" element={
      <ProtectedRoute>
        <Dashboard />
      </ProtectedRoute>
    } />
<

==============================================================================
10. Patterns                                                *react-patterns*

Composition~                                             *react-patterns-composition*
    Prefer composition over inheritance.
>
    function Dialog({ title, children }) {
      return (
        <div className="dialog">
          <h1>{title}</h1>
          <div>{children}</div>
        </div>
      );
    }

    <Dialog title="Welcome">
      <p>Thank you for visiting</p>
      <button>OK</button>
    </Dialog>
<

Render Props~                                            *react-patterns-render-props*
>
    function DataProvider({ render }) {
      const [data, setData] = useState(null);

      useEffect(() => {
        fetchData().then(setData);
      }, []);

      return render(data);
    }

    <DataProvider render={(data) => (
      <div>{data ? data.name : 'Loading...'}</div>
    )} />
<

Higher-Order Component~                                  *react-patterns-hoc*
>
    function withAuth(Component) {
      return function AuthComponent(props) {
        const { user } = useUser();
        if (!user) return <Login />;
        return <Component {...props} user={user} />;
      };
    }

    const ProtectedPage = withAuth(Dashboard);
<

Compound Components~                                     *react-patterns-compound*
>
    const Tab = ({ children }) => children;

    function Tabs({ children }) {
      const [active, setActive] = useState(0);

      return (
        <div>
          <div className="tabs">
            {React.Children.map(children, (child, index) => (
              <button onClick={() => setActive(index)}>
                {child.props.label}
              </button>
            ))}
          </div>
          <div className="content">
            {React.Children.toArray(children)[active]}
          </div>
        </div>
      );
    }

    <Tabs>
      <Tab label="One">Content 1</Tab>
      <Tab label="Two">Content 2</Tab>
    </Tabs>
<

Container/Presentational~                                *react-patterns-container*
>
    // Container - logic
    function UserContainer() {
      const [user, setUser] = useState(null);
      useEffect(() => {
        fetchUser().then(setUser);
      }, []);
      return <UserView user={user} />;
    }

    // Presentational - UI
    function UserView({ user }) {
      if (!user) return <div>Loading...</div>;
      return <div>{user.name}</div>;
    }
<

==============================================================================
11. Performance                                         *react-performance*

Profiling~                                               *react-profiling*
    Use React DevTools Profiler to identify slow renders.

Code Splitting~                                          *react-code-splitting*
>
    import { lazy, Suspense } from 'react';

    const Dashboard = lazy(() => import('./Dashboard'));

    function App() {
      return (
        <Suspense fallback={<div>Loading...</div>}>
          <Dashboard />
        </Suspense>
      );
    }
<

List Optimization~                                       *react-list-optimization*
>
    // Use key prop
    {items.map(item => <Item key={item.id} data={item} />)}

    // Virtualization for large lists
    import { FixedSizeList } from 'react-window';

    <FixedSizeList
      height={600}
      itemCount={items.length}
      itemSize={50}
      width="100%"
    >
      {({ index, style }) => (
        <div style={style}>{items[index].name}</div>
      )}
    </FixedSizeList>
<

Avoid Inline Functions~                                  *react-inline-functions*
>
    // Bad - creates new function each render
    <button onClick={() => handleClick(id)}>Click</button>

    // Good - memoize with useCallback
    const handleClick = useCallback(() => doSomething(id), [id]);
    <button onClick={handleClick}>Click</button>
<

Bundle Size~                                             *react-bundle-size*
    - Use code splitting (|react-code-splitting|)
    - Tree shaking (ES6 imports)
    - Analyze bundle with webpack-bundle-analyzer
    - Lazy load heavy dependencies

==============================================================================
12. Testing                                                 *react-testing*

React Testing Library~                                   *react-testing-library*
>
    import { render, screen, fireEvent } from '@testing-library/react';

    test('renders button', () => {
      render(<Button>Click</Button>);
      const button = screen.getByText('Click');
      expect(button).toBeInTheDocument();
    });

    test('handles click', () => {
      const handleClick = jest.fn();
      render(<Button onClick={handleClick}>Click</Button>);

      fireEvent.click(screen.getByText('Click'));
      expect(handleClick).toHaveBeenCalledTimes(1);
    });
<

Query Methods~                                           *react-testing-queries*
    getBy*     - Returns element, throws if not found
    queryBy*   - Returns element or null
    findBy*    - Returns promise (for async)

>
    screen.getByText('Submit')
    screen.getByRole('button', { name: /submit/i })
    screen.getByLabelText('Email')
    screen.getByPlaceholderText('Enter email')
    screen.getByTestId('submit-button')
    screen.queryByText('Optional')
    await screen.findByText('Loaded')
<

User Events~                                             *react-testing-events*
>
    import userEvent from '@testing-library/user-event';

    test('types into input', async () => {
      const user = userEvent.setup();
      render(<Input />);

      const input = screen.getByRole('textbox');
      await user.type(input, 'Hello');
      expect(input).toHaveValue('Hello');
    });
<

Async Testing~                                           *react-testing-async*
>
    test('loads data', async () => {
      render(<UserProfile userId="123" />);

      expect(screen.getByText('Loading...')).toBeInTheDocument();

      const name = await screen.findByText('John Doe');
      expect(name).toBeInTheDocument();
    });
<

Mocking~                                                 *react-testing-mocking*
>
    // Mock API
    global.fetch = jest.fn(() =>
      Promise.resolve({
        json: () => Promise.resolve({ name: 'John' })
      })
    );

    // Mock module
    jest.mock('./api', () => ({
      fetchUser: jest.fn(() => Promise.resolve({ name: 'John' }))
    }));
<

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
