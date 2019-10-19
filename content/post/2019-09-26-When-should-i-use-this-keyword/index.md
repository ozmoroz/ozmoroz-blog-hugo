---
Title: 'When should I use "this" keyword?'
Date: 2019-09-26
Author: Sergey Stadnik
categories: ["technology"]
Tags: [javascript, react]
Slug: when-should-i-use-this-keyword
---

{{<responsive-figure src="this-or-not.jpg" width="640px" alt="To this or not to this?">}}

When you browse through Javascript code, you often see function calls prepended with `this.` keyword, like `this.functionName()`. However, sometimes `this` is missing and it's just `functionName()`. What is the difference and when you should use one over the other?

That depends on whether you React component is functional or class-based.

<!--more-->

If your component is a *class-based component* **and** `functionName` is a [method](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Method_definitions) of that class, then you **must** address to it as `this.functionName`. For example:

```javascript
class App extends React.Component {
  // myFunc is a method of App class
  myfunc() {
    ...
  }

  render() {
    myfunc(); // Error! "myfunc is not defined"
    this.myfunc(); // #ThumbsUp
    ...
  }
}
```

On the other hand, if your component is *functional*, then functions you declare inside it do not require `this` keyword to be addressed to, no matter if they are defined with `function` keyword or as arrow functions.

```javascript
const App = () => {
  function myfunc1(){
    ...
  }

  const myfunc2 = () => {
    ...
  }

  myfunc1(); // This works
  myfunc2(); // This works too
  this.myfunc1(); // Error: Cannot read property 'myfunc1' of undefined

  ...
};
```
