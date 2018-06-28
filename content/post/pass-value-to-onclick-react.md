---
Title: "How to pass a value to onClick handler in React js"
Date: 2018-06-28
Author: Sergey Stadnik
categories: ["technology"]
Tags: [javascript, react]
Slug: pass-value-to-onclick-react
---

If you ever tried to pass a parameter to `onClick` event handler, you know that it is not straightforward.

If you didn't, here is why may want to. Imagine a scenario where you have a group of three buttons. When you click on one of them, you want to know which one was clicked and perform an appropriate action. You have a choice of creating three onClick event handlers, one for each button, or one hander for all the buttons and pass a parameter identifying the clicked button into it. Which option do you choose? Clearly writing one handler should be less work, right?

Unfortunately, passing a parameter into an event handler in React is not straightforward. If it were, there wouldn't be [multi-page discussions](https://stackoverflow.com/questions/29810914/react-js-onclick-cant-pass-value-to-method) about just that. By the way, the accepted answer on that Stackoverflow thread lists an "Easy way" along with "Better way" and an "Old easy way". The "Easy was" is indeed easier, but has a performance impact. And a "Better way" is in fact not that easy. Is that confusing, or is that just me?

However, don't despair! I will show you how you can pass not even one, but multiple parameters into an `onClick` event handler. In fact, you can apply the same technique to _any_ React event handler. That way is both easy and has no performance impact.

The first thing you need to know is that `onClick` handler already receives a parameter. It is an **event** object. That object has many fields and methods, but the most important for us in this context is **currentTarget** field. That field is an object representing the DOM element where the event is _originated_. I.e. for `click` event it is the DOM element which has been clicked. `currentTarget`, too, has many fields and, to complicate the matter, that set of fields may be different for different DOM elements. For example, buttons and input elements have `value` field. Its value is set to the `value` attribute of the corresponding DOM node. Therefore, you can use it pass a value to the handler function: you just need to set the value of the DOM node and query it in the event handler:

```js
[1, 2, 3].map(buttonId => (
  // Pass a parameter in 'value' attribute
  <button value={buttonId} onClick={this.handleButtonClicked}>
    button {buttonId}
  </button>
...
handleButtonClicked = ev => {
	this.setState({
	  // Retrieve a passed parameter 'value' attribute
	  message: `Button ${ev.currentTarget.value} clicked`
	});
};
```

But what if you want to attach an `onClick` handler to something which is not a button? After all, React allows you to handle clicks on just about anything. How about something simple and generic, like a **div**? Div elements don't have `value` field in their `currentTarget` representation. So, what do we do? Fortunately, there are other fields in `currentTarget` object we can use. For instance, every DOM element can have an **id**. We can use it instead of `value` to pass a parameter into a handler function:

```js
[1, 2, 3].map(divId => (
  // Pass a parameter in 'id' attribute
  <div id={divId} onClick={this.handleButtonClicked}>
    Div {divId}
  </div>
));
...
handleButtonClicked = ev => {
  this.setState({
    // Retrieve a passed parameter from 'id' attribute
    message: `Div ${ev.currentTarget.id} clicked`
  });
};
```

Although it's tempting, using `id` attributes that way is best to be avoided. That is because IDs must be unique in the context of the HTML page. No two element rendered on the same page can have the same id. If you are developing the whole application, then is usually not a problem. However, if you a making a component, you can't guarantee that the id you use for your element inside your component never repeats anywhere on the entire page. Luckily for us, there is a better way than to use id attributes for parameters.

HTML5 brought us [**data-** attributes](https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/data-*). These attributes can be attached to any DOM element, they don't interfere with page rendering in any way, but they do have one feature we can exploit. All the ``data-``attributes defined on a DOM element form that element's **dataset**. That dataset can be accessed via `dataset` field of the `currentTarget` object. `dataset` is a key-value structure, whey **key** is the part of the attribute name immediately followed by `data-` word, and the **value** is that attribute's value. Therefore, we can rewrite our example using a `data-` attribute instead of `id`:

```js
[1, 2, 3].map(divId => (
  // Pass a parameter in 'data-div_id' attribute
  <div data-div_id={divId} onClick={this.handleButtonClicked}>
    Div {divId}
  </div>
));
...
handleButtonClicked = ev => {
  this.setState({
    // Retrieve a passed parameter from 'div_id' dataset
    message: `Div ${ev.currentTarget.dataset.div_id} clicked`
  });
};
```

The name of the dataset attribute (the part of the attribute name which follows `data-`) can be anything. However, dataset names are not case-sensitive. Therefore `data-divId` and `data-divid` represent the same attribute.

But wait! If necessary, we can use that technique to pass **multiple** parameters into an event handler! All we need to do is define multiple ``data-`` attributes and then access them via `currentTarget.dataset` field:

```js
[1, 2, 3].map(divId => (
  // Pass a parameter in 'div_id' and 'div_name' data attribute
  <div
    data-div_id={divId}
    data-div_name={`Div ${divId}`}
    onClick={this.handleButtonClicked}
  >
    Div {divId}
  </div>
));
...
handleButtonClicked = ev => {
  this.setState({
    // Retrieve a passed parameter from 'div_id' and 'div_name' datasets
    message: `${ev.currentTarget.dataset.div_name}: ${
      ev.currentTarget.dataset.div_id
    } clicked`
  });
};
```

Open [CodeSandbox](https://codesandbox.io/s/n5vyw31nzl) to play with live working example. Also, You can access the 100% working source code for this article from [my Git repository](https://github.com/ozmoroz/react-pass-parameter-to-onClick).

That's it. Now you know how to pass multiple parameters into a React event handler function in a way which is both simple and has no performance impact. Try it next time you need it, and you won't have to search internet forums for a solution for days.

If you liked this tutorial, and you want to read more, enter your email into the box below to subscribe, and I will send you a message as soon as I publish a new article.

Thank you for reading.
