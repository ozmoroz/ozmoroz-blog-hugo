---
Title: "Why my setState doesn't work?"
Date: 2018-11-07
Author: Sergey Stadnik
categories: ["technology"]
Tags: [javascript, react]
Slug: why-my-setstate-doesnt-work
Description: setState operation is asynchronous in React. If you new state depends on the values of the old state, you should use a functional form of setState.
---

{{<figure src="/images/confused_man.jpg" alt="Confused man" caption="Photo by&nbsp;" attr="Bruce Mars" attrlink="https://www.pexels.com/@olly">}}

`setState` is one of the most essential operations in React. Yet, it is one of the most confusing. If you are new to React, then you may feel that it does not always do what you want it to do. It is almost as it doesn't work. The problem may go like this:

You set a state with a setState

   ```javascript
   this.setState({count: 1})
   ```
Then you follow it with another setState which references the previous state value

   ```javascript
   this.setState({count: this.state.count + 1})
   ```

Then you check the state value, and it is not what you expect it to be

   ```javascript
   colsole.log(this.state);  // Prints 1
   ```

What? Is `setState` broken?

Keep calm. `setState` is fine. Keep reading, and I will help why that is happening and how to avoid that.

<!--more-->

First of all, let's have a look what [React documentation](https://reactjs.org/docs/state-and-lifecycle.html#state-updates-may-be-asynchronous) says about `setState`:

> React may batch multiple `setState()` calls into a single update for performance.
>
> Because `this.props` and `this.state` may be updated asynchronously, you should not rely on their values for calculating the next state.

State updates in React are not applied immediately. Instead, they are placed in a queue and scheduled. In fact, React **does not apply the new values to the state until the component is [reconciled](https://reactjs.org/docs/reconciliation.html)**. Moreover, [React Fiber architecture](https://github.com/acdlite/react-fiber-architecture) introduced in React 16 may rearrange the component update queue, putting more *important* updates (like animation) ahead of less important. All that means that **you can't rely on your new state values you apply in `setState` to be applied immediately**.

Therefore, if you change the component's state with `setState`, there's a good chance that your changes won't be applied immediately but instead will be scheduled to happen sometime in future.

```javascript
// Before this this.state.count is 0
this.setState({count: 1});
// Read this.state values immediately after updating them
console.log(this.state.count); // May print 0 or 1
```

Rest assured, even in the worst case scenario your changes will be applied once the [reconciliation process](https://reactjs.org/docs/reconciliation.html) is completed. Because React is very efficient, the update does not take long to come through. It takes micro- or milliseconds to see your changes. But still, it is not immediate.  In most cases that tiny delay does not matter.

However, if your setState depends on the previous state values, you may be in trouble.

```javascript
// Before this this.state.count is 0
this.setState({count: 1});
this.setState({count: this.state.count + 1});
console.log(this.state.count);
```

Would you like to make a guess about what is printed in the last line? The problem is, you can never be sure. It may be 2 if the changes from the first `setState` have come through. Or it may be 1 if the first `setState` was scheduled for the later execution.

## How do you deal with that? {#how-to-deal}

Turns out, there's a special syntax for that. One of React's best-kept secrets is that `setState` comes in two flavours [^1].

**The first form** **takes an object as a parameter** and updates the state according to its values. **It does not return a value**.

For example, this will update `this.state.count` to 1 and `this.state.tempo` to 120. If there are any other values in `this.state`, they will be left unchanged.

```javascript
this.setState({count: 1, tempo: 120});
```

**The second form**, known as *functional setState*, is more complex. Instead of an object, it **takes a function as a parameter**.

```javascript
function setStateFunction(state, props) {
  const newState = {...state, count: state.count + 1};
  return newState;
}
this.setState(setStateFunction);
```

The function receives two parameters: the current state and props. Contrary to the synchronous form, **it has to return the state object** which then becomes your new state.

Note the `...state` spread operator in this line

``` javascript
const newState = {...state, count: state.count + 1};
```

Whatever the state function returns becomes your new state. Therefore it is very important that you return **the complete state**. It needs to contain not only the modified values but the other state values as well. [Spread operator](https://lucybain.com/blog/2018/js-es6-spread-operator/) copies all values from your state into the new object so that you don't lose any of your state values.

**If your `setState` depends on the current value of the state or props, you need to use the functional (the second) form.**

In other words, if you find yourself writing `this.state` or `this.props` inside your `setState` update, you need to use the functional form and obtain the current state and props values from `state` and `props` function parameters.

```javascript
// Before this this.state.count is 0
this.setState({count: 1});

// Use the functional setState form
function incrementCount(state, props) {
  return {...state, count: state.count + 1};
}
this.setState(incrementCount);
console.log(this.state.count); // Always prints 2
```

React guarantees that the functional `setState` calls will be executed in the order they were called.

<blockquote class="twitter-tweet tw-align-center" data-conversation="none" data-lang="en"><p lang="en" dir="ltr">It is safe to call setState with a function multiple times. Updates will be queued and later executed in the order they were called. <a href="https://t.co/xNr6EDVdJv">pic.twitter.com/xNr6EDVdJv</a></p>&mdash; Dan Abramov (@dan_abramov) <a href="https://twitter.com/dan_abramov/status/824309659775467527?ref_src=twsrc%5Etfw">January 25, 2017</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

Therefore, the values of `state` and `props` arguments of the `setState`'s update functions will always be *"correct"*.

We can rewrite the previous example using an [inline arrow function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions) to make it a bit simpler:

```javascript
// Before this this.state.count is 0
this.setState({count: 1});

// Use the functional setState form
this.setState(state => ({...state, count: state.count + 1}));
console.log(this.state.count); // Always prints 2
```

## What about useState hook? {#usestate-hook}

[Hooks](https://reactjs.org/docs/hooks-intro.html) were introduced to React in version 16.8.0, and they became an immediate hit among developers. I won't be exaggerating if I claim that the most popular hook is `useState`. With its help, we can finally add state to functional React components.

When using a `useState` hook, we start with getting an *initial value* of the state and a *setter function* as a resut of `useState` call:

```javascript
const [count, setCount] = useState(0);
```

Where **0** passed to `useState` is the initial value of `count` state.

When we want to update the state value, we call `setCount` setter we got from `useState` call with an updated value:

```javascript
setCount(1); // Count value is now 1
```

But what if our new value *depends* on the old one? Will this work?

```javascript
setCount(count + 1);
```

Turns out the same rule I outlined for `setState` applies to `useState` hook. To reiterate:

 **You can't rely on your new state values you apply in `useState` to be applied immediately. If your `setState` depends on the current value of the state or props, you need to use the functional (the second) form.**

Yes, there is a functional form of the `useState`  setter. It works pretty much in the same way as for `setState`:

The setter function (in our case `setCount`) can take a *function* as a parameter. That function should take a *current* value of the state and return a *new* one.

```javascript
setCount(count => count + 1);
```

## Let's recap what we learned: {#recap}

1. `setState` calls are not guaranteed to be applied immediately.
2. There are two forms of `setState`: one takes an object, and the other takes a function.
3. If your `setState` relies on `state` or `props` values, you need to use the *functional* form.
4. Never refer to `this.state` or `this.props` inside your `setState`. Instead use `state` and `props` arguments of the `setState`\`s update function.
5. `useState` hook is no different. Use a *functional* form of its setter if your new state value depends on its previous value.

Happy coding!

[^1]: Well, not really a secret. In fact, React team [tells everyone who wants to listen](https://reactjs.org/docs/state-and-lifecycle.html#state-updates-may-be-asynchronous) about the `setState`'s duality. Still surprisingly few people know about that.
