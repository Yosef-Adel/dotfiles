*testing-library.txt*  Testing Library Reference

==============================================================================
CONTENTS                                            *testing-library-contents*

1. Queries ............................... |testing-library-queries|
   - Single Element Queries .............. |testing-library-single|
   - Multiple Element Queries ............ |testing-library-multiple|
   - Query Variants ...................... |testing-library-variants|
2. User Interactions ..................... |testing-library-interactions|
   - userEvent ........................... |testing-library-userevent|
   - fireEvent ........................... |testing-library-fireevent|
3. Render & Setup ........................ |testing-library-render|
   - render() ............................ |testing-library-render-fn|
   - screen .............................. |testing-library-screen|
   - within() ............................ |testing-library-within|
   - waitFor() ........................... |testing-library-waitfor|
4. Assertions ............................ |testing-library-assertions|
   - Common Matchers ..................... |testing-library-matchers|
   - jest-dom Matchers ................... |testing-library-jest-dom|
5. Best Practices ........................ |testing-library-best-practices|

==============================================================================
1. QUERIES                                          *testing-library-queries*

Single Element Queries~                              *testing-library-single*
>
    import { render, screen } from "@testing-library/react";

    // getBy* - throws if not found (use for expected elements)
    const input = screen.getByRole("textbox");
    const button = screen.getByText("Click me");
    const element = screen.getByTestId("my-element");

    // getByRole - PREFERRED (accessibility-based)
    const button = screen.getByRole("button", { name: "Submit" });
    const link = screen.getByRole("link", { name: "Home" });
    const heading = screen.getByRole("heading", { level: 1 });

    // getByLabelText - for form inputs
    const input = screen.getByLabelText("Username");

    // getByPlaceholderText
    const input = screen.getByPlaceholderText("Enter email");

    // getByDisplayValue - for populated inputs
    const input = screen.getByDisplayValue("john@example.com");

    // getByTitle
    const element = screen.getByTitle("Close");

    // queryBy* - returns null if not found (use for checking absence)
    const element = screen.queryByText("Not there");
    expect(element).not.toBeInTheDocument();

    // findBy* - async, waits for element (use for async renders)
    const element = await screen.findByText("Loaded data");
<

Multiple Element Queries~                          *testing-library-multiple*
>
    // getAllBy* - throws if none found
    const items = screen.getAllByRole("listitem");
    expect(items).toHaveLength(3);

    // queryAllBy* - returns empty array if none found
    const items = screen.queryAllByRole("listitem");
    expect(items).toHaveLength(0);

    // findAllBy* - async version
    const items = await screen.findAllByRole("listitem");
<

Query Variants~                                     *testing-library-variants*
>
    // Role queries (most accessible, PREFER these)
    screen.getByRole("button");
    screen.getByRole("link");
    screen.getByRole("textbox");
    screen.getByRole("checkbox");
    screen.getByRole("radio");
    screen.getByRole("combobox");
    screen.getByRole("listbox");
    screen.getByRole("img");
    screen.getByRole("heading");
    screen.getByRole("table");

    // With options
    screen.getByRole("button", { name: /submit/i }); // Case-insensitive regex
    screen.getByRole("button", { name: "Submit" }); // Exact match
    screen.getByRole("heading", { level: 1 });
    screen.getByRole("menuitem", { hidden: true }); // Hidden elements

    // Other queries (in order of preference)
    screen.getByLabelText("Username"); // Form labels
    screen.getByPlaceholderText("Email"); // Placeholder
    screen.getByText("Welcome"); // Text content
    screen.getByDisplayValue("john"); // Input value
    screen.getByTitle("Close"); // Title attribute
    screen.getByAltText("Logo"); // Image alt text
    screen.getByTestId("user-card"); // Last resort
<

==============================================================================
2. USER INTERACTIONS                            *testing-library-interactions*

userEvent~                                          *testing-library-userevent*
>
    import userEvent from "@testing-library/user-event";

    // Setup (v14+)
    const user = userEvent.setup();

    // Type text
    await user.type(input, "hello");
    await user.type(input, "world", { delay: 100 }); // Delay between chars

    // Clear input
    await user.clear(input);

    // Click
    await user.click(button);
    await user.dblClick(element);

    // Keyboard
    await user.keyboard("{Enter}");
    await user.keyboard("{Control>}a{/Control}"); // Ctrl+A
    await user.keyboard("[ShiftLeft>]a[/ShiftLeft]"); // Shift+A

    // Select option
    await user.selectOptions(select, "option-value");
    await user.selectOptions(select, ["value1", "value2"]); // Multiple

    // Deselect
    await user.deselectOptions(select, "option-value");

    // Upload file
    const file = new File(["content"], "file.txt", { type: "text/plain" });
    await user.upload(input, file);

    // Hover
    await user.hover(element);
    await user.unhover(element);

    // Tab navigation
    await user.tab();
    await user.tab({ shift: true }); // Shift+Tab

    // Pointer events
    await user.pointer({ target: element, keys: "[MouseLeft>]" });
<

fireEvent~                                          *testing-library-fireevent*
>
    import { fireEvent } from "@testing-library/react";

    // Direct DOM event triggering (use userEvent for most cases)
    fireEvent.click(button);
    fireEvent.change(input, { target: { value: "text" } });
    fireEvent.submit(form);
    fireEvent.focus(input);
    fireEvent.blur(input);

    // Keyboard
    fireEvent.keyDown(input, { key: "Enter", code: "Enter" });
    fireEvent.keyUp(input, { key: "Enter" });

    // Animation
    fireEvent.animationStart(element);
    fireEvent.animationEnd(element);
<

==============================================================================
3. RENDER & SETUP                                     *testing-library-render*

render()~                                          *testing-library-render-fn*
>
    import { render, screen } from "@testing-library/react";

    // Basic render
    render(<MyComponent />);

    // Render with props
    render(<MyComponent title="Hello" onClick={jest.fn()} />);

    // Render with provider
    render(
      <ThemeProvider>
        <MyComponent />
      </ThemeProvider>
    );

    // Get component container
    const { container } = render(<MyComponent />);
    const div = container.querySelector(".my-class");

    // Rerender
    const { rerender } = render(<MyComponent count={0} />);
    rerender(<MyComponent count={1} />);

    // Unmount
    const { unmount } = render(<MyComponent />);
    unmount();
<

screen~                                               *testing-library-screen*
>
    import { screen } from "@testing-library/react";

    // screen contains all query methods
    // getBy*, getAllBy*, queryBy*, queryAllBy*, findBy*, findAllBy*

    // Debug output
    screen.debug(); // Print DOM
    screen.logTestingPlaygroundURL(); // Get testing playground link

    // Queries
    screen.getByRole("button");
    screen.getByLabelText("Email");
<

within()~                                              *testing-library-within*
>
    import { render, screen, within } from "@testing-library/react";

    render(<MyComponent />);

    // Query within a specific element
    const card = screen.getByTestId("user-card");
    const name = within(card).getByText("John");
    const email = within(card).getByLabelText("Email");

    // Instead of document-wide query
    // NOT: screen.getAllByRole("button")
    // DO: within(container).getAllByRole("button")
<

waitFor()~                                            *testing-library-waitfor*
>
    import { render, screen, waitFor } from "@testing-library/react";

    // Wait for element to appear
    render(<AsyncComponent />);
    await waitFor(() => {
      expect(screen.getByText("Loaded")).toBeInTheDocument();
    });

    // With options
    await waitFor(
      () => {
        expect(screen.getByText("Data")).toBeInTheDocument();
      },
      { timeout: 3000 } // Wait max 3 seconds
    );

    // Wait for callback
    await waitFor(() => {
      expect(mockFn).toHaveBeenCalled();
    });
<

==============================================================================
4. ASSERTIONS                                     *testing-library-assertions*

Common Matchers~                                     *testing-library-matchers*
>
    // Existence
    expect(element).toBeInTheDocument();
    expect(element).toBeDefined();
    expect(element).not.toBeNull();

    // Visibility
    expect(element).toBeVisible();
    expect(element).not.toBeVisible();

    // Text content
    expect(element).toHaveTextContent("Hello");
    expect(element).toHaveTextContent(/hello/i); // Case-insensitive

    // HTML content
    expect(container).toContainHTML("<h1>Title</h1>");

    // Values
    expect(input).toHaveValue("john");
    expect(select).toHaveValue("option-value");

    // Attributes
    expect(element).toHaveAttribute("data-testid", "my-id");
    expect(element).toHaveAttribute("disabled");
    expect(element).not.toHaveAttribute("disabled");

    // Classes
    expect(element).toHaveClass("active");
    expect(element).toHaveClass("active", "primary");
    expect(element).not.toHaveClass("disabled");

    // Styles
    expect(element).toHaveStyle("color: red");
    expect(element).toHaveStyle({ color: "red" });

    // Form elements
    expect(checkbox).toBeChecked();
    expect(radio).toBeChecked();
    expect(input).toBeDisabled();
    expect(input).toBeEnabled();
    expect(input).toBeRequired();
    expect(input).toBeInvalid();

    // Call counts
    expect(mockFn).toHaveBeenCalled();
    expect(mockFn).toHaveBeenCalledTimes(3);
    expect(mockFn).toHaveBeenCalledWith("arg1", "arg2");
    expect(mockFn).toHaveBeenLastCalledWith("arg");
<

jest-dom Matchers~                                   *testing-library-jest-dom*
>
    // Must import first
    import "@testing-library/jest-dom";

    // Visibility
    expect(element).toBeVisible();
    expect(element).toBeEmptyDOMElement();

    // Enabled/Disabled
    expect(button).toBeEnabled();
    expect(button).toBeDisabled();

    // Form validation
    expect(input).toBeRequired();
    expect(input).toBeInvalid();
    expect(input).toBeValid();

    // Checked
    expect(checkbox).toBeChecked();
    expect(checkbox).not.toBeChecked();

    // Focus
    expect(input).toHaveFocus();

    // Value
    expect(input).toHaveValue("text");
    expect(select).toHaveValue("option");

    // Class
    expect(element).toHaveClass("active");

    // Style
    expect(element).toHaveStyle("color: red");

    // Attribute
    expect(element).toHaveAttribute("href", "/path");
    expect(element).toHaveAttribute("disabled");

    // Text content
    expect(element).toHaveTextContent("Hello");

    // HTML content
    expect(container).toContainHTML("<span>Test</span>");

    // Display value
    expect(input).toHaveDisplayValue("John");

    // Error message
    expect(element).toHaveErrorMessage("Field required");

    // Form value
    expect(form).toHaveFormValues({
      username: "john",
      email: "john@example.com",
    });
<

==============================================================================
5. BEST PRACTICES                            *testing-library-best-practices*

Best practices~                             *testing-library-best-practices-list*
>
    // ✅ Query priority (use in order)
    // 1. getByRole - most accessible
    screen.getByRole("button", { name: "Submit" });

    // 2. getByLabelText - for form inputs
    screen.getByLabelText("Username");

    // 3. getByPlaceholderText
    screen.getByPlaceholderText("Email");

    // 4. getByText - general content
    screen.getByText("Welcome");

    // 5. getByTestId - last resort
    screen.getByTestId("user-card");

    // ❌ Avoid
    // screen.getByClassName() - doesn't exist
    // container.querySelector() - implementation detail
    // DOM testing without user perspective

    // ✅ User-centric testing
    const user = userEvent.setup();
    await user.type(input, "hello");
    await user.click(button);

    // ❌ Implementation details
    fireEvent.change(input, { target: { value: "hello" } });
    fireEvent.click(button);

    // ✅ Query what matters
    expect(screen.getByRole("alert")).toHaveTextContent("Error");

    // ❌ Query implementation
    expect(container.querySelector(".error-message")).toBeInTheDocument();

    // ✅ Async operations
    const item = await screen.findByText("Loaded");

    // ❌ No async waiting
    const item = screen.getByText("Loaded"); // Fails if not immediately available

    // ✅ Check presence/absence correctly
    expect(screen.queryByText("Not there")).not.toBeInTheDocument();
    // OR
    expect(screen.queryByText("There")).toBeInTheDocument();

    // ❌ Wrong pattern
    expect(screen.getByText("Not there")).not.toBeInTheDocument(); // Throws!
<

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
