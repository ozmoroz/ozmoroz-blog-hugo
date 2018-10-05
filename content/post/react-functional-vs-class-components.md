---
Title: "What is the difference between functional and class-based React components?"
Date: 2018-08-17
Author: Sergey Stadnik
categories: ["technology"]
Tags: [javascript, react]
Slug: react-functional-vs-class-components
---

React offers two ways to define components: they can be functional or class-based. If you are new to React, you may be wondering what the difference is between them. [The React documentation](https://reactjs.org/docs/components-and-props.html#functional-and-class-components) doesn't clearly explain when and why you would use one or the other, and what the pros and cons of each type are.

In this article I will help you understand the difference between functional and class-based components. You will know why you may prefer one over another.

<!--more-->

### What are functional and class-based components?

A functional component is a Javascript function that takes a single parameter or props object and returns a React component. The returned component then is rendered by React.

```javascript
const MyHello = props => {
  return <h2>Hello, {props.name}</h2>;
};
```

It is even more straightforward if we take advantage of [ES6 Arrow functions expressions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions)

```javascript
const MyHello = props => <h2>Hello, {props.name}</h2>;
```
The value returned by the function only depends on values passed in props parameter. That is, given the same props, a functional component always renders the same result.

A class-based component is a more complex structure. It is an instance of a class derived from `React.Component` class. The class must implement a `render()` member function which returns a React component to be rendered, similar to a return value of a functional component. In a class-based component, props are accessible via `this.props`.

```javascript
class MyHello extends React.Component {
  render() {
    return <h2>Hello, {this.props.name}</h2>;
  }
}
```

### Class-based components can have state

Apart from props, the component rendered from a class-based component can depend on its [state](https://reactjs.org/docs/state-and-lifecycle.html). Here is an example of a class-based component which maintains a counter in its state. The counter is incremented every time a user clicks on a button which is rendered inside a component. 

```javascript
class MyHello extends React.Component {
  // Define an initial state
  state = { counter: 0 };
  // Call setState to update the component's state
  incrementCounter = () => {
    this.setState(state => ({
      ...state,
      counter: state.counter + 1
    }));
  };
  render() {
    return (
      <React.Fragment>
        <h2>
          Hello, {this.props.name} {this.state.counter} times
        </h2>
        <button onClick={this.incrementCounter}>Say it again</button>
      </React.Fragment>
    );
  }
}
```
### Class-based components can have lifecycle methods

In addition to a state, class-based components can also have lifecycle methods which fire at specific points of a [component lifecycle](https://reactjs.org/docs/react-component.html#the-component-lifecycle). Those lifecycle methods can be used to fetch the data from remote servers, create objects, such as timers when the component is mounted (rendered to the DOM for the first time), and free them when a component is unmounted from the DOM, determine if the component should be re-rendered if props are changed, and so on.

```javascript
// Class-based component with lifecycle methods
class MyHello extends React.Component {
  componentDidMount() {
    // The component is mounted - fetch the data from the server
    ...
  }
  componentDidUpdate(prevProps, prevState, snapshot) {
    // The component is updated - update the values
    ...
  }
  componentWillUnmount() {
    // The component is about to be unmounted - clean up
    ...
  }
  render() {
   ...
  }
}
```
### Class-based components can have refs

Class-based components can also have [**refs**](https://reactjs.org/docs/refs-and-the-dom.html) to the underlying DOM nodes. Refs may be necessary, for instance, to manage focus in your application [for accessibility reasons](https://developers.google.com/web/fundamentals/accessibility/focus/).

Here is an example of a React component with active focus management via a *ref*:

```javascript
// Class-based component with a ref to a DOM element
class MyHello extends React.Component {
  constructor(props) {
    super(props);
    // Create a Ref for the button element
    this.inputRef = React.createRef();
  }

  // Focus on the textInput DOM element
  focusOnInput = () => this.inputRef.current.focus();

  render() {
    return (
      <div>
        <label htmlFor="textInput">Enter text</label>
        <input id="textInput" type="text" ref={this.inputRef} />
        {/* Move the focus to the text input
            when the button is clicked */}
        <button onClick={this.focusOnInput}>
          Focus on input control
        </button>
      </div>
    );
  }
}
```
Functional components cannot contain refs because they don't have instances.

### shouldComponentUpdate and PureComponent

[`shouldComponentUpdate`](https://reactjs.org/docs/react-component.html#shouldcomponentupdate) and [`PureComponent`]({{< relref "what-is-purecomponent.md" >}}) are two advanced performance optimisation techniques only  available to class-based components. React component re-renders if its `props` or `state` change. If that happens very often, that may impact your application's performance.

`shouldComponentUpdate` is a special lifecycle method. It allows you to skip the re-rendering even if the `props` or `state` changed.

```javascript
class MyHello extends React.Component {
  shouldComponentUpdate(nextProps, nextState) {
    ...
    // Return true if the component should re-render
    if (...) return true;
    // Return false if the component should NOT re-render
    else return false;
  }

  render() {
    ...
    return <div>...</div>;
  }
}
```

You may choose to derive your class-based component from `React.PureComponent` rather than `React.Component`. In that case React will execute some checks to detect if the `state` or `props` changes. If your `state` or `props` are very complex objects, that may save you some precious execution time.

```javascript
// Class-based component derived from React.PureComponent
class MyHello extends React.PureComponent {
  // All you need to do is to extend React.PureComponent
  // instead of React.Component.

  render() {
    ...
    return <div>...</div>;
  }
}
```

These two techniques have a potential to improve your application performance. However, they should be applied sparingly because they have a potential to break your application if used in a wrong way.

### To sum it up, the difference between functional and class-based components is

- Functional component can't have state or lifecycle methods
- A class-based component can maintain its own state.
- Class-based components can have lifecycle methods which can be used to perform various actions at specific points of the component lifecycle.
- Class-based components can have _refs_ to underlying DOM nodes.
- Class-based components can use `shouldComponentUpdate` and `PureComponent` performance optimisation techniques.

#### Therefore, if your component needs any of these:

- a state (it may render differently for the same set of props)
- lifecycle methods (it needs to perform actions when the component is mounted, unmounted, about to be updated, etc.)
- refs (it needs to refer to underlying DOM nodes)
- Or if you plan to use  `shouldComponentUpdate` or `PureComponent` performance optimisation techniques.

then **you have to use class-based components just because function components don't have those features**.

However, If your components do not require state, lifecycle methods, refs or advanced performance optimisation techniques then neither functional nor class-based components provide clear advantage one over another. In that case, it ultimately comes down to your preference or decision of your team.

Some of the reasons why you may choose functional components over class-based include:

- You are on functional programming path and want to make as much of your code as possible functional,
- You want your code look as *clean* as possible with a minimal boilerplate,
- Your project enforces  `react/prefer-stateless-function` ESLint rule which requires you to write functional components whenever possible.

On the other hand, you may choose class-based components over functional if:

- You find that you often end up converting functional components to classes when you suddenly need state or lifecycle methods during app changes.

- You realise that you lose code clarity if you end up with classes here and functions there. That may be important to big teams where it is crucial to work very clean.

![React functional vs class-based componenents infographic](https://ozmoroz-pub.s3.amazonaws.com/images/React%20functional%20vs%20class-based%20components%20-%20small.jpg)

<div class="text-center">
  <a download target="_blank" noopener noreferrer href="https://ozmoroz-pub.s3.amazonaws.com/images/React%20functional%20vs%20class-based%20components.png">Download a high-res infographic</a>
</div>
<br/>

Finally, if you are still struggling to make a decision, this [tweet from Dan Abramov](https://twitter.com/dan_abramov/status/993103559297204224)

<blockquote class="twitter-tweet tw-align-center" data-lang="en"><p lang="en" dir="ltr">I agree! Current guidance is: use functional components for simple things, use classes for state/lifecycle (because functional components can’t express it yet). We plan to tackle unification in a year or so, then functional components will be able to do everything.</p>&mdash; Dan Abramov (@dan_abramov) <a href="https://twitter.com/dan_abramov/status/993103559297204224?ref_src=twsrc%5Etfw">May 6, 2018</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

Thank you for reading.

Open this [CodeSandbox](https://codesandbox.io/s/github/ozmoroz/react-functional-vs-class-based-components/tree/master/) for an interactive example of the code above. Also, You can access the 100% working source code for this article from [my Git repository](https://github.com/ozmoroz/react-functional-vs-class-based-components).

if you would like to receive helpful tips on React and Javascript like this one, enter your email into the box below to subscribe, and you'll get them in your inbox fresh out of the oven as soon as I publish them.

## Other helpful React tips:

- [What is React.PureComponent and when to use it]({{< relref "what-is-purecomponent.md" >}}) 
- [How to pass a value to `onClick` event handler in React.js](https://ozmoroz.com/2018/07/pass-value-to-onclick-react/)
- [Mocking ES6 module dependencies with import * from](https://ozmoroz.com/2017/09/mocking-es6-dependencies-1/)