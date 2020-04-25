---
Title: "How to pass a value to onClick event handler in React.js"
Date: 2018-07-02
Author: Sergey Stadnik
categories: ["technology"]
Tags: [javascript, react]
Slug: pass-value-to-onclick-react
Description: How to pass values to onClick event handler in React via data attributes.
---

### The problem

If you ever tried to pass a parameter to `onClick` event handler, you know that it is not straightforward.

If you didn't, here is why may want to. Imagine a scenario where you have a group of three buttons. When you click on one of them, you want to know which one was clicked and perform an appropriate action. You have a choice of creating three onClick event handlers, one for each button, or one hander for all the buttons and pass a parameter identifying the clicked button into it. Which option do you choose? Clearly writing one handler should be less work, right?

Unfortunately, passing a parameter into an event handler in React is not straightforward. If it were, there wouldn't be [multi-page discussions](https://stackoverflow.com/questions/29810914/react-js-onclick-cant-pass-value-to-method) about just that. By the way, the accepted answer on that Stackoverflow thread lists an "Easy way" along with "Better way" and an "Old easy way". The "Easy way" is indeed easier, but has a performance impact. And a "Better way" is in fact not that easy. Is that confusing, or is that just me?

However, don't despair! I will show you how you can pass not even one, but multiple parameters into an `onClick` event handler. In fact, you can apply the same technique to _any_ React event handler. That approach is both easy to implement and has no performance impact.

<!--more-->

### The solution for buttons

The first thing you need to know is that `onClick` handler already receives a parameter. It is an **event** object. That object has many fields and methods, but the most important for us in this context is **currentTarget** field. That field is an object representing the DOM element **the event handler is attached to**. I.e. for `click` event it is the DOM element which has been clicked. `currentTarget`, too, has many fields and, to complicate the matter, that set of fields may be different for different DOM elements. For example, buttons and input elements have `value` field. Its value is set to the `value` attribute of the corresponding DOM node. Therefore, you can use it pass a value to the handler function: you just need to set the value of the DOM node and query it in the event handler:

```js
// Render a block of three buttons
[1, 2, 3].map(buttonId => (
  // Pass a parameter in 'value' attribute
  <button
    key={buttonId}
    value={buttonId}
    onClick={this.handleButtonClicked}
  >
    button {buttonId}
  </button>
));
...
handleButtonClicked = ev => {
  this.setState({
    // Retrieve a passed parameter 'value' attribute
    message: `Button ${ev.currentTarget.value} clicked`
  });
};
```

### The solution for all other element types

But what if you want to attach an `onClick` handler to something which is not a button? After all, React allows you to handle clicks on just about anything. How about something simple and generic, like a **div**? Div elements don't have `value` field in their `currentTarget` representation. So, what do we do? Fortunately, there are other fields in `currentTarget` object we can use.

HTML5 brought us [**data-** attributes](https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/data-*). These attributes can be attached to any DOM element. They don't interfere with page rendering in any way. Yet they do have one feature we can leverage. All the `data-` attributes defined on a DOM element constitute that element's **dataset**. That dataset can be accessed via `dataset` field of the `currentTarget` object. `dataset` is a key-value structure, whey **key** is the part of the attribute name immediately followed by `data-` word, and the **value** is that attribute's value. Therefore, we can rewrite our example using a `data-` attribute:

```js
// Render a block of three DIVs
[1, 2, 3].map(divId => (
  // Pass parameters in'div_id' and div_name data attributes
  <div
    key={divId}
    data-div_id={divId}
    onClick={this.handleDivClicked}
  >
    Div {divId}
  </div>
));
...
handleDivClicked = ev => {
  this.setState({
    // Retrieve the passed parameter from 'div_id' dataset
    message: `Div ${ev.currentTarget.dataset.div_id} clicked`
  });
};
```

The name of the dataset attribute (the part of the attribute name which follows `data-`) can be any valid Javascript identifier. However, dataset names are not case-sensitive. Therefore `data-divId` and `data-divid` represent the same attribute.

But wait! If necessary, we can use that technique to pass **multiple** parameters into an event handler! All we need to do is define multiple ``data-`` attributes and then access them via `currentTarget.dataset` field:

```js
// Render a block of three DIVs
[1, 2, 3].map(divId => (
  // Pass parameters in'div_id' and div_name data attributes
  <div
    key={divId}
    data-div_id={divId}
    data-div_name={`Div ${divId}`}
    onClick={this.handleButtonClicked}
  >
    Div {divId}
  </div>
));
...
handleDivClicked = ev => {
  this.setState({
    // Retrieve the passed parameters from 'div_id'
    // and 'div_name' datasets
    message: `Clicked div Id ${ev.currentTarget.dataset.div_id}, name ${
      ev.currentTarget.dataset.div_name
    }`
  });
};
```

Open this [CodeSandbox](https://codesandbox.io/s/github/ozmoroz/react-pass-parameter-to-onClick/tree/master/) for an interactive example of the code above. Also, You can access the 100% working source code for this article from [my Git repository](https://github.com/ozmoroz/react-pass-parameter-to-onClick).

That's it. Now you know how to pass multiple parameters into a React event handler function in a way which is both simple and has no performance impact. Try it next time you need it, and you won't have to search internet forums for a solution for days.

If you liked this tutorial, and you want to read more, enter your email into the box below to subscribe, and I will send you a message as soon as I publish a new article.

Thank you for reading.

## Other helpful React tips:

- [Mocking ES6 module dependencies with import * from](/2017/09/mocking-es6-dependencies-1/)
- [What is the difference between functional and class-based React components?](/2018/08/react-functional-vs-class-components/)
