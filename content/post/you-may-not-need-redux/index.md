---
title: "You may not need Redux"
date: 2020-07-15T15:17:53+10:00
draft: false
Author: Sergey Stadnik
categories: ["technology"]
Tags: [javascript, react]
Slug: you-may-not-need-redux
Description: Why you probably don't need to use Redux in your React project any more.
---

{{<responsive-figure src="feature.jpg" width="640" alt="Erasing complexity" caption="Image by " attr="lightsource" attrlink="https://depositphotos.com/15429037/stock-photo-creative-business-solutions.html">}}

If you were starting a new React project a few years ago, that almost always meant that you'd include [Redux](https://redux.js.org/). React and Redux were thought to be one indivisible entity. When I was learning React myself I did that with the help of Stephen Grider's excellent course [Modern React with Redux](https://www.udemy.com/course/react-redux/). That course is a true bestseller. Nearly 200,000 students watched it since it was released. Stephen keeps it updated so that it includes the latest React features. You got it - that bestselling course on React has "Redux" in its title.

The year is now 2020 as I am writing it from a social distancing safety of my home. Quite a lot has changed in React in those few years. We now have hooks, we mostly write functional components and we now have a new and improved [context API](https://reactjs.org/docs/context.html).

The big question is: Do we still need Redux?

I personally didn't use Redux in any of project I started over the last couple of year or so. I don't expect to use it in future either. Here's why.

<!--more-->

Redux was revolutionary when it appeared in 2015. It brought two big ideas to React:

- It combined action-based model of [Flux](https://facebook.github.io/flux/) with a concept of [Reducer](https://redux.js.org/glossary#reducer) (It is in its name: *"Red"* "ux" = *"Red"*ucer + Fl*"ux"*). That *Action - Reducer* pattern instantly gained traction among React programmers.
- It solved an *application-wide state*. Let's say we had certain data that we wanted to make available throughout the app. Before Redux the only reliable way to do that was to pass that data through props to child components... and then to their child components, and so on. Redux changed that. It allowed pieces of data to transcend the entire component hierarchy of an application without passing that data through props from one component to another. It also provided a convenient way to access and manipulate that application state from anywhere in the application.

Redux used a [context API](https://reactjs.org/docs/legacy-context.html) under the hood, which at the time was intended for React internal use only and was cumbersome to use.

Fast forward to 2020. A lot has changed. We now have hooks and the stable public [context API](https://reactjs.org/docs/context.html) which is ready for the prime time. An action - reducer pattern is now readily available via [useReducer hook](https://reactjs.org/docs/hooks-reference.html#usereducer). We don't need Redux for that any more.

The modern React [context API](https://reactjs.org/docs/context.html) is simpler, more efficient than before and comes with [hooks support](https://reactjs.org/docs/hooks-reference.html#usecontext). In most cases, [wrapping your application state in a context](https://kentcdodds.com/blog/application-state-management-with-react) is all you need to access it anywhere in your app.

So what about Redux?

My point of view that in a vast majority of cases you don't need Redux any more. Contexts and hooks get the job done most of the time. If you still think that contexts are not very friendly you may have a look at [unstated-next](https://github.com/jamiebuilds/unstated-next) library which is just a thin wrapper on top of the context API. That whole library is just 200 bytes!

However, plugging Redux into your project may be warranted if:

- you want to take advantage of [Redux middlewares](https://redux.js.org/advanced/middleware) such as [redux-thunk](https://github.com/reduxjs/redux-thunk)
- or you love [Redux developer tools](https://github.com/zalmoxisus/redux-devtools-extension) with their [time-travelling ability](https://medium.com/the-web-tub/time-travel-in-react-redux-apps-using-the-redux-devtools-5e94eba5e7c0).

In that case, make sure you know what you are doing. Redux magic comes with a price.

Redux is a complicated beast. It will bring a lot of complexity into your app. Some of that complexity is [obvious](https://redux.js.org/api/bindactioncreators) while many other unobvious gotchas are [hidden and waiting for you to trip on it](https://dev.to/jsmanifest/12-things-not-to-do-when-building-react-apps-with-redux-n5i). Think twice if you want to deal with that. Even then it is worth checking out alternatives such as [MobX](https://mobx.js.org/) or [react-sweet-state](https://github.com/atlassian/react-sweet-state).
