---
Title: 'Introduction to asynchronous operations in Javascript'
Date: 2019-10-29
Author: Sergey Stadnik
categories: ["technology"]
Tags: [javascript, react]
Slug: introduction-to-asynchronous-javascript
---

{{<responsive-figure src="synchronous-asynchronous.jpg" width="640px" alt="Synchronous / Asynchronous">}}

If you are learning JavaScript, you no doubt came across things like [callbacks](https://codeburst.io/javascript-what-the-heck-is-a-callback-aba4da2deced), [promises](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise), [generators](https://medium.com/dailyjs/a-simple-guide-to-understanding-javascript-es6-generators-d1c350551950), and [`async`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/async_function) / [`await`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/await). Those are *asynchronous programming paradigms.* In Javascript they are everywhere*.* If you want to understand JavaScript, you need to understand them. However, there is a problem.

Although there is no shortage of tutorials explaining *callbacks*, *promises* and *async / await*, most of them leave you scratching your head because they don't answer one question:

**What the heck *asynchronous* mean?**

Most of the tutorials and articles I read just assume you already know that. What if you don't? That's why you are here.

Keep reading, and I will explain:

- What *synchronous* and *asynchronous* mean
- Why we need asynchronous operations
- How asynchronous operations work
- What kind of operations can be asynchronous in JavaScript
- How you can make your own asynchronous operations

<!--more-->

## Synchronous vs asynchronous operations

According to [The Free Dictionary](https://www.thefreedictionary.com/asynchronous+operation), *Asynchronous operations* are "operations that occur without a regular or predictable time relation to other events". On the other hand, *synchronous operations* are "operations that are initiated predictably by a clock".

That is as clear as mud. Let's try a different approach.

- Imagine that you are sitting on a chair in your room when you decide to read a book. The books are on a shelf behind you. You get your ass off the chair, walk to the bookshelf, take a book off it, return to your chair. Then you can read it.

That is a ***synchronous*** operation. You do the task yourself from start to finish. And you are busy all the time it takes to complete it. Since you do it yourself, **you know when it is done**. If you can't find a book you are looking for, you know that straight away. You don't need to rely on anyone to tell you.

- Now let's imagine that you are rich. You live in a mansion. The books are in a library in another wing of the house. Instead of getting a book yourself, you call a butler (of course you have a butler) and ask him to fetch the book. The butler goes to the library. Sometime later he returns and hands over the book to you.

That is an ***asynchronous*** operation. Instead of doing the task yourself, you **delegate** it to somebody else. They carry it out, then return and **notify** you that it is completed. Since that isn't you who does the task, **you need to be told** that it is completed. If the butler can't find the book you asked for, **he would need to tell you that** in order for you to know.

Therefore the properties of a ***synchronous*** operation are:

- You do it yourself.
- It keeps you busy while you're doing it.
- You know when it's done.
- You know whether it succeeds of fails.

Conversely, an ***asynchronous*** operation is one which:

- You delegate it to someone else to do.
- You are not busy while it's being done.
- You need to be notified once it's completed.
- You need to be told whether it succeeds of fails.

## Why do we need asynchronous operations?

What do we do while **we** are doing the task? We are busy doing it (d'oh!). That means that we can't do anything else until it is completed. What if it is really really long? Then it'd take a really really long time. All of that time we'd be busy.

When I say *we are busy*, that in Javascript means the *main thread*. A *thread* means execution sequence which processes instructions one after another. The *main thread* is your programme. If we start a long operation, **the main thread is blocked by it until it completes**. Therefore, we say that **synchronous operations are blocking**.

- Why do we call it the "main thread"? Because modern JavaScript runtime environments can also have other threads running in parallel, such as [web worker](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API/Using_web_workers) and [service worker](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API/Using_web_workers) threads. More on that later.

Now, an important question. What do *we* do while our *butler* does the job? We can sit idling, waiting until he's done, **or** we can do other stuff.

Indeed, **asynchronous operations are non-blocking. They do not block the main thread.** And that is the reason for having them. Even if an asynchronous operation is very, very long, we don't need to wait until it completes. We can continue with our programme (if we want). And when later we get notified about the asynchronous operation's completion, we can take care of its result.

## Who's the butler?

In our metaphor, an asynchronous operation was carried out by a butler. It is the butler who actually does the job while you sit by the fire. So, who's the butler in JavaScript? To understand that we need to dig deeper into JavaScript execution environments.

Both Node.js and web browsers provide a set of APIs. In Node.js those APIs expose access to OS functions and input/output. In a browser, they provide access to DOM, network I/O, local storage etc. In other words, those API provide a bridge between a runtime environment (OS or a web browser) and our Javascript code running on it. Those APIs are typically written in low-level languages like C++. Those languages have an ability to spawn multiple parallel execution streams (aka threads). Whenever an asynchronous operation is required, they can spawn it in another thread in parallel to the main programme. And once an operation is completed, it will signal its completion to the main programme.

Those execution environment APIs are the butlers.

## What kind of JavaScript operations can be asynchronous?

Unfortunately, I failed to find an exact list no matter how much research I did.

A common consensus is that Node.js input/output operations can be asynchronous, that includes file I/O and network operations. Moreover, some APIs have both synchronous and asynchronous option. For instance, Node.js has both [`readFile`](https://nodejs.org/dist/latest-v12.x/docs/api/fs.html#fs_fs_readfile_path_options_callback) and [`readFileSync`](https://nodejs.org/dist/latest-v12.x/docs/api/fs.html#fs_fs_readfilesync_path_options)` functions. Both do the same thing. However, the former is asynchronous while the latter is synchronous.

In a web browser, *Web APIs* can be asynchronous. That includes:

- [`XMLHttpRequest`](https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest) aka *Ajax*
- [HTML5 GeoLocation APIs](https://developer.mozilla.org/en-US/docs/Web/API/Geolocation_API)
- [HTML5 Web Workers](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API/Using_web_workers)
- [IndexedDB](https://developer.mozilla.org/en-US/docs/Web/API/IndexedDB_API)

In fact, any of Web APIs can be asynchronous. [MDN lists all Web APIs](https://developer.mozilla.org/en-US/docs/Web/API). However, they don't mention which of those are asynchronous.

Apart from the above, these three APIs can be used to execute any Javascript code in an asynchronous context (see the next section):

- [`setTimeout()`](https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/setTimeout)
- [`setInterval()`](https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/setInterval)
- [`requestAnimationFrame()`](https://developer.mozilla.org/en-US/docs/Web/API/window/requestAnimationFrame)

## Can you make your own butler?

At the time of writing (October 2019) the answer is "kind of yes, sometimes, although it is very complex". Because JavaScript does not have the same kind of support of *multi-threaded programming* as languages such as C++ or Go, we can't write our own *Web APIs* (the butlers) in JavaScript. However, there are a couple of options:

- [We can write our own Node.js Addons in C++](https://medium.com/@atulanand94/beginners-guide-to-writing-nodejs-addons-using-c-and-n-api-node-addon-api-9b3b718a9a7f). However we can't write any kind of similar plugins for a web browser.
- We can utilise JavaScript [Service Workers](https://developer.mozilla.org/en-US/docs/Web/API/Service_Worker_API) and [Web Workers API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API/Using_web_workers) to achieve sort of the same result.

All of those are advanced techniques.

However, there is a neat trick you can use to execute your JavaScript code as if it was an asynchronous code. You can wrap it into `setTimeout()` function with a 0-timeout:

```js
const asyncFunction = () => {
    // This function will run as if it was asynchronous
    ...
}
setTimeout(asyncFunction, 0);
```

[`setTimeout`](https://www.notion.so/ozmoroz/Draft-Async-Await-b4932e6a703c4dfd8b1c996f11f6b3de#d418af93ed7b4330a9f081e6465757f1) takes two arguments: a function and a timeout. It executes the function once a timeout is elapsed. Because in our case timeout is 0, the function is executed immediately. However, it is carried out by a *butler* rather than us (the main thread). Therefore it doesn't block the main thread.

## Summary

Let's recap what we learned.

- Synchronous operations are **blocking**. I.e. they **block** the *main thread* until they are completed.
- Asynchronous operations are **non-blocking**. The main thread doesn't need to wait until an asynchronous operation is completed. Instead, an asynchronous operation has means to notify the main thread once it's done.
- Asynchronous operations are carried out by a runtime environment, such as Node.js or web browser's Web APIs.
- Although you can't make your own truly asynchronous operation in JavaScript, there's a workaround involving `setTimeout()` API.

Now you have an essential understanding of asynchronous operations in general and their implementation in Javascript. However, there's much more to learn. Stay tuned. To be continued...

## Reference

- [How JavaScript works in browser and node?](https://itnext.io/how-javascript-works-in-browser-and-node-ab7d0d09ac2f)
- [Beginners guide to writing NodeJS Addons using C++ and N-API (node-addon-api)](https://medium.com/@atulanand94/beginners-guide-to-writing-nodejs-addons-using-c-and-n-api-node-addon-api-9b3b718a9a7f)
- [Web APIs, MDN](https://developer.mozilla.org/en-US/docs/Web/API)
