---
Title: "What is React.PureComponent and when to use it"
Date: 2018-09-24
Author: Sergey Stadnik
categories: ["technology"]
Tags: [javascript, react]
Slug: what-is-purecomponent
---

React 15.3 introduced [`PureComponent`](https://reactjs.org/docs/react-api.html#reactcomponent) - a new way of implementing class-based components. It is now available to us alongside function-based components and components derived from `React.Component`.

This new technique caused much confusion in React rounds. Is `PureComponent` a new improved version of `React.Compoment`? Does it automatically make everything better? Should you just slap PureComponent everywhere and enjoy your faster React app?

<!--more-->

### What is PureComponent

`PureComponent` is a base class for React class-based components. It implements [shouldComponentUpdate](https://reactjs.org/docs/react-component.html#shouldcomponentupdate) lifecycle method like this:

```javascript
return (
  !shallowEqual(oldProps, newProps) ||
  !shallowEqual(oldState, newState)
);
```

It checks whether the *state* or *props* changed using **shallow equality comparison**.

**If the props and the state hasn't changed, the component is not re-rendered.**

> `shallowEqual` performs a shallow equality check by iterating on the keys of the objects being compared and returning true when the values of a key in each object are not strictly equal.
> Source: [React documentation](https://reactjs.org/docs/shallow-compare.html)

`PureComponent` is an advanced optimisation technique. *Optimisation* because it has a potential to make your application faster. *Advanced* because it can also break your app if you are not careful.

To use `PureComponent` simply derive your class-based component from `React.PureComponent` instead of `React.Component`.

```javascript
class MyPureComponent extends React.PureComponent {
  ...
}
```

### Why to use PureComponent

Both [functional-based and class-based components](https://ozmoroz.com/2018/08/react-functional-vs-class-components/) have the same downside: they **always re-render when their parent component re-renders even if the props don't change**.

Also, class-based components **always re-render when its state is updated** (`this.setState` is called) **even if the new state is equal to the old state**.

{{% card %}}
  Enter your email into the [subscription box](#mc_embed_signup) at the bottom of the page, and I will send you a link to my interactive mini case study on functional component vs React.Component vs PureComponent re-rendering.
{{% /card %}}

**Moreover, when a parent component re-renders, all of its children are also re-rendered, and their children too, and so on.**

That behaviour may mean a lot of wasted re-renderings. Indeed, if our component only depends on its props and state, then it shouldn't re-render if neither of them changed, no matter what happened to its parent component.

That is precisely what PureComponent does - it stops the vicious re-rendering cycle. PureComponent does not re-render unless its props and state change.

### Caveats

#### 1. State and Props immutability

Since the props and state equality is checked via a *shallow equality*, PureComponent **only works if its props and state are immutable**. That is, if you pass an object prop into a component derived from `React.Purecomponent`,  you should always create a new prop object on every change instead of modifying its values. The same with a state - always create a new state within `this.setState` call instead of changing the existing one. If you don't, then shallow equality won't be able to detect the change, and your component won't re-render when it needs to.

*[This article by Niels Gerritsen explains immutable objects very well](https://wecodetheweb.com/2016/02/12/immutable-javascript-using-es6-and-beyond/)*

#### 2. shouldComponentUpdate

If you plan to implement your own `shouldComponentUpdate` in your component, then you can't use `React.PureComponent` as a base. If you do, you will get error "*shouldComponentUpdate should not be used when extending React.PureComponent. Please extend React.Component if shouldComponentUpdate is used.*"

### When to use PureComponent

To sum it up, `PureComponent` is useful when:

- You want to avoid re-rendering cycles of your component when its props and state are not changed, and
- The state and props of your component are immutable, and
- You don't plan to implement your own `shouldComponentUpdate` lifecycle method.

On the other hand, you should not use `PureComponent` as a base for you component if:

- Your props or state are not immutable, or
- You plan to implement your own `shouldComponentUpdate` lifecycle method.

Thank you for reading.

## Other helpful React tips:

- [What is the difference between functional and class-based React components?]({{< relref "react-functional-vs-class-components.md" >}})
- [How to pass a value to `onClick` event handler in React.js](https://ozmoroz.com/2018/07/pass-value-to-onclick-react/)


if you would like to receive helpful tips on React and Javascript like this one, enter your email into the box below to subscribe, and you’ll get them in your inbox fresh out of the oven as soon as I publish them.
