# RxJS Reference

Quick reference for RxJS. Use `/` to search in vim.

## Table of Contents

- [RxJS Reference](#rxjs-reference)
  - [Table of Contents](#table-of-contents)
  - [Observable Basics](#observable-basics)
    - [Creating Observables](#creating-observables)
    - [Subscribing](#subscribing)
    - [Unsubscribing](#unsubscribing)
  - [Creation Operators](#creation-operators)
    - [of()](#of)
    - [from()](#from)
    - [interval()](#interval)
    - [timer()](#timer)
    - [range()](#range)
    - [throwError()](#throwerror)
    - [EMPTY](#empty)
    - [NEVER](#never)
  - [Transformation Operators](#transformation-operators)
    - [map()](#map)
    - [switchMap()](#switchmap)
    - [mergeMap()](#mergemap)
    - [concatMap()](#concatmap)
    - [exhaustMap()](#exhaustmap)
    - [pluck()](#pluck)
    - [scan()](#scan)
    - [tap()](#tap)
  - [Filtering Operators](#filtering-operators)
    - [filter()](#filter)
    - [take()](#take)
    - [takeUntil()](#takeuntil)
    - [skip()](#skip)
    - [debounceTime()](#debouncetime)
    - [throttleTime()](#throttletime)
    - [distinctUntilChanged()](#distinctuntilchanged)
    - [first()](#first)
    - [last()](#last)
  - [Combination Operators](#combination-operators)
    - [merge()](#merge)
    - [combineLatest()](#combinelatest)
    - [concat()](#concat)
    - [forkJoin()](#forkjoin)
    - [zip()](#zip)
    - [withLatestFrom()](#withlatestfrom)
  - [Subjects](#subjects)
    - [Subject](#subject)
    - [BehaviorSubject](#behaviorsubject)
    - [ReplaySubject](#replaysubject)
    - [AsyncSubject](#asyncsubject)
  - [Error Handling](#error-handling)
    - [catchError()](#catcherror)
    - [retry()](#retry)
    - [retryWhen()](#retrywhen)
    - [finalize()](#finalize)
  - [Utility Operators](#utility-operators)
    - [startWith()](#startwith)
    - [defaultIfEmpty()](#defaultifempty)
    - [delay()](#delay)
    - [timeout()](#timeout)
  - [Sharing Operators](#sharing-operators)
    - [shareReplay()](#sharereplay)
    - [share()](#share)
  - [Common Patterns](#common-patterns)
    - [Search with Debounce](#search-with-debounce)
    - [Auto-unsubscribe with takeUntil](#auto-unsubscribe-with-takeuntil)
    - [Handle Loading States](#handle-loading-states)
    - [Combine Multiple Requests](#combine-multiple-requests)
    - [Rate Limit with ThrottleTime](#rate-limit-with-throttletime)
    - [Polling with Interval](#polling-with-interval)

## Observable Basics

### Creating Observables

An Observable is a lazy, push-based data stream.

```typescript
import { Observable } from "rxjs";

const observable = new Observable((subscriber) => {
  subscriber.next("Hello");
  subscriber.next("World");
  subscriber.complete();
  // subscriber.error(new Error('Something went wrong'));
});
```

### Subscribing

```typescript
const subscription = observable.subscribe({
  next: (value) => console.log(value),
  error: (err) => console.error(err),
  complete: () => console.log("Done"),
});

// Or with arrow functions
observable.subscribe(
  (value) => console.log(value),
  (error) => console.error(error),
  () => console.log("Done")
);
```

### Unsubscribing

```typescript
// Unsubscribe manually
const subscription = observable.subscribe(...);
subscription.unsubscribe();

// Unsubscribe on destroy
import { Subscription } from 'rxjs';

private subscriptions = new Subscription();

ngOnInit() {
  this.subscriptions.add(
    observable1.subscribe(...)
  );
  this.subscriptions.add(
    observable2.subscribe(...)
  );
}

ngOnDestroy() {
  this.subscriptions.unsubscribe();
}

// Or use async pipe in Angular (auto-unsubscribes)
observable$ | async
```

## Creation Operators

### of()

Create observable from values.

```typescript
import { of } from "rxjs";

of(1, 2, 3).subscribe(console.log);
// 1, 2, 3

of({ name: "John" }).subscribe(console.log);
// {name: 'John'}
```

### from()

Create observable from array, promise, or iterable.

```typescript
import { from } from "rxjs";

// From array
from([1, 2, 3]).subscribe(console.log);
// 1, 2, 3

// From promise
from(Promise.resolve("Done")).subscribe(console.log);
// Done

// From string
from("hello").subscribe(console.log);
// h, e, l, l, o
```

### interval()

Emit incremental numbers at intervals.

```typescript
import { interval } from "rxjs";

interval(1000).subscribe((value) => {
  console.log(value); // 0, 1, 2, 3...
});
```

### timer()

Emit after delay, optionally repeating.

```typescript
import { timer } from "rxjs";

// Emit once after 2 seconds
timer(2000).subscribe(() => console.log("Done"));

// Emit after 2 seconds, then every 1 second
timer(2000, 1000).subscribe((value) => console.log(value));
```

### range()

Emit sequence of numbers.

```typescript
import { range } from "rxjs";

range(1, 5).subscribe(console.log);
// 1, 2, 3, 4, 5
```

### throwError()

Create observable that errors.

```typescript
import { throwError } from "rxjs";

throwError(() => new Error("Oops!")).subscribe(
  () => {},
  (error) => console.error(error)
);
```

### EMPTY

Create observable that completes immediately.

```typescript
import { EMPTY } from "rxjs";

EMPTY.subscribe({
  next: () => console.log("Never called"),
  complete: () => console.log("Done"),
});
```

### NEVER

Create observable that never emits or completes.

```typescript
import { NEVER } from "rxjs";

NEVER.subscribe(() => console.log("Never called"));
```

## Transformation Operators

### map()

Transform each emitted value.

```typescript
import { of } from "rxjs";
import { map } from "rxjs/operators";

of(1, 2, 3)
  .pipe(map((x) => x * 2))
  .subscribe(console.log);
// 2, 4, 6
```

### switchMap()

Map to observable, subscribe to latest (cancels previous).

```typescript
import { switchMap } from "rxjs/operators";

userClickedSearch$
  .pipe(
    switchMap((searchTerm) => httpClient.get(`/api/search?q=${searchTerm}`))
  )
  .subscribe((results) => console.log(results));

// If user searches again before previous request completes,
// previous request is cancelled
```

### mergeMap()

Map to observable, merge all (subscribe to all).

```typescript
import { mergeMap } from "rxjs/operators";

userIds$
  .pipe(mergeMap((userId) => httpClient.get(`/api/users/${userId}`)))
  .subscribe((user) => console.log(user));

// All requests execute in parallel
```

### concatMap()

Map to observable, concat all (sequential).

```typescript
import { concatMap } from "rxjs/operators";

requests$
  .pipe(concatMap((request) => httpClient.post("/api/data", request)))
  .subscribe((response) => console.log(response));

// Requests execute one at a time in order
```

### exhaustMap()

Map to observable, ignore while executing.

```typescript
import { exhaustMap } from "rxjs/operators";

submitButton$
  .pipe(exhaustMap(() => httpClient.post("/api/submit", data)))
  .subscribe((response) => console.log(response));

// If user clicks again while request is pending, click is ignored
```

### pluck()

Extract property from emitted object.

```typescript
import { pluck } from "rxjs/operators";

users$.pipe(pluck("name")).subscribe(console.log);
// 'John', 'Jane', 'Bob'
```

### scan()

Reduce with accumulator (like Array.reduce).

```typescript
import { scan } from "rxjs/operators";

of(1, 2, 3, 4)
  .pipe(scan((acc, x) => acc + x, 0))
  .subscribe(console.log);
// 1, 3, 6, 10

// Track clicks
clickCount$ = clicks$.pipe(scan((count) => count + 1, 0));
```

### tap()

Side effects, pass through value.

```typescript
import { tap } from "rxjs/operators";

data$
  .pipe(
    tap((value) => console.log("Debug:", value)),
    map((value) => value * 2),
    tap((value) => console.log("After map:", value))
  )
  .subscribe();
```

## Filtering Operators

### filter()

Keep values that match condition.

```typescript
import { filter } from "rxjs/operators";

of(1, 2, 3, 4, 5)
  .pipe(filter((x) => x > 2))
  .subscribe(console.log);
// 3, 4, 5
```

### take()

Emit only first n values.

```typescript
import { take } from "rxjs/operators";

interval(1000).pipe(take(3)).subscribe(console.log);
// 0, 1, 2 (then completes)
```

### takeUntil()

Emit until other observable emits.

```typescript
import { takeUntil } from "rxjs/operators";

data$.pipe(takeUntil(destroy$)).subscribe((value) => console.log(value));

// When destroy$ emits, data$ is unsubscribed
// Common pattern with ngOnDestroy
```

### skip()

Skip first n values.

```typescript
import { skip } from "rxjs/operators";

of(1, 2, 3, 4, 5).pipe(skip(2)).subscribe(console.log);
// 3, 4, 5
```

### debounceTime()

Emit after n milliseconds of inactivity.

```typescript
import { debounceTime } from "rxjs/operators";

searchInput$
  .pipe(
    debounceTime(300),
    switchMap((term) => searchAPI(term))
  )
  .subscribe((results) => console.log(results));

// Only search after user stops typing for 300ms
```

### throttleTime()

Emit at most once per n milliseconds.

```typescript
import { throttleTime } from "rxjs/operators";

scroll$.pipe(throttleTime(300)).subscribe(() => console.log("Scrolling"));

// Log scrolling at most every 300ms
```

### distinctUntilChanged()

Emit only if value changed.

```typescript
import { distinctUntilChanged } from "rxjs/operators";

of(1, 1, 2, 2, 3, 1).pipe(distinctUntilChanged()).subscribe(console.log);
// 1, 2, 3, 1

// Compare objects by property
user$
  .pipe(distinctUntilChanged((prev, curr) => prev.id === curr.id))
  .subscribe(console.log);
```

### first()

Emit only first value (completes after).

```typescript
import { first } from "rxjs/operators";

interval(1000).pipe(first()).subscribe(console.log);
// 0 (then completes)

// With condition
of(1, 2, 3, 4)
  .pipe(first((x) => x > 2))
  .subscribe(console.log);
// 3 (then completes)
```

### last()

Emit only last value (completes after).

```typescript
import { last } from "rxjs/operators";

of(1, 2, 3).pipe(last()).subscribe(console.log);
// 3

// With condition
of(1, 2, 3, 4)
  .pipe(last((x) => x < 4))
  .subscribe(console.log);
// 3
```

## Combination Operators

### merge()

Merge multiple observables.

```typescript
import { merge } from "rxjs";

const obs1 = interval(1000);
const obs2 = interval(2000);

merge(obs1, obs2).subscribe(console.log);
// Emits from both observables
```

### combineLatest()

Combine latest values from multiple observables.

```typescript
import { combineLatest } from "rxjs";

const firstName$ = firstNameInput$;
const lastName$ = lastNameInput$;

combineLatest([firstName$, lastName$])
  .pipe(map(([first, last]) => `${first} ${last}`))
  .subscribe((fullName) => console.log(fullName));

// Emits whenever either input changes (both must have emitted once)
```

### concat()

Concatenate observables sequentially.

```typescript
import { concat } from "rxjs";

const obs1 = of(1, 2, 3);
const obs2 = of(4, 5, 6);

concat(obs1, obs2).subscribe(console.log);
// 1, 2, 3, 4, 5, 6

// Waits for obs1 to complete before subscribing to obs2
```

### forkJoin()

Wait for all observables to complete.

```typescript
import { forkJoin } from "rxjs";

forkJoin({
  users: httpClient.get("/api/users"),
  posts: httpClient.get("/api/posts"),
  comments: httpClient.get("/api/comments"),
}).subscribe(({ users, posts, comments }) => {
  console.log(users, posts, comments);
});

// Like Promise.all() - waits for all to complete
```

### zip()

Combine values at same index.

```typescript
import { zip } from "rxjs";

const obs1 = of(1, 2, 3);
const obs2 = of("a", "b", "c");

zip(obs1, obs2).subscribe(console.log);
// [1, 'a'], [2, 'b'], [3, 'c']
```

### withLatestFrom()

Combine with latest value from another observable.

```typescript
import { withLatestFrom } from "rxjs/operators";

clickEvent$
  .pipe(
    withLatestFrom(currentUser$),
    map(([click, user]) => ({ click, user }))
  )
  .subscribe(({ click, user }) => {
    console.log(`${user.name} clicked`);
  });

// Emits when clickEvent$ emits, includes latest currentUser$ value
```

## Subjects

### Subject

Multicast observable (hot observable).

```typescript
import { Subject } from "rxjs";

const subject = new Subject<string>();

// Subscribe 1
subject.subscribe((value) => console.log("Sub1:", value));

// Emit value
subject.next("Hello");

// Subscribe 2 (misses 'Hello')
subject.subscribe((value) => console.log("Sub2:", value));

subject.next("World");
// Sub1: Hello
// Sub1: World
// Sub2: World
```

### BehaviorSubject

Subject that replays current value to new subscribers.

```typescript
import { BehaviorSubject } from "rxjs";

const subject = new BehaviorSubject<number>(0);

subject.subscribe((value) => console.log("Sub1:", value)); // 0

subject.next(1);

subject.subscribe((value) => console.log("Sub2:", value)); // 1

subject.next(2);
// Sub1: 0
// Sub1: 1
// Sub2: 1
// Sub1: 2
// Sub2: 2

// Get current value synchronously
const current = subject.value; // 2
```

### ReplaySubject

Subject that replays multiple past values.

```typescript
import { ReplaySubject } from "rxjs";

const subject = new ReplaySubject<number>(2); // Replay last 2 values

subject.next(1);
subject.next(2);
subject.next(3);

subject.subscribe((value) => console.log("Sub1:", value));
// 2, 3 (last 2 values)

subject.next(4);
// Sub1: 4
```

### AsyncSubject

Subject that emits last value on complete.

```typescript
import { AsyncSubject } from "rxjs";

const subject = new AsyncSubject<number>();

subject.subscribe((value) => console.log("Sub1:", value));

subject.next(1);
subject.next(2);
subject.next(3);

subject.subscribe((value) => console.log("Sub2:", value));

subject.complete();
// Sub1: 3
// Sub2: 3

// Only emits the last value when completed
```

## Error Handling

### catchError()

Catch errors and provide recovery.

```typescript
import { catchError } from "rxjs/operators";
import { of, throwError } from "rxjs";

data$
  .pipe(
    catchError((error) => {
      console.error("Error:", error);
      return of(defaultValue); // Recover
      // or: return throwError(() => error); // Re-throw
    })
  )
  .subscribe((value) => console.log(value));
```

### retry()

Retry failed observable.

```typescript
import { retry } from "rxjs/operators";

httpClient
  .get("/api/data")
  .pipe(
    retry(3) // Retry up to 3 times
  )
  .subscribe(
    (data) => console.log(data),
    (error) => console.error("Failed after retries:", error)
  );
```

### retryWhen()

Retry with custom logic.

```typescript
import { retryWhen, delay, take } from "rxjs/operators";

httpClient
  .get("/api/data")
  .pipe(
    retryWhen((errors) =>
      errors.pipe(
        delay(1000), // Wait 1 second
        take(3) // Retry max 3 times
      )
    )
  )
  .subscribe(
    (data) => console.log(data),
    (error) => console.error("Failed:", error)
  );
```

### finalize()

Execute cleanup logic.

```typescript
import { finalize } from "rxjs/operators";

data$
  .pipe(
    finalize(() => {
      console.log("Observable completed or errored");
      // Cleanup: stop loading spinner, etc.
    })
  )
  .subscribe(
    (value) => console.log(value),
    (error) => console.error(error)
  );
```

## Utility Operators

### startWith()

Emit initial value before source.

```typescript
import { startWith } from "rxjs/operators";

interval(1000).pipe(startWith(0)).subscribe(console.log);
// 0 (immediately), then 0, 1, 2...
```

### defaultIfEmpty()

Emit default if source completes empty.

```typescript
import { defaultIfEmpty } from "rxjs/operators";

of().pipe(defaultIfEmpty("No value")).subscribe(console.log);
// No value
```

### delay()

Delay emission by n milliseconds.

```typescript
import { delay } from "rxjs/operators";

of(1, 2, 3).pipe(delay(1000)).subscribe(console.log);
// After 1 second: 1, 2, 3
```

### timeout()

Error if no emission within time.

```typescript
import { timeout } from "rxjs/operators";

httpClient
  .get("/api/data")
  .pipe(
    timeout(5000) // 5 second timeout
  )
  .subscribe(
    (data) => console.log(data),
    (error) => console.error("Timeout or error:", error)
  );
```

## Sharing Operators

### shareReplay()

Share single subscription and cache latest values.

```typescript
import { shareReplay } from "rxjs/operators";

const data$ = httpClient.get("/api/data").pipe(
  shareReplay(1) // Cache last 1 value
);

// All subscribers share same subscription
data$.subscribe((value) => console.log("Sub1:", value));
data$.subscribe((value) => console.log("Sub2:", value));
// Only one HTTP request made
```

**Use cases:**

- Prevent multiple HTTP requests
- Share data across multiple components
- Cache latest value for late subscribers

```typescript
// Real-world example: User data that multiple components need
const user$ = this.http.get("/api/user").pipe(shareReplay(1));

// Component 1: Header
user$.subscribe((user) => (this.headerUser = user));

// Component 2: Profile (subscribes later, still gets cached value)
user$.subscribe((user) => (this.profileUser = user));
```

**Parameter:**

- `bufferSize`: Number of values to cache (typically 1)
- If new subscriber comes after source completes, they get cached values

```typescript
// Cache multiple values
interval(1000)
  .pipe(
    take(5),
    shareReplay(2) // Keep last 2 values in cache
  )
  .subscribe(console.log);

// Late subscriber gets last 2 cached values immediately
```

### share()

Share subscription without caching.

```typescript
import { share } from "rxjs/operators";

const data$ = httpClient.get("/api/data").pipe(
  share() // Share subscription, no cache
);

// Multiple subscribers share one request
data$.subscribe((value) => console.log("Sub1:", value));
data$.subscribe((value) => console.log("Sub2:", value));
// Only one HTTP request

// But if first subscriber unsubscribes, source resets
// New subscriber will trigger new request
```

**Difference from shareReplay():**

- `share()`: No caching, resets when all unsubscribe
- `shareReplay()`: Caches values, late subscribers get cached data

```typescript
// Use share() when you don't need caching
const clicks$ = fromEvent(button, "click").pipe(share());

clicks$.subscribe(/* handler 1 */);
clicks$.subscribe(/* handler 2 */);
// Multiple handlers on same click event
```

## Common Patterns

### Search with Debounce

```typescript
import { debounceTime, distinctUntilChanged, switchMap } from 'rxjs/operators';

search(term: string): Observable<User[]> {
  return this.searchInput$.pipe(
    debounceTime(300),
    distinctUntilChanged(),
    switchMap(term => this.userService.search(term)),
    catchError(() => of([]))
  );
}
```

### Auto-unsubscribe with takeUntil

```typescript
private destroy$ = new Subject<void>();

ngOnInit() {
  data$.pipe(
    takeUntil(this.destroy$)
  ).subscribe(value => console.log(value));
}

ngOnDestroy() {
  this.destroy$.next();
  this.destroy$.complete();
}
```

### Handle Loading States

```typescript
loading$ = new BehaviorSubject(false);
data$ = new BehaviorSubject([]);

fetchData() {
  this.loading$.next(true);

  this.apiService.getData().pipe(
    tap(data => this.data$.next(data)),
    finalize(() => this.loading$.next(false)),
    catchError(error => {
      console.error(error);
      return of([]);
    })
  ).subscribe();
}
```

### Combine Multiple Requests

```typescript
import { combineLatest } from "rxjs";

const users$ = this.apiService.getUsers();
const posts$ = this.apiService.getPosts();
const comments$ = this.apiService.getComments();

combineLatest([users$, posts$, comments$])
  .pipe(map(([users, posts, comments]) => ({ users, posts, comments })))
  .subscribe((data) => console.log(data));
```

### Rate Limit with ThrottleTime

```typescript
import { throttleTime } from "rxjs/operators";

windowResize$
  .pipe(
    throttleTime(300),
    tap(() => this.recalculateLayout())
  )
  .subscribe();
```

### Polling with Interval

```typescript
import { interval, switchMap } from "rxjs/operators";

const poll$ = interval(5000).pipe(
  switchMap(() => this.apiService.getData()),
  tap((data) => console.log("Polled data:", data))
);

const subscription = poll$.subscribe();
// subscription.unsubscribe() to stop polling
```
