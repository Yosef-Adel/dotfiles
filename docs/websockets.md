*websockets.txt*  WebSockets Reference

==============================================================================
CONTENTS                                                *websockets-contents*

1. Overview .............................. |websockets-overview|
2. Client-Side (Browser) ................. |websockets-client|
3. Server-Side (Node.js) ................. |websockets-server|
4. Connection Lifecycle .................. |websockets-lifecycle|
5. Message Formats ....................... |websockets-messages|
6. Error Handling ........................ |websockets-errors|
7. Heartbeat/Ping-Pong ................... |websockets-heartbeat|
8. Reconnection .......................... |websockets-reconnection|
9. Authentication ........................ |websockets-auth|
10. Socket.IO ............................ |websockets-socketio|
11. Best Practices ....................... |websockets-best-practices|

==============================================================================
1. OVERVIEW                                             *websockets-overview*

WebSocket Protocol~                              *websockets-overview-protocol*
>
    WebSocket Protocol (RFC 6455)
    - Full-duplex communication over single TCP connection
    - Persistent connection (no polling required)
    - Low latency
    - Binary and text messages
    - Less overhead than HTTP polling

    Use cases:
    - Chat applications
    - Real-time dashboards
    - Live notifications
    - Collaborative editing
    - Online gaming
    - Stock tickers
<

==============================================================================
2. CLIENT-SIDE (BROWSER)                                 *websockets-client*

WebSocket basics~                                  *websockets-client-basic*
>
    // Create WebSocket connection
    const ws = new WebSocket('ws://localhost:8080');
    // Or secure WebSocket
    const wss = new WebSocket('wss://example.com/socket');

    // Connection opened
    ws.addEventListener('open', (event) => {
      console.log('Connected to WebSocket');
      ws.send('Hello Server!');
    });

    // Listen for messages
    ws.addEventListener('message', (event) => {
      console.log('Message from server:', event.data);

      // Parse JSON if needed
      const data = JSON.parse(event.data);
      console.log(data);
    });

    // Connection closed
    ws.addEventListener('close', (event) => {
      console.log('Disconnected', event.code, event.reason);
    });

    // Connection error
    ws.addEventListener('error', (error) => {
      console.error('WebSocket error:', error);
    });

    // Send message
    ws.send('Hello Server!');
    ws.send(JSON.stringify({ type: 'message', content: 'Hello' }));

    // Send binary data
    const arrayBuffer = new ArrayBuffer(8);
    ws.send(arrayBuffer);
    ws.send(new Blob(['binary data']));

    // Close connection
    ws.close();
    ws.close(1000, 'Normal closure');

    // Check connection state
    console.log(ws.readyState);
    // 0 = CONNECTING
    // 1 = OPEN
    // 2 = CLOSING
    // 3 = CLOSED
<

==============================================================================
3. SERVER-SIDE (NODE.JS)                                 *websockets-server*

Server setup~                                      *websockets-server-setup*
>
    // Using 'ws' library
    const WebSocket = require('ws');
    const wss = new WebSocket.Server({ port: 8080 });

    // Connection handler
    wss.on('connection', (ws, req) => {
      console.log('Client connected');
      console.log('IP:', req.socket.remoteAddress);

      // Send welcome message
      ws.send('Welcome to the server!');

      // Receive messages
      ws.on('message', (data) => {
        console.log('Received:', data.toString());

        // Echo back
        ws.send(`You said: ${data}`);

        // Broadcast to all clients
        wss.clients.forEach((client) => {
          if (client.readyState === WebSocket.OPEN) {
            client.send(data);
          }
        });

        // Broadcast to others (not sender)
        wss.clients.forEach((client) => {
          if (client !== ws && client.readyState === WebSocket.OPEN) {
            client.send(data);
          }
        });
      });

      // Connection closed
      ws.on('close', () => {
        console.log('Client disconnected');
      });

      // Error handler
      ws.on('error', (error) => {
        console.error('WebSocket error:', error);
      });
    });
<

With Express~                                    *websockets-server-express*
>
    // With Express
    const express = require('express');
    const app = express();
    const server = app.listen(3000);
    const wss = new WebSocket.Server({ server });

    // HTTP upgrade
    server.on('upgrade', (request, socket, head) => {
      wss.handleUpgrade(request, socket, head, (ws) => {
        wss.emit('connection', ws, request);
      });
    });
<

==============================================================================
4. CONNECTION LIFECYCLE                              *websockets-lifecycle*

Connection flow~                               *websockets-lifecycle-flow*
>
    // Client-side connection flow
    const ws = new WebSocket('ws://localhost:8080');

    // 1. CONNECTING (readyState = 0)
    console.log('Connecting...');

    ws.addEventListener('open', () => {
      // 2. OPEN (readyState = 1)
      console.log('Connected!');
      ws.send('Hello!');
    });

    ws.addEventListener('message', (event) => {
      // 3. Receiving messages
      console.log('Message:', event.data);
    });

    ws.addEventListener('close', (event) => {
      // 4. CLOSED (readyState = 3)
      console.log('Disconnected');
      console.log('Code:', event.code);
      console.log('Reason:', event.reason);
      console.log('Clean:', event.wasClean);
    });
<

Close codes~                                    *websockets-lifecycle-codes*
>
    1000 // Normal closure
    1001 // Going away
    1002 // Protocol error
    1003 // Unsupported data
    1006 // Abnormal closure
    1007 // Invalid data
    1008 // Policy violation
    1009 // Message too big
    1011 // Server error
<

==============================================================================
5. MESSAGE FORMATS                                      *websockets-messages*

JSON messages~                                  *websockets-messages-json*
>
    // JSON messages (recommended)
    // Client
    const message = {
      type: 'chat',
      user: 'John',
      content: 'Hello!',
      timestamp: Date.now()
    };
    ws.send(JSON.stringify(message));

    // Server
    ws.on('message', (data) => {
      const message = JSON.parse(data);
      console.log(message.type, message.content);
    });
<

Event-based messages~                          *websockets-messages-events*
>
    // Event-based messages
    const createMessage = (type, payload) => {
      return JSON.stringify({ type, payload, timestamp: Date.now() });
    };

    ws.send(createMessage('join', { room: 'lobby', user: 'John' }));
    ws.send(createMessage('message', { text: 'Hello!' }));
    ws.send(createMessage('leave', { room: 'lobby' }));

    // Server handler
    ws.on('message', (data) => {
      const { type, payload } = JSON.parse(data);

      switch (type) {
        case 'join':
          handleJoin(payload);
          break;
        case 'message':
          handleMessage(payload);
          break;
        case 'leave':
          handleLeave(payload);
          break;
      }
    });
<

Binary messages~                              *websockets-messages-binary*
>
    // Binary messages
    const buffer = new ArrayBuffer(8);
    const view = new DataView(buffer);
    view.setInt32(0, 12345);
    ws.send(buffer);
<

==============================================================================
6. ERROR HANDLING                                        *websockets-errors*

Client-side errors~                              *websockets-errors-client*
>
    // Client-side
    const ws = new WebSocket('ws://localhost:8080');

    ws.addEventListener('error', (error) => {
      console.error('WebSocket error:', error);
      // Try to reconnect
    });

    ws.addEventListener('close', (event) => {
      if (!event.wasClean) {
        console.error('Connection died unexpectedly');
      }
    });
<

Server-side errors~                              *websockets-errors-server*
>
    // Server-side
    wss.on('connection', (ws) => {
      ws.on('error', (error) => {
        console.error('Client error:', error);
      });

      ws.on('close', (code, reason) => {
        console.log(`Client disconnected: ${code} - ${reason}`);
      });
    });

    // Graceful shutdown
    process.on('SIGTERM', () => {
      wss.clients.forEach((ws) => {
        ws.close(1001, 'Server shutting down');
      });
      wss.close(() => {
        console.log('Server closed');
        process.exit(0);
      });
    });
<

==============================================================================
7. HEARTBEAT/PING-PONG                                *websockets-heartbeat*

Server-side heartbeat~                        *websockets-heartbeat-server*
>
    // Server-side heartbeat
    const WebSocket = require('ws');
    const wss = new WebSocket.Server({ port: 8080 });

    wss.on('connection', (ws) => {
      ws.isAlive = true;

      ws.on('pong', () => {
        ws.isAlive = true;
      });

      ws.on('close', () => {
        clearInterval(ws.pingInterval);
      });
    });

    // Ping clients every 30 seconds
    const interval = setInterval(() => {
      wss.clients.forEach((ws) => {
        if (ws.isAlive === false) {
          return ws.terminate();
        }

        ws.isAlive = false;
        ws.ping();
      });
    }, 30000);

    wss.on('close', () => {
      clearInterval(interval);
    });
<

Client-side heartbeat~                        *websockets-heartbeat-client*
>
    // Client-side (automatic pong response)
    // Browsers automatically respond to ping frames
    // Manual heartbeat implementation
    const ws = new WebSocket('ws://localhost:8080');
    let heartbeatInterval;

    ws.addEventListener('open', () => {
      heartbeatInterval = setInterval(() => {
        if (ws.readyState === WebSocket.OPEN) {
          ws.send(JSON.stringify({ type: 'heartbeat' }));
        }
      }, 30000);
    });

    ws.addEventListener('close', () => {
      clearInterval(heartbeatInterval);
    });
<

==============================================================================
8. RECONNECTION                                      *websockets-reconnection*

Auto-reconnect client~                      *websockets-reconnection-client*
>
    // Auto-reconnect client
    class WebSocketClient {
      constructor(url) {
        this.url = url;
        this.reconnectInterval = 5000;
        this.maxReconnectAttempts = 10;
        this.reconnectAttempts = 0;
        this.connect();
      }

      connect() {
        this.ws = new WebSocket(this.url);

        this.ws.addEventListener('open', () => {
          console.log('Connected');
          this.reconnectAttempts = 0;
          this.onOpen();
        });

        this.ws.addEventListener('message', (event) => {
          this.onMessage(event.data);
        });

        this.ws.addEventListener('close', () => {
          console.log('Disconnected');
          this.reconnect();
        });

        this.ws.addEventListener('error', (error) => {
          console.error('Error:', error);
        });
      }

      reconnect() {
        if (this.reconnectAttempts < this.maxReconnectAttempts) {
          this.reconnectAttempts++;
          console.log(`Reconnecting... (${this.reconnectAttempts})`);
          setTimeout(() => this.connect(), this.reconnectInterval);
        } else {
          console.error('Max reconnection attempts reached');
        }
      }

      send(data) {
        if (this.ws.readyState === WebSocket.OPEN) {
          this.ws.send(data);
        }
      }

      close() {
        this.ws.close();
      }

      onOpen() {
        // Override in subclass
      }

      onMessage(data) {
        // Override in subclass
      }
    }

    // Usage
    const client = new WebSocketClient('ws://localhost:8080');
    client.onOpen = () => {
      client.send('Hello!');
    };
    client.onMessage = (data) => {
      console.log('Message:', data);
    };
<

==============================================================================
9. AUTHENTICATION                                           *websockets-auth*

Query parameters~                                  *websockets-auth-query*
>
    // Using query parameters
    const token = 'user-auth-token';
    const ws = new WebSocket(`ws://localhost:8080?token=${token}`);

    // Server-side
    wss.on('connection', (ws, req) => {
      const url = new URL(req.url, `http://${req.headers.host}`);
      const token = url.searchParams.get('token');

      if (!isValidToken(token)) {
        ws.close(1008, 'Invalid token');
        return;
      }

      // Associate user with connection
      ws.userId = getUserIdFromToken(token);
    });
<

Post-connection auth~                          *websockets-auth-postconnect*
>
    // Post-connection authentication
    ws.addEventListener('open', () => {
      ws.send(JSON.stringify({
        type: 'auth',
        token: 'user-auth-token'
      }));
    });

    // Server handles auth message
    ws.on('message', (data) => {
      const message = JSON.parse(data);

      if (message.type === 'auth') {
        if (isValidToken(message.token)) {
          ws.isAuthenticated = true;
          ws.userId = getUserIdFromToken(message.token);
          ws.send(JSON.stringify({ type: 'auth', success: true }));
        } else {
          ws.close(1008, 'Invalid credentials');
        }
        return;
      }

      if (!ws.isAuthenticated) {
        ws.close(1008, 'Not authenticated');
        return;
      }

      // Handle other messages
    });
<

==============================================================================
10. SOCKET.IO                                           *websockets-socketio*

Socket.IO features~                              *websockets-socketio-features*
>
    // Socket.IO provides additional features
    // - Automatic reconnection
    // - Event-based communication
    // - Rooms and namespaces
    // - Fallback to polling
<

Client-side~                                       *websockets-socketio-client*
>
    // Client (with socket.io-client)
    const socket = io('http://localhost:3000');

    socket.on('connect', () => {
      console.log('Connected:', socket.id);
    });

    socket.on('message', (data) => {
      console.log('Message:', data);
    });

    socket.emit('message', { text: 'Hello!' });

    socket.on('disconnect', () => {
      console.log('Disconnected');
    });
<

Server-side~                                       *websockets-socketio-server*
>
    // Server (with socket.io)
    const io = require('socket.io')(3000);

    io.on('connection', (socket) => {
      console.log('Client connected:', socket.id);

      socket.on('message', (data) => {
        console.log('Message:', data);

        // Send to sender
        socket.emit('message', 'Message received');

        // Broadcast to all
        io.emit('message', data);

        // Broadcast to others
        socket.broadcast.emit('message', data);
      });

      socket.on('disconnect', () => {
        console.log('Client disconnected');
      });
    });

    // Rooms
    socket.join('room1');
    socket.leave('room1');
    io.to('room1').emit('message', 'Hello room');

    // Namespaces
    const chatNamespace = io.of('/chat');
    chatNamespace.on('connection', (socket) => {
      console.log('Chat client connected');
    });
<

==============================================================================
11. BEST PRACTICES                                *websockets-best-practices*

Best practices~                              *websockets-best-practices-list*
>
    // 1. Use secure WebSockets in production
    const ws = new WebSocket('wss://example.com/socket');

    // 2. Implement reconnection logic
    // See reconnection example above

    // 3. Use heartbeat/ping-pong
    // Detect dead connections

    // 4. Validate and sanitize all messages
    ws.on('message', (data) => {
      try {
        const message = JSON.parse(data);
        if (!isValidMessage(message)) {
          return;
        }
        handleMessage(message);
      } catch (error) {
        console.error('Invalid message:', error);
      }
    });

    // 5. Rate limiting
    const rateLimiter = new Map();

    ws.on('message', (data) => {
      const userId = ws.userId;
      const now = Date.now();
      const userRequests = rateLimiter.get(userId) || [];

      // Keep only last minute
      const recentRequests = userRequests.filter(
        time => now - time < 60000
      );

      if (recentRequests.length >= 100) {
        ws.send(JSON.stringify({ error: 'Rate limit exceeded' }));
        return;
      }

      recentRequests.push(now);
      rateLimiter.set(userId, recentRequests);

      handleMessage(data);
    });

    // 6. Handle backpressure
    if (ws.bufferedAmount > 1024 * 1024) {
      // Too much data buffered
      console.warn('Buffer full, slowing down');
    }

    // 7. Graceful shutdown
    process.on('SIGTERM', () => {
      wss.clients.forEach((ws) => {
        ws.close(1001, 'Server restarting');
      });
    });

    // 8. Error boundaries
    ws.on('message', (data) => {
      try {
        handleMessage(data);
      } catch (error) {
        console.error('Handler error:', error);
        ws.send(JSON.stringify({ error: 'Internal error' }));
      }
    });

    // 9. Clean up resources
    ws.on('close', () => {
      // Clear intervals
      clearInterval(ws.pingInterval);
      // Remove from data structures
      clients.delete(ws.userId);
      // Close database connections
      ws.db?.close();
    });

    // 10. Monitor connections
    console.log('Active connections:', wss.clients.size);

    setInterval(() => {
      console.log('Connections:', wss.clients.size);
    }, 60000);
<

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
