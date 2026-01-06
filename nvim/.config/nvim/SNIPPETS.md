# Frontend Development Snippets Reference

Complete reference for all custom snippets in this Neovim configuration.

---

## 🎯 React Snippets

### Components

#### `rfc` - React Functional Component

```typescript
interface ComponentProps {

}

export const Component = ({  }: ComponentProps) => {
  return (
    <div>

    </div>
  );
};
```

#### `rfce` - React FC with Default Export

```typescript
interface ComponentProps {

}

const Component = ({  }: ComponentProps) => {
  return (
    <div>

    </div>
  );
};

export default Component;
```

#### `rafc` - Simple Arrow Function Component

```typescript
export const Component = () => {
  return (
    <div>

    </div>
  );
};
```

#### `rfr` - Component with forwardRef

```typescript
interface ComponentProps {

}

export const Component = forwardRef<HTMLDivElement, ComponentProps>(
  ({  }, ref) => {
    return (
      <div ref={ref}>

      </div>
    );
  }
);

Component.displayName = 'Component';
```

---

### Hooks

#### `us` - useState Hook

```typescript
const [state, setState] = useState(initialValue);
```

#### `ue` - useEffect Hook

```typescript
useEffect(() => {}, [dependencies]);
```

#### `uec` - useEffect with Cleanup

```typescript
useEffect(() => {
  return () => {
    // cleanup
  };
}, [dependencies]);
```

#### `ur` - useRef Hook

```typescript
const ref = useRef(null);
```

#### `um` - useMemo Hook

```typescript
const memoized = useMemo(() => {
  return;
}, [dependencies]);
```

#### `uc` - useCallback Hook

```typescript
const callback = useCallback(() => {}, [dependencies]);
```

#### `ux` - useContext Hook

```typescript
const context = useContext(Context);
```

#### `ured` - useReducer Hook

```typescript
const [state, dispatch] = useReducer(reducer, initialState);
```

#### `uch` - Custom Hook Template

```typescript
export const useCustom = () => {
  const [state, setState] = useState();

  useEffect(() => {}, [dependencies]);

  return { state, setState };
};
```

---

### Context

#### `rcp` - React Context Provider (Complete)

```typescript
import { createContext, useContext, useState, ReactNode } from 'react';

interface ContextType {

}

const Context = createContext<ContextType | undefined>(undefined);

interface ContextProviderProps {
  children: ReactNode;
}

export const ContextProvider = ({ children }: ContextProviderProps) => {
  const [state, setState] = useState();

  return (
    <Context.Provider value={{ state, setState }}>
      {children}
    </Context.Provider>
  );
};

export const useContext = () => {
  const context = useContext(Context);
  if (!context) {
    throw new Error('useContext must be used within ContextProvider');
  }
  return context;
};
```

---

### Imports

#### `imr` - Import from React

```typescript
import {} from "react";
```

#### `clg` - Console Log with Label

```typescript
console.log("variable:", variable);
```

---

## 🧪 React Testing Library Snippets

### Test Structure

#### `test` - Test Block

```typescript
test("should", async () => {});
```

#### `desc` - Describe Block

```typescript
describe("ComponentName", () => {
  test("should", async () => {});
});
```

#### `be` - beforeEach Hook

```typescript
beforeEach(() => {});
```

#### `ae` - afterEach Hook

```typescript
afterEach(() => {});
```

---

### Rendering

#### `rtlrender` - Render Component

```typescript
const { getByText } = render(<Component />);
```

_Options: getByText, getByRole, getByTestId, queryByText, findByText_

#### `rtluser` - Render with userEvent Setup

```typescript
const user = userEvent.setup();
const { getByText } = render(<Component />);
```

---

### Act & UserEvent

#### `act` - Act Wrapper

```typescript
await act(async () => {});
```

#### `actuser` - Act with userEvent

```typescript
await act(async () => {
  await userEvent.click(element);
});
```

_Options: click, type, clear, upload, selectOptions, hover, unhover, tab, keyboard_

#### `uclick` - userEvent Click

```typescript
await userEvent.click(element);
```

#### `utype` - userEvent Type

```typescript
await userEvent.type(element, "text");
```

#### `uclear` - userEvent Clear

```typescript
await userEvent.clear(element);
```

#### `uselect` - userEvent Select Options

```typescript
await userEvent.selectOptions(element, "value");
```

---

### Queries & Assertions

#### `screen` - Screen Query

```typescript
screen.getByText("text");
```

_Options: getByText, getByRole, getByTestId, queryByText, findByText, getAllByText, queryAllByText, findAllByText_

#### `exp` - Expect Assertion

```typescript
expect(element).toBeInTheDocument();
```

_Options: toBeInTheDocument, toHaveTextContent, toBeVisible, toHaveValue, toBeDisabled, toBeEnabled, toHaveClass, toHaveAttribute_

#### `waitfor` - Wait For Assertion

```typescript
await waitFor(() => {
  expect().toBeInTheDocument();
});
```

---

### Mocking

#### `mock` - Create Mock Function

```typescript
const mockFn = jest.fn();
```

#### `mockimpl` - Mock Implementation

```typescript
mockFn.mockImplementation(() => {});
```

#### `mockres` - Mock Resolved Value

```typescript
mockFn.mockResolvedValue();
```

#### `mockrej` - Mock Rejected Value

```typescript
mockFn.mockRejectedValue(new Error("error"));
```

---

## 📘 TypeScript / JavaScript Snippets

### Type Definitions

#### `int` - Interface

```typescript
interface Name {}
```

#### `type` - Type Alias

```typescript
type Name = ;
```

#### `enum` - Enum

```typescript
enum Name {}
```

---

### Functions

#### `af` - Arrow Function

```typescript
const name = () => {};
```

#### `aaf` - Async Arrow Function

```typescript
const name = async () => {};
```

#### `asy` - Async Function with Try/Catch

```typescript
async function() {
  try {
    const result = await promise;

  } catch (error) {
    console.error(error);
  }
}
```

---

### Promises & Error Handling

#### `prom` - Promise

```typescript
new Promise<type>((resolve, reject) => {});
```

#### `try` - Try/Catch

```typescript
try {
} catch (error) {
  console.error(error);
}
```

#### `tryf` - Try/Catch/Finally

```typescript
try {
} catch (error) {
  console.error(error);
} finally {
  // cleanup
}
```

---

### Imports & Exports

#### `imp` - Named Import

```typescript
import {} from "module";
```

#### `impd` - Default Import

```typescript
import name from "module";
```

#### `impt` - Type Import

```typescript
import type {} from "module";
```

#### `exp` - Named Export

```typescript
export {};
```

#### `expd` - Default Export

```typescript
export default ;
```

---

### Destructuring

#### `dob` - Destructure Object

```typescript
const {  } = ;
```

#### `dar` - Destructure Array

```typescript
const [] = ;
```

---

### Control Flow

#### `ter` - Ternary Operator

```typescript
condition ? true : false;
```

#### `for` - For Loop

```typescript
for (let i = 0; i < array.length; i++) {}
```

#### `fof` - For...of Loop

```typescript
for (const item of array) {
}
```

#### `fin` - For...in Loop

```typescript
for (const key in object) {
  if (object.hasOwnProperty(key)) {
  }
}
```

---

### Array Methods

#### `map` - Array Map

```typescript
array.map((item) => )
```

#### `filter` - Array Filter

```typescript
array.filter((item) => )
```

#### `reduce` - Array Reduce

```typescript
array.reduce((acc, item) => {
  return acc;
}, initialValue);
```

#### `find` - Array Find

```typescript
array.find((item) => )
```

---

### Console Methods

#### `cl` - Console Log

```typescript
console.log();
```

#### `ce` - Console Error

```typescript
console.error();
```

#### `cw` - Console Warn

```typescript
console.warn();
```

#### `ct` - Console Table

```typescript
console.table();
```

---

## 🎨 CSS Snippets

#### `flex` - Flexbox Container

```css
display: flex;
justify-content: center;
align-items: center;
gap: 1rem;
```

_Options for justify-content: flex-start, center, flex-end, space-between, space-around, space-evenly_
_Options for align-items: flex-start, center, flex-end, stretch, baseline_

#### `grid` - Grid Container

```css
display: grid;
grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
gap: 1rem;
```

#### `mq` - Media Query

```css
@media (min-width: 768px) {
}
```

_Options: min-width, max-width_

#### `abscenter` - Absolute Center

```css
position: absolute;
top: 50%;
left: 50%;
transform: translate(-50%, -50%);
```

#### `trans` - Transition

```css
transition: all 0.3s ease;
```

#### `anim` - Animation

```css
animation: name 1s ease 0s 1 normal forwards;
```

#### `keyframes` - Keyframes

```css
@keyframes name {
  0% {
  }
  100% {
  }
}
```

#### `bxsh` - Box Shadow

```css
box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
```

#### `tsh` - Text Shadow

```css
text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
```

#### `br` - Border Radius

```css
border-radius: 0.5rem;
```

---

## 🌐 HTML Snippets

#### `html5` - HTML5 Boilerplate

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
  </head>
  <body></body>
</html>
```

#### `link` - Link Stylesheet

```html
<link rel="stylesheet" href="styles.css" />
```

#### `script` - Script Tag

```html
<script src="script.js"></script>
```

#### `scriptm` - Script Module

```html
<script type="module" src="script.js"></script>
```

#### `input` - Input Element

```html
<input type="text" name="name" id="id" placeholder="placeholder" />
```

#### `btn` - Button Element

```html
<button type="button" onClick="handler"></button>
```

_Options: button, submit, reset_

#### `form` - Form Element

```html
<form onSubmit="handleSubmit"></form>
```

---

## ⚙️ JSON Configuration Snippets

#### `pkgjson` - package.json Template

```json
{
  "name": "project-name",
  "version": "1.0.0",
  "description": "description",
  "main": "index.js",
  "scripts": {
    "start": "command"
  },
  "keywords": [],
  "author": "author",
  "license": "MIT",
  "dependencies": {}
}
```

#### `tsconfig` - tsconfig.json Template

```json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "ESNext",
    "lib": ["ES2020", "DOM"],
    "jsx": "react-jsx",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "moduleResolution": "node",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true
  },
  "include": ["src"],
  "exclude": ["node_modules"]
}
```

---

## 📝 Usage Tips

1. **Tab Navigation**: Press `Tab` to jump between placeholders in a snippet
2. **Dropdown Options**: Many snippets have dropdown menus - use arrow keys to select
3. **Auto-capitalization**: Some snippets (like `us`) automatically capitalize variable names
4. **File Types**: Snippets are language-specific and will only appear in appropriate file types
5. **Completion**: Start typing the trigger and wait for Blink.cmp to show suggestions

---

## 🔧 Adding Custom Snippets

To add your own snippets, edit the files in `~/.config/nvim/snippets/`:

- `react.json` - React components and hooks
- `react-testing.json` - Testing Library snippets
- `typescript.json` - TypeScript/JavaScript snippets
- `css.json` - CSS snippets
- `html.json` - HTML snippets
- `json.json` - JSON configuration files

After adding snippets, restart Neovim or run `:Lazy reload blink.cmp`
