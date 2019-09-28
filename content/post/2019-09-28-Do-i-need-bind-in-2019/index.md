---
Title: 'Do I still need to bind React functions in 2019?'
Date: 2019-09-28
Author: Sergey Stadnik
categories: ["technology"]
Tags: [javascript, react]
Slug: do-i-need-bind-in-2019
---

{{<responsive-figure src="to_bind_or_not_to_bind.jpg" width="640px" alt="To bind or not to bind - that is the question">}}

One of Reddit members asked me a question in follow-up to my answer to a [question](https://www.reddit.com/r/reactjs/comments/cy93lg/beginners_thread_easy_questions_september_2019/f1aph1h?utm_source=share&utm_medium=web2x) about `this` keyword:

*Why do I need to bind a function if it's in a class?*

### Short answer

You don't need to use `bind`. If you use the following syntax to declare *class methods*, then `this` in them **will be automatically bound to the current *class instance***. It's magic.

![It's magic](magic.webp)

    class MyComponent extends React.Component {
      myMethod1 = () => {
        ...
      }
      myMethod2 = () => {
        ...
      }
    }

Note the absence of `const` keyword.

That syntax was introduced in ES6 [class field declarations proposal](https://github.com/tc39/proposal-class-fields) and already widely supported. That is what you should do when you write React class-based components in 2019. `bind` is obsolete.

<!--more-->

### Long answer

When JavaScript was created, it wasn't an object-oriented language. It was a quirky object-oriented-wannabe, which in many cases behaved like one but not quite. One of those quirks was its `this` keyword.

Object-oriented languages like Java and C++ have `this` keyword too. In those languages, it always points to the current *instance* of an *object type* (aka *class*).

JavaScript wasn't like that. In it, `this` could be pointing to the current class instance (as you would expect), but also to the browser window object, to the current function, and it could be just `null`. There were rules behind that behaviour, but they were so complex nobody could understand them. If you curious, check out any of these articles:

- [Binding functions in React](https://codeburst.io/binding-functions-in-react-b168d2d006cb)
- [React — to Bind or Not to Bind](https://medium.com/shoutem/react-to-bind-or-not-to-bind-7bf58327e22a)
- [This is why we need to bind event handlers in Class Components in React](https://www.freecodecamp.org/news/this-is-why-we-need-to-bind-event-handlers-in-class-components-in-react-f7ea1a6f93eb/)

Why was that important? Let's look at an example.

```js
class MyComponent extends React.Component {
  state = {
    text: "abc"
  };
  setText {
    this.setState({ text: "123" }); // What is "this" here???
  }
  render() {
    return (
      <div>
        <div>{this.state.text}</div>
        <button onClick={this.setText}>Click me</button>
      </div>
    );
  }
}
```

The code above doesn't work.

This is what was supposed to happen here:

1. We click on "Click me" button, and `setText` method is executed because it is bound to the button's `onClick` handler.
2. `setText` method sets the component's state `text` value to "123" by calling React's `setState` method.

However, what we really get here is an obscure "A cross-origin error was thrown" error when we click the button.

Why?

Because in order for `this.setState` to work, `this` inside `setText` method must be pointing to the current *instance* of `MyComponent` class. But it doesn't. It is pointing to something else entirely. Yes, it is possible to decipher the complex rules governing the value of `this` in that case and tell why. But I wouldn't bother. It's just too hard.

However, it is much easier to avoid that problem entirely.

There are 3 ways to solve it:

1. Explicitly *bind* the value of `this` inside `setText` to the current class instance. That can be done in a *constructor*:

```js
    class MyComponent extends React.Component {
      ...
      constructor(props) {
        super(props);
        this.setText = this.setText.bind(this);
      }
      ...
    }
```

2. Use an *arrow function* in an event handler. This magically makes `this` in the function it calls bound to the current class instance too:

```js
<button onClick={() => this.setText()}>Click me</button>
```

3. You already know it. Use *class field syntax* for method declaration:

```js
    class MyComponent extends React.Component {
      ...
      setText = () => {
        this.setState({ text: "123" });
        }
      ...
    }
```

As of 2019, this method is considered superior. Facebook [has been using it internally](https://github.com/facebook/react/issues/9851#issuecomment-306221157) since 2017: 

![Dan Abramov: we use class properties internally](dan_abramov_on_class_properties.png)

Or, even better, drop class-based components altogether and switch to functional components with [hooks](https://reactjs.org/docs/hooks-intro.html).

Happy coding!

## Get more React tips

- [When should I use “this” keyword?]({{< relref "2019-09-26-When-should-i-use-this-keyword/index.md" >}})
- [Why do I need props?]({{< relref "2019-09-21-Why-do-I-need-props/index.md" >}})
- [How to pass a value to onClick event handler in React.js]({{< relref "pass-value-to-onclick-react.md" >}})

If you would like to receive helpful tips on React and Javascript like
these, enter your email into the box below to subscribe, and you’ll get
them in your inbox fresh out of the oven as soon as I publish them.