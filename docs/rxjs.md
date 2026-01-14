*rxjs.txt*  RxJS Reference

==============================================================================
CONTENTS                                                      *rxjs-contents*

1. Observables ........................... |rxjs-observables|
2. Creation Operators .................... |rxjs-creation|
3. Transformation Operators .............. |rxjs-transformation|
4. Filtering Operators ................... |rxjs-filtering|
5. Combination Operators ................. |rxjs-combination|
6. Subjects .............................. |rxjs-subjects|
7. Error Handling ........................ |rxjs-errors|
8. Utility Operators ..................... |rxjs-utility|
9. Sharing Operators ..................... |rxjs-sharing|
10. Patterns ............................. |rxjs-patterns|
11. Testing .............................. |rxjs-testing|

==============================================================================
1. Observables                                            *rxjs-observables*

Observable~
    Lazy, push-based data stream. See |rxjs-creation| for creation methods.
>
    import { Observable } from 'rxjs';

    const obs$ = new Observable(subscriber => {
      subscriber.next(1);
      subscriber.complete();
    });
<

Subscribing~                                              *rxjs-subscribe*
>
    obs$.subscribe({
      next: (val) => console.log(val),
      error: (err) => console.error(err),
      complete: () => console.log('Done')
    });
<

Unsubscribing~                                            *rxjs-unsubscribe*
>
    const sub = obs$.subscribe(...);
    sub.unsubscribe();

    // Multiple subscriptions
    const subs = new Subscription();
    subs.add(obs1$.subscribe(...));
    subs.add(obs2$.subscribe(...));
    subs.unsubscribe(); // Unsubscribe all
<

Pipe~                                                     *rxjs-pipe*
    Chain operators together.
>
    obs$.pipe(
      map(x => x * 2),
      filter(x => x > 10)
    ).subscribe(console.log);
<

==============================================================================
2. Creation Operators                                     *rxjs-creation*

of()~                                                     *rxjs-of()*
    Emit values in sequence, then complete.
>
    of(1, 2, 3).subscribe(console.log); // 1, 2, 3
<

from()~                                                   *rxjs-from()*
    Convert array, promise, iterable to observable.
>
    from([1, 2, 3]).subscribe(console.log);
    from(fetch('/api')).subscribe(console.log);
<

fromEvent()~                                              *rxjs-fromEvent()*
    Create observable from DOM events.
>
    fromEvent(button, 'click').subscribe(() => {...});
<

interval()~                                               *rxjs-interval()*
    Emit sequential numbers at interval.
>
    interval(1000).subscribe(console.log); // 0, 1, 2, ...
<

timer()~                                                  *rxjs-timer()*
    Emit after delay, optionally repeat at interval.
>
    timer(2000).subscribe(() => {...});        // After 2s
    timer(0, 1000).subscribe(console.log);     // Every 1s
<

range()~                                                  *rxjs-range()*
    Emit range of numbers.
>
    range(1, 5).subscribe(console.log);        // 1, 2, 3, 4, 5
<

throwError()~                                             *rxjs-throwError()*
    Emit error immediately.
>
    throwError(() => new Error('fail')).subscribe({
      error: err => console.error(err)
    });
<

EMPTY~                                                    *rxjs-EMPTY*
    Complete immediately without emitting.
>
    EMPTY.subscribe({ complete: () => {...} });
<

NEVER~                                                    *rxjs-NEVER*
    Never emit, never complete.
>
    NEVER.subscribe(/* never called */);
<

==============================================================================
3. Transformation Operators                           *rxjs-transformation*

map()~                                                    *rxjs-map()*
    Transform each value. See |rxjs-pipe|.
>
    of(1, 2, 3).pipe(
      map(x => x * 2)
    ).subscribe(console.log);                  // 2, 4, 6
<

switchMap()~                                              *rxjs-switchMap()*
    Map to inner observable, cancel previous. Use for search, latest request.
>
    search$.pipe(
      switchMap(term => http.get(`/api?q=${term}`))
    ).subscribe(results => {...});
<

mergeMap()~                                               *rxjs-mergeMap()*
    Map to inner observable, merge all. Use for parallel requests.
    Alias: flatMap()
>
    ids$.pipe(
      mergeMap(id => http.get(`/api/${id}`))
    ).subscribe(data => {...});
<

concatMap()~                                              *rxjs-concatMap()*
    Map to inner observable, execute sequentially.
>
    requests$.pipe(
      concatMap(req => http.post('/api', req))
    ).subscribe(res => {...});
<

exhaustMap()~                                             *rxjs-exhaustMap()*
    Map to inner observable, ignore while executing. Use for submit buttons.
>
    clicks$.pipe(
      exhaustMap(() => http.post('/api/submit', data))
    ).subscribe(res => {...});
<

scan()~                                                   *rxjs-scan()*
    Accumulator (like Array.reduce). Emits each intermediate value.
>
    of(1, 2, 3).pipe(
      scan((acc, x) => acc + x, 0)
    ).subscribe(console.log);                  // 1, 3, 6
<

reduce()~                                                 *rxjs-reduce()*
    Accumulator (like Array.reduce). Emits only final value.
>
    of(1, 2, 3).pipe(
      reduce((acc, x) => acc + x, 0)
    ).subscribe(console.log);                  // 6
<

pluck()~                                                  *rxjs-pluck()*
    Extract property from object.
>
    users$.pipe(
      pluck('name')
    ).subscribe(console.log);                  // 'John', 'Jane'
<

tap()~                                                    *rxjs-tap()*
    Side effect, pass through value. Use for logging.
>
    data$.pipe(
      tap(x => console.log('debug:', x)),
      map(x => x * 2)
    ).subscribe();
<

bufferTime()~                                             *rxjs-bufferTime()*
    Buffer values for time period, emit array.
>
    source$.pipe(
      bufferTime(1000)
    ).subscribe(console.log);                  // [val1, val2, ...]
<

bufferCount()~                                            *rxjs-bufferCount()*
    Buffer values until count reached, emit array.
>
    source$.pipe(
      bufferCount(3)
    ).subscribe(console.log);                  // [1, 2, 3], [4, 5, 6]
<

buffer()~                                                 *rxjs-buffer()*
    Buffer values until notifier emits.
>
    values$.pipe(
      buffer(clicks$)
    ).subscribe(buffered => {...});
<

window()~                                                 *rxjs-window()*
    Like |rxjs-buffer()| but emits observable instead of array.
>
    values$.pipe(
      window(clicks$),
      mergeAll()
    ).subscribe(console.log);
<

groupBy()~                                                *rxjs-groupBy()*
    Group values by key, emit observable for each group.
>
    of(
      { id: 1, type: 'A' },
      { id: 2, type: 'B' },
      { id: 3, type: 'A' }
    ).pipe(
      groupBy(item => item.type),
      mergeMap(group$ => group$.pipe(
        toArray(),
        map(items => ({ type: group$.key, items }))
      ))
    ).subscribe(console.log);
    // { type: 'A', items: [...] }
    // { type: 'B', items: [...] }
<

==============================================================================
4. Filtering Operators                                    *rxjs-filtering*

filter()~                                                 *rxjs-filter()*
    Emit only values that pass predicate.
>
    of(1, 2, 3, 4).pipe(
      filter(x => x > 2)
    ).subscribe(console.log);                  // 3, 4
<

take()~                                                   *rxjs-take()*
    Take first n values, then complete.
>
    interval(1000).pipe(
      take(3)
    ).subscribe(console.log);                  // 0, 1, 2
<

takeUntil()~                                              *rxjs-takeUntil()*
    Take until notifier emits. Use for unsubscribe pattern.
    See |rxjs-patterns-unsubscribe|.
>
    source$.pipe(
      takeUntil(destroy$)
    ).subscribe(console.log);
<

takeWhile()~                                              *rxjs-takeWhile()*
    Take while predicate is true.
>
    source$.pipe(
      takeWhile(x => x < 10)
    ).subscribe(console.log);
<

skip()~                                                   *rxjs-skip()*
    Skip first n values.
>
    of(1, 2, 3, 4).pipe(
      skip(2)
    ).subscribe(console.log);                  // 3, 4
<

debounceTime()~                                           *rxjs-debounceTime()*
    Emit after silence period. Use for search input.
    See |rxjs-patterns-search|.
>
    input$.pipe(
      debounceTime(300)
    ).subscribe(value => search(value));
<

throttleTime()~                                           *rxjs-throttleTime()*
    Emit, then ignore for period. Use for scroll/resize.
>
    scroll$.pipe(
      throttleTime(200)
    ).subscribe(() => {...});
<

auditTime()~                                              *rxjs-auditTime()*
    Emit last value in time period. Like throttle but emits end of period.
>
    clicks$.pipe(
      auditTime(1000)
    ).subscribe(() => {...});
<

audit()~                                                  *rxjs-audit()*
    Like |rxjs-auditTime()| but uses duration selector.
>
    clicks$.pipe(
      audit(() => interval(1000))
    ).subscribe(() => {...});
<

distinctUntilChanged()~                                   *rxjs-distinctUntilChanged()*
    Suppress consecutive duplicate values.
>
    of(1, 1, 2, 2, 3).pipe(
      distinctUntilChanged()
    ).subscribe(console.log);                  // 1, 2, 3
<

distinct()~                                               *rxjs-distinct()*
    Suppress all duplicate values (not just consecutive).
>
    of(1, 2, 1, 3, 2).pipe(
      distinct()
    ).subscribe(console.log);                  // 1, 2, 3
<

first()~                                                  *rxjs-first()*
    Emit first value (or first matching predicate), then complete.
>
    of(1, 2, 3).pipe(
      first()
    ).subscribe(console.log);                  // 1

    of(1, 2, 3).pipe(
      first(x => x > 1)
    ).subscribe(console.log);                  // 2
<

last()~                                                   *rxjs-last()*
    Emit last value when source completes.
>
    of(1, 2, 3).pipe(
      last()
    ).subscribe(console.log);                  // 3
<

==============================================================================
5. Combination Operators                              *rxjs-combination*

merge()~                                                  *rxjs-merge()*
    Merge multiple observables, emit all values.
>
    merge(obs1$, obs2$, obs3$).subscribe(console.log);
<

combineLatest()~                                          *rxjs-combineLatest()*
    Combine latest values from all observables. Emit when any emits.
>
    combineLatest([obs1$, obs2$]).subscribe(([a, b]) => {
      console.log(a, b);
    });
<

concat()~                                                 *rxjs-concat()*
    Subscribe to observables sequentially.
>
    concat(obs1$, obs2$, obs3$).subscribe(console.log);
<

forkJoin()~                                               *rxjs-forkJoin()*
    Wait for all observables to complete, emit last values.
    Like Promise.all().
>
    forkJoin([req1$, req2$, req3$]).subscribe(([r1, r2, r3]) => {
      console.log(r1, r2, r3);
    });
<

zip()~                                                    *rxjs-zip()*
    Combine values at same index from all observables.
>
    zip(of(1, 2, 3), of('a', 'b', 'c')).subscribe(console.log);
    // [1, 'a'], [2, 'b'], [3, 'c']
<

withLatestFrom()~                                         *rxjs-withLatestFrom()*
    Combine with latest value from other observable(s).
    Only emit when source emits.
>
    clicks$.pipe(
      withLatestFrom(counter$)
    ).subscribe(([click, count]) => {...});
<

startWith()~                                              *rxjs-startWith()*
    Emit initial value(s) before source values.
>
    source$.pipe(
      startWith(0)
    ).subscribe(console.log);                  // 0, then source values
<

partition()~                                              *rxjs-partition()*
    Split observable into two based on predicate.
>
    const source$ = of(1, 2, 3, 4, 5, 6);
    const [evens$, odds$] = partition(source$, x => x % 2 === 0);

    evens$.subscribe(x => console.log('even:', x));  // 2, 4, 6
    odds$.subscribe(x => console.log('odd:', x));    // 1, 3, 5
<

==============================================================================
6. Subjects                                               *rxjs-subjects*

Subject~                                                  *rxjs-Subject*
    Multicasts to multiple observers. Both observable and observer.
>
    const subject = new Subject();
    subject.subscribe(x => console.log('A:', x));
    subject.subscribe(x => console.log('B:', x));
    subject.next(1);                           // A: 1, B: 1
    subject.next(2);                           // A: 2, B: 2
<

BehaviorSubject~                                          *rxjs-BehaviorSubject*
    Subject with current value. Requires initial value. Emits last value to
    new subscribers.
>
    const subject = new BehaviorSubject(0);
    console.log(subject.value);                // 0
    subject.subscribe(x => console.log(x));    // 0
    subject.next(1);                           // 1
<

ReplaySubject~                                            *rxjs-ReplaySubject*
    Subject that replays n values to new subscribers.
>
    const subject = new ReplaySubject(2);      // Buffer 2 values
    subject.next(1);
    subject.next(2);
    subject.next(3);
    subject.subscribe(console.log);            // 2, 3 (last 2)
<

AsyncSubject~                                             *rxjs-AsyncSubject*
    Subject that emits last value only when complete.
>
    const subject = new AsyncSubject();
    subject.subscribe(console.log);
    subject.next(1);
    subject.next(2);
    subject.complete();                        // 2
<

Subject vs Observable~                                    *rxjs-subject-vs-observable*
    Observable: Unicast (each subscriber has independent execution)
    Subject: Multicast (all subscribers share same execution)
>
    // Observable - each subscriber runs separately
    const obs$ = interval(1000);
    obs$.subscribe(x => console.log('A:', x));
    setTimeout(() => obs$.subscribe(x => console.log('B:', x)), 2000);
    // A: 0, A: 1, A: 2, B: 0, A: 3, B: 1...

    // Subject - shared execution
    const subject = new Subject();
    interval(1000).subscribe(subject);
    subject.subscribe(x => console.log('A:', x));
    setTimeout(() => subject.subscribe(x => console.log('B:', x)), 2000);
    // A: 0, A: 1, A: 2, B: 2, A: 3, B: 3...
<

==============================================================================
7. Error Handling                                         *rxjs-errors*

catchError()~                                             *rxjs-catchError()*
    Catch error and return new observable. Must return observable.
>
    source$.pipe(
      catchError(err => {
        console.error(err);
        return of([]);                         // Fallback value
      })
    ).subscribe(console.log);

    // Rethrow error
    catchError(err => throwError(() => err))
<

retry()~                                                  *rxjs-retry()*
    Retry on error n times.
>
    http.get('/api').pipe(
      retry(3)
    ).subscribe();
<

retryWhen()~                                              *rxjs-retryWhen()*
    Retry with custom logic (delays, conditions).
>
    source$.pipe(
      retryWhen(errors => errors.pipe(
        delay(1000),
        take(3)
      ))
    ).subscribe();
<

finalize()~                                               *rxjs-finalize()*
    Execute callback when observable completes or errors.
    Like try/finally.
>
    source$.pipe(
      finalize(() => console.log('Done'))
    ).subscribe();
<

==============================================================================
8. Utility Operators                                      *rxjs-utility*

delay()~                                                  *rxjs-delay()*
    Delay emission by time.
>
    of(1, 2, 3).pipe(
      delay(1000)
    ).subscribe(console.log);
<

timeout()~                                                *rxjs-timeout()*
    Error if no emission within time.
>
    source$.pipe(
      timeout(5000)
    ).subscribe({
      error: err => console.error('Timeout')
    });
<

defaultIfEmpty()~                                         *rxjs-defaultIfEmpty()*
    Emit default value if source completes empty.
>
    EMPTY.pipe(
      defaultIfEmpty('default')
    ).subscribe(console.log);                  // 'default'
<

toArray()~                                                *rxjs-toArray()*
    Collect all values into array, emit when complete.
>
    of(1, 2, 3).pipe(
      toArray()
    ).subscribe(console.log);                  // [1, 2, 3]
<

==============================================================================
9. Sharing Operators                                      *rxjs-sharing*

share()~                                                  *rxjs-share()*
    Multicast to multiple subscribers. Creates new source when refCount
    drops to 0.
>
    const shared$ = source$.pipe(share());
    shared$.subscribe(x => console.log('A:', x));
    shared$.subscribe(x => console.log('B:', x));
<

shareReplay()~                                            *rxjs-shareReplay()*
    Multicast and replay n values to new subscribers. Caches values.
>
    const cached$ = http.get('/api').pipe(
      shareReplay(1)
    );
    // First subscriber triggers request
    cached$.subscribe(console.log);
    // Second subscriber gets cached value
    cached$.subscribe(console.log);
<

shareReplay Options~                                      *rxjs-shareReplay-options*
>
    shareReplay({
      bufferSize: 1,        // Number of values to cache
      refCount: true,       // Unsubscribe from source when no subscribers
      windowTime: 5000      // Cache expiry time (ms)
    })
<

==============================================================================
10. Patterns                                              *rxjs-patterns*

Search with Debounce~                                     *rxjs-patterns-search*
>
    searchInput$.pipe(
      debounceTime(300),
      distinctUntilChanged(),
      switchMap(term => http.get(`/api/search?q=${term}`))
    ).subscribe(results => {...});
<

Auto-unsubscribe~                                         *rxjs-patterns-unsubscribe*
>
    private destroy$ = new Subject<void>();

    ngOnInit() {
      source$.pipe(
        takeUntil(this.destroy$)
      ).subscribe();
    }

    ngOnDestroy() {
      this.destroy$.next();
      this.destroy$.complete();
    }
<

Loading States~                                           *rxjs-patterns-loading*
>
    isLoading$ = new BehaviorSubject(false);

    this.isLoading$.next(true);
    http.get('/api').pipe(
      finalize(() => this.isLoading$.next(false))
    ).subscribe();
<

Combine Multiple Requests~                                *rxjs-patterns-combine*
>
    // Parallel - wait for all
    forkJoin({
      users: http.get('/users'),
      posts: http.get('/posts'),
      comments: http.get('/comments')
    }).subscribe(({ users, posts, comments }) => {...});

    // Sequential
    http.get('/user').pipe(
      switchMap(user => http.get(`/posts/${user.id}`)),
      switchMap(posts => http.get(`/comments/${posts[0].id}`))
    ).subscribe(comments => {...});
<

Polling~                                                  *rxjs-patterns-polling*
>
    // Poll every 5 seconds
    interval(5000).pipe(
      switchMap(() => http.get('/api/status'))
    ).subscribe(status => {...});

    // Poll with exponential backoff
    timer(0, 1000).pipe(
      switchMap(i => http.get('/api').pipe(
        retry({
          count: 3,
          delay: (error, retryCount) => timer(retryCount * 1000)
        })
      ))
    ).subscribe();
<

Rate Limiting~                                            *rxjs-patterns-rate*
>
    // Throttle - emit first, ignore rest in period
    events$.pipe(
      throttleTime(1000)
    ).subscribe();

    // Debounce - emit after silence
    events$.pipe(
      debounceTime(1000)
    ).subscribe();

    // Audit - emit last in period
    events$.pipe(
      auditTime(1000)
    ).subscribe();
<

Caching~                                                  *rxjs-patterns-cache*
>
    private cache$ = new Map<string, Observable<any>>();

    getData(id: string): Observable<Data> {
      if (!this.cache$.has(id)) {
        this.cache$.set(id,
          http.get(`/api/${id}`).pipe(
            shareReplay(1)
          )
        );
      }
      return this.cache$.get(id)!;
    }
<

Type-ahead Search~                                        *rxjs-patterns-typeahead*
>
    input$.pipe(
      debounceTime(300),
      distinctUntilChanged(),
      filter(term => term.length > 2),
      switchMap(term => http.get(`/api/search?q=${term}`).pipe(
        catchError(() => of([]))
      ))
    ).subscribe(results => {...});
<

==============================================================================
11. Testing                                               *rxjs-testing*

TestScheduler~                                            *rxjs-TestScheduler*
    Synchronous testing with virtual time.
>
    import { TestScheduler } from 'rxjs/testing';

    const testScheduler = new TestScheduler((actual, expected) => {
      expect(actual).toEqual(expected);
    });
<

Marble Diagrams~                                          *rxjs-marble-diagrams*
    Visual representation of observable streams over time.

    Symbols:
    -       Time passes (10 frames)
    |       Completion
    #       Error
    a,b,c   Emitted values
    ()      Synchronous grouping
    ^       Subscription point
    !       Unsubscription point
>
    // Example marble diagram:
    // Input:   --a--b--c--|
    // Output:  --A--B--C--|

    testScheduler.run(({ cold, hot, expectObservable }) => {
      const input$ = cold('--a--b--c--|');
      const output$ = input$.pipe(map(x => x.toUpperCase()));
      expectObservable(output$).toBe('--A--B--C--|');
    });
<

Marble Testing Examples~                                  *rxjs-marble-testing*
>
    // Test map operator
    testScheduler.run(({ cold, expectObservable }) => {
      const source$ = cold('-a-b-c|', { a: 1, b: 2, c: 3 });
      const result$ = source$.pipe(map(x => x * 2));
      expectObservable(result$).toBe('-a-b-c|', { a: 2, b: 4, c: 6 });
    });

    // Test debounceTime
    testScheduler.run(({ cold, expectObservable }) => {
      const source$ = cold('-a-b-c---d---|');
      const result$ = source$.pipe(debounceTime(30));
      expectObservable(result$).toBe('------c---d---|');
    });

    // Test switchMap
    testScheduler.run(({ cold, hot, expectObservable }) => {
      const outer$ = hot('  --a---b---c--|');
      const inner$ = cold('   --x|');
      const result$ = outer$.pipe(switchMap(() => inner$));
      expectObservable(result$).toBe('----x---x---x|');
    });
<

hot() vs cold()~                                          *rxjs-hot-cold*
    cold() - Create observable that starts when subscribed
    hot()  - Create observable that emits regardless of subscriptions
>
    // Cold - starts at subscription
    const cold$ = cold('--a--b--|');

    // Hot - already emitting
    const hot$ = hot('  --a--b--|');
<

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
