*dom.txt*  DOM APIs Reference

==============================================================================
CONTENTS                                                       *dom-contents*

1. Selecting Elements .................... |dom-selecting|
2. Node Relationships .................... |dom-nodes|
3. Creating & Modifying .................. |dom-modifying|
4. Events ................................ |dom-events|
5. Forms ................................. |dom-forms|
6. Storage ............................... |dom-storage|
7. Web Components ........................ |dom-web-components|
8. Web APIs .............................. |dom-apis|

==============================================================================
1. Selecting Elements                                      *dom-selecting*

querySelector()~                                           *dom-querySelector()*
querySelectorAll()~                                        *dom-querySelectorAll()*
>
    const el = document.querySelector('.my-class');
    const el2 = document.querySelector('#my-id');
    const el3 = document.querySelector('div.container > p');

    const els = document.querySelectorAll('.my-class');
    els.forEach(el => console.log(el));
<

getElementById()~                                          *dom-getElementById()*
>
    const el = document.getElementById('my-id');
<

getElementsByClassName()~                                  *dom-getElementsByClassName()*
>
    const els = document.getElementsByClassName('my-class');
    // Returns HTMLCollection (live)
<

getElementsByTagName()~                                    *dom-getElementsByTagName()*
>
    const divs = document.getElementsByTagName('div');
<

closest()~                                                 *dom-closest()*
    Find closest ancestor matching selector.
>
    const card = button.closest('.card');
    const parent = el.closest('.parent');
<

matches()~                                                 *dom-matches()*
    Test if element matches selector.
>
    if (el.matches('.active')) {
      // Element has 'active' class
    }
<

==============================================================================
2. Node Relationships                                          *dom-nodes*

Parent Nodes~                                              *dom-parent*
>
    const parent = el.parentNode;        // Parent node (any type)
    const parent = el.parentElement;     // Parent element (null if parent is not element)

    // Traverse up to root
    let current = el;
    while (current.parentElement) {
      current = current.parentElement;
    }
<

Child Nodes~                                               *dom-children*
>
    // All child nodes (including text, comments)
    const nodes = el.childNodes;         // NodeList (live)
    const first = el.firstChild;
    const last = el.lastChild;

    // Only element children
    const elements = el.children;        // HTMLCollection (live)
    const first = el.firstElementChild;
    const last = el.lastElementChild;
    const count = el.childElementCount;

    // Iterate children
    for (const child of el.children) {
      console.log(child);
    }

    // Check if has children
    if (el.hasChildNodes()) {
      // Has children
    }
<

Sibling Nodes~                                             *dom-siblings*
>
    // All sibling nodes (including text, comments)
    const next = el.nextSibling;
    const prev = el.previousSibling;

    // Only element siblings
    const next = el.nextElementSibling;
    const prev = el.previousElementSibling;

    // Get all siblings
    const siblings = Array.from(el.parentElement.children)
      .filter(child => child !== el);
<

Node Types~                                                *dom-node-types*
>
    el.nodeType                          // Node type constant
    el.nodeName                          // Tag name (uppercase)
    el.nodeValue                         // Node value (text nodes)

    // Common node types
    Node.ELEMENT_NODE                    // 1 - <div>, <p>, etc.
    Node.TEXT_NODE                       // 3 - Text content
    Node.COMMENT_NODE                    // 8 - <!-- comment -->
    Node.DOCUMENT_NODE                   // 9 - document

    // Check node type
    if (node.nodeType === Node.ELEMENT_NODE) {
      // Is element
    }
<

NodeList vs HTMLCollection~                                *dom-collections*
>
    // NodeList - static or live, can contain any node type
    const nodes = document.querySelectorAll('.item');  // Static
    const childNodes = el.childNodes;                   // Live

    // HTMLCollection - always live, only elements
    const elements = document.getElementsByClassName('item');  // Live
    const children = el.children;                             // Live

    // Convert to array
    const arr1 = Array.from(nodes);
    const arr2 = [...nodes];

    // NodeList has forEach
    nodes.forEach(node => console.log(node));

    // HTMLCollection doesn't have forEach
    Array.from(elements).forEach(el => console.log(el));
<

Document vs Window~                                        *dom-document-window*
>
    // Document - represents the page
    document.querySelector()
    document.createElement()
    document.body
    document.documentElement             // <html> element

    // Window - browser window
    window.innerWidth
    window.innerHeight
    window.scrollTo()
    window.addEventListener()

    // Both have event listeners
    document.addEventListener('DOMContentLoaded', () => {});
    window.addEventListener('load', () => {});
<

==============================================================================
3. Creating & Modifying                                    *dom-modifying*

createElement()~                                           *dom-createElement()*
>
    const div = document.createElement('div');
    div.textContent = 'Hello';
    div.className = 'container';
<

appendChild()~                                             *dom-appendChild()*
>
    parent.appendChild(child);
<

insertBefore()~                                            *dom-insertBefore()*
>
    parent.insertBefore(newNode, referenceNode);
<

append()~                                                  *dom-append()*
prepend()~                                                 *dom-prepend()*
>
    parent.append(child1, child2, 'text');
    parent.prepend(child);
<

insertAdjacentHTML()~                                      *dom-insertAdjacentHTML()*
>
    el.insertAdjacentHTML('beforebegin', '<div>Before</div>');
    el.insertAdjacentHTML('afterbegin', '<div>Start</div>');
    el.insertAdjacentHTML('beforeend', '<div>End</div>');
    el.insertAdjacentHTML('afterend', '<div>After</div>');
<

insertAdjacentElement()~                                   *dom-insertAdjacentElement()*
    Insert element (not HTML string) at position.
>
    const newEl = document.createElement('div');
    newEl.textContent = 'New element';

    el.insertAdjacentElement('beforebegin', newEl);  // Before el
    el.insertAdjacentElement('afterbegin', newEl);   // First child of el
    el.insertAdjacentElement('beforeend', newEl);    // Last child of el
    el.insertAdjacentElement('afterend', newEl);     // After el
<

before()~                                                  *dom-before()*
after()~                                                   *dom-after()*
    Insert nodes or strings before/after element.
>
    const div = document.createElement('div');

    el.before(div);                      // Insert div before el
    el.after(div);                       // Insert div after el

    // Can insert multiple items
    el.before('Text', div, 'More text');
    el.after(div1, div2, div3);

    // Insert sibling
    const sibling = document.createElement('p');
    el.after(sibling);
<

createTextNode()~                                          *dom-createTextNode()*
    Create text node (not element).
>
    const text = document.createTextNode('Hello World');
    parent.appendChild(text);

    // Useful for avoiding XSS
    const userInput = getUserInput();
    const text = document.createTextNode(userInput);  // Safe
    div.appendChild(text);

    // vs innerHTML (can be XSS vulnerable)
    // div.innerHTML = userInput;        // Unsafe if userInput has <script>
<

removeChild()~                                             *dom-removeChild()*
remove()~                                                  *dom-remove()*
>
    parent.removeChild(child);
    child.remove();                      // Easier
<

replaceChild()~                                            *dom-replaceChild()*
>
    parent.replaceChild(newChild, oldChild);
<

replaceWith()~                                             *dom-replaceWith()*
    Modern alternative to replaceChild. Replace element with new nodes.
>
    oldElement.replaceWith(newElement);

    // Can replace with multiple nodes
    oldElement.replaceWith(div1, div2, 'text');

    // Simpler than replaceChild
    // parent.replaceChild(newElement, oldElement);  // Old way
<

cloneNode()~                                               *dom-cloneNode()*
>
    const clone = el.cloneNode(true);    // Deep clone
    const shallow = el.cloneNode(false);
<

innerHTML~                                                 *dom-innerHTML*
textContent~                                               *dom-textContent*
innerText~                                                 *dom-innerText*
>
    el.innerHTML = '<strong>Bold</strong>';
    el.textContent = 'Plain text';       // Faster, safer
    el.innerText = 'Respects CSS';       // Slower
<

className~                                                 *dom-className*
classList~                                                 *dom-classList*
>
    el.className = 'active';

    el.classList.add('active');
    el.classList.remove('inactive');
    el.classList.toggle('hidden');
    el.classList.contains('active');     // true/false
    el.classList.replace('old', 'new');
<

setAttribute()~                                            *dom-setAttribute()*
getAttribute()~                                            *dom-getAttribute()*
>
    el.setAttribute('data-id', '123');
    const id = el.getAttribute('data-id');
    el.removeAttribute('data-id');
    el.hasAttribute('data-id');          // true/false
<

style~                                                     *dom-style*
>
    el.style.color = 'red';
    el.style.backgroundColor = 'blue';
    el.style.cssText = 'color: red; background: blue;';

    // Get computed style
    const style = window.getComputedStyle(el);
    const color = style.color;
<

dataset~                                                   *dom-dataset*
>
    // <div data-user-id="123" data-role="admin">
    el.dataset.userId;                   // '123'
    el.dataset.role;                     // 'admin'
    el.dataset.newProp = 'value';
<

getBoundingClientRect()~                                   *dom-getBoundingClientRect()*
    Get element position and dimensions.
>
    const rect = el.getBoundingClientRect();
    rect.top;                            // Distance from top of viewport
    rect.left;                           // Distance from left of viewport
    rect.right;                          // Distance from left to right edge
    rect.bottom;                         // Distance from top to bottom edge
    rect.width;                          // Element width
    rect.height;                         // Element height
    rect.x;                              // Same as left
    rect.y;                              // Same as top
<

Element Dimensions~                                        *dom-dimensions*
>
    // Content + padding
    el.clientWidth;
    el.clientHeight;

    // Content + padding + border
    el.offsetWidth;
    el.offsetHeight;

    // Content + padding + scrollable overflow
    el.scrollWidth;
    el.scrollHeight;

    // Scroll position
    el.scrollTop;                        // Vertical scroll
    el.scrollLeft;                       // Horizontal scroll

    // Offset from positioned parent
    el.offsetTop;
    el.offsetLeft;
    el.offsetParent;
<

Scrolling~                                                 *dom-scrolling*
>
    // Scroll to position
    window.scrollTo(0, 100);
    window.scrollTo({ top: 100, left: 0, behavior: 'smooth' });

    // Scroll by amount
    window.scrollBy(0, 100);
    window.scrollBy({ top: 100, behavior: 'smooth' });

    // Scroll element into view
    el.scrollIntoView();
    el.scrollIntoView({ behavior: 'smooth', block: 'center' });
<

==============================================================================
3. Events                                                      *dom-events*

addEventListener()~                                        *dom-addEventListener()*
>
    el.addEventListener('click', (e) => {
      console.log('Clicked');
    });

    // With options
    el.addEventListener('scroll', handler, {
      passive: true,
      once: true,
      capture: false
    });
<

removeEventListener()~                                     *dom-removeEventListener()*
>
    function handler(e) { console.log(e); }

    el.addEventListener('click', handler);
    el.removeEventListener('click', handler);
<

Event Object~                                              *dom-event-object*
>
    el.addEventListener('click', (e) => {
      e.target;                          // Element that triggered event
      e.currentTarget;                   // Element with listener
      e.type;                            // 'click'
      e.preventDefault();                // Prevent default action
      e.stopPropagation();               // Stop bubbling
      e.stopImmediatePropagation();      // Stop other handlers too
    });
<

Event target vs currentTarget~                            *dom-target-currentTarget*
    target - Element that triggered the event
    currentTarget - Element that has the event listener attached
>
    <div class="parent">
      <button class="child">Click</button>
    </div>

    document.querySelector('.parent').addEventListener('click', (e) => {
      console.log(e.target);             // <button> (clicked element)
      console.log(e.currentTarget);      // <div class="parent"> (listener element)
      console.log(e.target === e.currentTarget);  // false
    });

    document.querySelector('.child').addEventListener('click', (e) => {
      console.log(e.target);             // <button>
      console.log(e.currentTarget);      // <button>
      console.log(e.target === e.currentTarget);  // true
    });
<

Event Bubbling and Capturing~                             *dom-event-phases*
    Events propagate through three phases: capturing, target, bubbling.

    Phases:
    1. Capturing (down) - Window → Document → ... → Parent → Target
    2. Target           - Event at target element
    3. Bubbling (up)    - Target → Parent → ... → Document → Window

>
    <div id="grandparent">
      <div id="parent">
        <button id="child">Click</button>
      </div>
    </div>

    // Bubbling (default) - executes bottom-up
    grandparent.addEventListener('click', () => {
      console.log('Grandparent bubbling');
    });
    parent.addEventListener('click', () => {
      console.log('Parent bubbling');
    });
    child.addEventListener('click', () => {
      console.log('Child bubbling');
    });
    // Click button: Child → Parent → Grandparent

    // Capturing - executes top-down
    grandparent.addEventListener('click', () => {
      console.log('Grandparent capturing');
    }, true);  // true = capture phase
    parent.addEventListener('click', () => {
      console.log('Parent capturing');
    }, true);
    child.addEventListener('click', () => {
      console.log('Child capturing');
    }, true);
    // Click button: Grandparent → Parent → Child

    // Stop propagation
    parent.addEventListener('click', (e) => {
      e.stopPropagation();               // Stop bubbling to grandparent
    });

    // Stop immediate propagation
    parent.addEventListener('click', (e) => {
      e.stopImmediatePropagation();      // Stop other listeners on same element
    });
<

DOMContentLoaded~                                          *dom-DOMContentLoaded*
    Fired when HTML parsed, before images/stylesheets fully loaded.
>
    document.addEventListener('DOMContentLoaded', () => {
      // DOM ready - safe to manipulate
      const button = document.querySelector('button');
      button.addEventListener('click', handleClick);
    });

    // vs window.load - waits for everything (images, etc.)
    window.addEventListener('load', () => {
      // Everything loaded
      console.log('All resources loaded');
    });
<

Event Delegation~                                          *dom-event-delegation*
>
    // Instead of adding listener to each item
    document.querySelector('.list').addEventListener('click', (e) => {
      if (e.target.matches('.item')) {
        console.log('Item clicked:', e.target);
      }
    });
<

Common Events~                                             *dom-events-common*
>
    // Mouse
    'click', 'dblclick', 'mousedown', 'mouseup', 'mousemove',
    'mouseenter', 'mouseleave', 'mouseover', 'mouseout'

    // Keyboard
    'keydown', 'keyup', 'keypress'

    // Form
    'submit', 'change', 'input', 'focus', 'blur'

    // Document
    'DOMContentLoaded', 'load', 'beforeunload', 'unload'

    // Window
    'resize', 'scroll'
<

Custom Events~                                             *dom-custom-events*
>
    const event = new CustomEvent('myevent', {
      detail: { data: 'value' },
      bubbles: true,
      cancelable: true
    });

    el.dispatchEvent(event);

    el.addEventListener('myevent', (e) => {
      console.log(e.detail.data);        // 'value'
    });
<

==============================================================================
4. Forms                                                       *dom-forms*

Form Values~                                               *dom-form-values*
>
    const form = document.querySelector('form');
    const input = form.querySelector('input[name="email"]');

    input.value;                         // Get value
    input.value = 'new value';           // Set value

    // Checkbox/Radio
    checkbox.checked;                    // true/false
    radio.checked = true;

    // Select
    select.value;                        // Selected value
    select.selectedIndex;                // Selected index
    select.options[0].selected = true;
<

Form Events~                                               *dom-form-events*
>
    form.addEventListener('submit', (e) => {
      e.preventDefault();
      const formData = new FormData(form);

      for (const [key, value] of formData.entries()) {
        console.log(key, value);
      }
    });

    input.addEventListener('input', (e) => {
      console.log('Value changed:', e.target.value);
    });

    input.addEventListener('change', (e) => {
      console.log('Value committed:', e.target.value);
    });
<

FormData~                                                  *dom-FormData*
>
    const formData = new FormData(form);

    formData.append('key', 'value');
    formData.get('key');
    formData.set('key', 'new value');
    formData.delete('key');
    formData.has('key');

    // Convert to object
    const data = Object.fromEntries(formData);
<

Validation~                                                *dom-form-validation*
>
    input.setCustomValidity('Invalid email');
    input.reportValidity();              // Show validation message

    input.checkValidity();               // true/false
    form.checkValidity();                // Check all inputs

    // HTML5 validation attributes
    // required, pattern, min, max, minlength, maxlength
<

==============================================================================
5. Storage                                                    *dom-storage*

localStorage~                                              *dom-localStorage*
    Persistent storage (no expiration).
>
    localStorage.setItem('key', 'value');
    const value = localStorage.getItem('key');
    localStorage.removeItem('key');
    localStorage.clear();

    // Store objects
    localStorage.setItem('user', JSON.stringify(user));
    const user = JSON.parse(localStorage.getItem('user'));
<

sessionStorage~                                            *dom-sessionStorage*
    Storage cleared when tab closes.
>
    sessionStorage.setItem('key', 'value');
    const value = sessionStorage.getItem('key');
<

Storage Event~                                             *dom-storage-event*
    Listen for storage changes in other tabs.
>
    window.addEventListener('storage', (e) => {
      console.log('Key:', e.key);
      console.log('Old value:', e.oldValue);
      console.log('New value:', e.newValue);
    });
<

==============================================================================
6. Web Components                                     *dom-web-components*

Custom Elements~                                           *dom-custom-elements*
>
    class MyButton extends HTMLElement {
      constructor() {
        super();
        this.attachShadow({ mode: 'open' });
      }

      connectedCallback() {
        this.shadowRoot.innerHTML = `
          <style>button { color: blue; }</style>
          <button><slot>Click</slot></button>
        `;
      }

      disconnectedCallback() {
        // Cleanup
      }

      attributeChangedCallback(name, oldVal, newVal) {
        // Attribute changed
      }

      static get observedAttributes() {
        return ['disabled'];
      }
    }

    customElements.define('my-button', MyButton);
<

Shadow DOM~                                                *dom-shadow-dom*
>
    const shadow = element.attachShadow({ mode: 'open' });
    shadow.innerHTML = `
      <style>p { color: red; }</style>
      <p>Shadow content</p>
    `;

    // Slots
    shadow.innerHTML = `
      <slot name="header"></slot>
      <slot></slot>
    `;
<

Templates~                                                 *dom-templates*
>
    const template = document.createElement('template');
    template.innerHTML = `
      <div class="card">
        <h2></h2>
        <p></p>
      </div>
    `;

    const clone = template.content.cloneNode(true);
    document.body.appendChild(clone);
<

==============================================================================
7. Web APIs                                                    *dom-apis*

Clipboard API~                                            *dom-clipboard*
>
    // Write text
    await navigator.clipboard.writeText('Hello');

    // Read text
    const text = await navigator.clipboard.readText();

    // Write rich content
    const blob = new Blob(['<p>HTML</p>'], { type: 'text/html' });
    await navigator.clipboard.write([
      new ClipboardItem({ 'text/html': blob })
    ]);
<

Drag and Drop~                                            *dom-drag-drop*
>
    // Make draggable
    el.draggable = true;

    el.addEventListener('dragstart', (e) => {
      e.dataTransfer.setData('text/plain', 'data');
      e.dataTransfer.effectAllowed = 'move';
    });

    // Drop zone
    dropZone.addEventListener('dragover', (e) => {
      e.preventDefault();
      e.dataTransfer.dropEffect = 'move';
    });

    dropZone.addEventListener('drop', (e) => {
      e.preventDefault();
      const data = e.dataTransfer.getData('text/plain');
      const files = e.dataTransfer.files;
    });
<

File API~                                                  *dom-file-api*
>
    const input = document.querySelector('input[type="file"]');

    input.addEventListener('change', (e) => {
      const file = e.target.files[0];

      const reader = new FileReader();
      reader.onload = (e) => {
        console.log(e.target.result);
      };

      reader.readAsText(file);           // Text
      reader.readAsDataURL(file);        // Data URL (base64)
      reader.readAsArrayBuffer(file);    // Binary
    });
<

Intersection Observer~                                     *dom-intersection-observer*
>
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add('visible');
        }
      });
    }, {
      threshold: 0.5,
      rootMargin: '0px'
    });

    observer.observe(element);
    observer.disconnect();
<

Mutation Observer~                                         *dom-mutation-observer*
>
    const observer = new MutationObserver((mutations) => {
      mutations.forEach(mutation => {
        console.log('Type:', mutation.type);
        console.log('Target:', mutation.target);
      });
    });

    observer.observe(element, {
      childList: true,
      attributes: true,
      subtree: true,
      attributeOldValue: true
    });

    observer.disconnect();
<

Resize Observer~                                           *dom-resize-observer*
>
    const observer = new ResizeObserver((entries) => {
      entries.forEach(entry => {
        console.log('Width:', entry.contentRect.width);
        console.log('Height:', entry.contentRect.height);
      });
    });

    observer.observe(element);
<

Fetch API~                                                 *dom-fetch*
    See |javascript-fetch|.

requestAnimationFrame()~                                   *dom-requestAnimationFrame()*
>
    function animate() {
      // Update animation
      element.style.left = `${x}px`;
      requestAnimationFrame(animate);
    }

    const id = requestAnimationFrame(animate);
    cancelAnimationFrame(id);
<

window.location~                                           *dom-location*
>
    window.location.href;                // Full URL
    window.location.pathname;            // /path
    window.location.search;              // ?query=value
    window.location.hash;                // #anchor
    window.location.reload();            // Reload page
    window.location.assign('/new');      // Navigate
<

window.history~                                            *dom-history*
>
    history.pushState({ page: 1 }, 'Title', '/page1');
    history.replaceState({ page: 2 }, 'Title', '/page2');
    history.back();
    history.forward();
    history.go(-2);

    window.addEventListener('popstate', (e) => {
      console.log('State:', e.state);
    });
<

URLSearchParams~                                           *dom-URLSearchParams*
>
    const params = new URLSearchParams(window.location.search);
    params.get('id');                    // Get value
    params.set('id', '123');             // Set value
    params.append('tag', 'news');        // Add value
    params.delete('id');                 // Remove
    params.has('id');                    // Check existence

    // Convert to string
    params.toString();                   // 'id=123&tag=news'

    // Iterate
    for (const [key, value] of params) {
      console.log(key, value);
    }
<

Page Visibility~                                           *dom-page-visibility*
>
    document.addEventListener('visibilitychange', () => {
      if (document.hidden) {
        pauseVideo();
      } else {
        playVideo();
      }
    });
<

Performance API~                                           *dom-performance*
>
    // Navigation timing
    const navigation = performance.getEntriesByType('navigation')[0];
    navigation.loadEventEnd;             // Page load time
    navigation.domContentLoadedEventEnd; // DOM ready time

    // Mark points in time
    performance.mark('start');
    doSomething();
    performance.mark('end');

    // Measure between marks
    performance.measure('operation', 'start', 'end');
    const measure = performance.getEntriesByName('operation')[0];
    console.log(measure.duration);

    // High resolution timestamp
    const start = performance.now();
    doSomething();
    const duration = performance.now() - start;

    // Resource timing
    const resources = performance.getEntriesByType('resource');
    resources.forEach(r => {
      console.log(r.name, r.duration);
    });
<

Web Workers~                                               *dom-web-workers*
    Run JavaScript in background thread.
>
    // Main thread
    const worker = new Worker('worker.js');

    worker.postMessage({ data: 'hello' });

    worker.onmessage = (e) => {
      console.log('From worker:', e.data);
    };

    worker.onerror = (error) => {
      console.error('Worker error:', error);
    };

    worker.terminate();

    // worker.js
    self.onmessage = (e) => {
      const result = heavyComputation(e.data);
      self.postMessage(result);
    };
<

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
