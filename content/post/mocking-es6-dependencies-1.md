---
Title: "Mocking ES6 module dependencies with import * from"
Series: ["Mocking ES6 module dependencies"]
Date: 2017-09-26
Author: Sergey Stadnik
Category: technology
Tags: [javascript]
Slug: mocking-es6-dependencies-1
aliases:
  - /2017/09/mocking-es6-dependencies-1.html
---

Not so long ago I faced a problem: I needed to mock ES6 module’s dependencies for unit testing. The reason for mocking dependencies in unit tests is the following: when I write a unit test, I want to test the functionality of a single unit of code, hence a unit test. However, if a module has any dependencies, those dependencies need be satisfied. That may mean importing and executing code in other modules. As a result, the unit test loses its _purity_ – the test results will depend not only on the module I’m focusing on but also on the other code my module depends on.
<!--more-->

### Summary:

* ES6's <code>import * from</code> statement provides a convenient way to mock the dependencies of ES6 modules without any 3rd party libraries.
* However, the modules which are being mocked are **always** evaluated, which sometimes may be unacceptable.

To mitigate that issue we may want to <em>mock</em> the dependencies of the module we're testing, i.e. to substitute them with another code with limited functionality. That substitution code may either do nothing at all or verify that certain functions are called in the right way. Some frameworks, like <a href="https://angularjs.org/">AngularJS</a>, enforce <a href="https://en.wikipedia.org/wiki/Dependency_injection">dependency injection</a> design pattern and provide <a href="https://angular.io/guide/testing#test-a-component-with-a-dependency">standard ways for mocking dependencies</a>. However, if you are using a framework like <a href="https://facebook.github.io/react/">React.js</a>, you are out of luck. Dependency injection is not enforced in React, and usually not used. Dependencies are generally imported using Javascript's <code>require</code> statement or <code>import</code> if you write in ES6. Furthermore, there is no standard way to mock dependencies in React (or Javascript / ES6).

Because there is no standard way, there are, in a typical Javascript manner, quite a few non-standard ones. There are <a href="https://github.com/mfncooper/mockery">mockery</a>, <a href="https://github.com/boblauer/mock-require">mock-require</a>, <a href="https://github.com/thlorenz/proxyquire">proxyquire</a> , and <a href="https://github.com/speedskater/babel-plugin-rewire">babel-plugin-rewire</a> to name just a few.  Besides, there are ways to do <a href="https://github.com/krasimir/react-in-patterns/tree/master/patterns/dependency-injection">dependency injection in React</a>. There are <a href="http://www.jamesmonger.com/post/react-component-dependency-injection.htm">eloquent arguments</a> for using dependency injections in React, and equally persuasive <a href="https://medium.com/@maxheiber/no-need-for-dependency-injection-in-react-components-641182760aaa">counter-arguments</a>. There are <a href="https://stackoverflow.com/questions/35240469/how-to-mock-the-imports-of-an-es6-module">lengthy discussions on stackoverflow.com</a> about Javascript and ES6 import mocking.

All the discussions apart, I had a real problem. I write in ES6 with React and <a href="https://facebook.github.io/react/docs/introducing-jsx.html">JSX</a> and then transpile it into ES5 with <a href="https://babeljs.io/">Babel</a>. My unit tests are written in ES6, and I use <a href="https://mochajs.org/">mocha</a>, <a href="http://sinonjs.org/">sinon</a> and <a href="http://airbnb.io/enzyme/">Enzyme</a>'s <a href="http://airbnb.io/enzyme/docs/api/shallow.html">shallow rendering</a> for testing. I don't use dependency injection. My module dependencies are imported using ES6 <code>import</code> statements. I wanted to be able to mock those dependencies. I started trying various methods and found that most of them didn't work for me. Some of them didn't work at all; the others didn't quite do what I needed. Finally, I found two solutions which got the job done, albeit with some caveats: a <em>standard</em> (kind of) ES6 way which requires no 3rd party libraries, and <a href="https://github.com/thlorenz/proxyquire">proxyquire</a>. I will talk about the "standard" way in this article, and about <a href="https://github.com/thlorenz/proxyquire">proxyquire</a> in the next one.

### import * as ...

As documented in <a href="https://stackoverflow.com/a/38414108/10557">this stackoverflow.com answer</a>, ES6 provides construction<code>import * as</code> to import all exported items from a module. Once the module is imported, its individual exports can be overridden with mock-ups.

Let's say we have `export1.js` module which exports a single function:

{{<highlight javascript "hl_lines=1">}}
console.log('If you can see that, export1.js is evaluated');

export const exportFunc = () => {
  return 'This is real exportFunc from export1';
};
{{</highlight>}}

Pay attention to the `console.log` here. That is to check whether this module is evaluated during the unit test's execution.

Then there's another module `module1` which imports and calls it:

{{<highlight javascript>}}
import { exportFunc } from './export1';

export const myFunc = () => {
  return exportFunc();
};
{{</highlight>}}

Then a unit test for <code>module1</code> which mocks <code>export1</code> would look like this:

{{<highlight javascript>}}
'use strict';
import { myFunc } from './module1';
import * as export1 from './export1';

/* global beforeEach, describe, sinon */

describe.only('import * from - a dependency in another module',
() => {
  let export1Mock;

  beforeEach(() => {
    export1Mock = sinon.mock(export1);
    export1Mock
      .expects('exportFunc')
      .once()
      .returns('This is mocked exportFunc');
  });

  it('exportFunc function should be called', () => {
    myFunc();
    export1Mock.verify();
  });

  afterEach(() => {
    export1Mock.restore();
  });
});
{{</highlight>}}

![Test completed successfully](/images/export_func1_function_called_passed.png)

That is not very straightforward, but not too bad either. Pretty much like <a href="http://thejsguy.com/2015/01/28/mocking-services-in-angular-with-$provide.html">Angular's $provide syntax</a>.

Let's unpack what's going on here.

{{<highlight javascript>}}
import { myFunc } from './module1';
import * as export1 from './export1';
{{</highlight>}}

Here we import <code>function</code> from <code>module1</code> we are tesing as usual. However, we use <code>import * as</code> technique to import <code>export1</code> module containing the dependencies we want to mock. The entire <code>export1</code> module is imported as <code>export1Mock</code> _object_.

Then we replace <code>export_func1</code> of <code>export1Module</code> with a [sinon mock](http://sinonjs.org/releases/v3.3.0/mocks/). That mock expectes <code>export_func1</code> to be called once and returns string <code>'This is mocked export_func1'</code>.

{{<highlight javascript>}}
beforeEach(() => {
  export1Mock = sinon.mock(export1);
  export1Mock
    .expects('exportFunc')
    .once()
    .returns('This is mocked exportFunc');
});
{{</highlight>}}

After that, we call <code>myFunc</code> and verify that it calls our mocked instance of <code>export_func1</code> rather than real one.

{{<highlight javascript>}}
it('export_func1 function should be called', () => {
  myFunc();
  export1Mock.verify();
});
{{</highlight>}}

Finally, we reset our mocked function to get it ready for the next test / iteration.

{{<highlight javascript>}}
afterEach(() => {
  export1Mock.restore();
});
{{</highlight>}}

However, there is an issues with this approach. As you may have noticed, we can see the output of the <code>console.log</code> we've put into <code>export1.js</code>, that means that the module was evaluated despite the fact we mocked it.

Turns out, the content of modules imported via <code>import * as</code> <strong>always</strong> gets evaluated <strong>included their <code>import</code> statements</strong>. That breaks the _unit test purity_ principle: your test will not only depend on the code you're testing, but on the modules it imports, and the modules those modules import, and so on. In practice that is usually fine if your modules only contain functions. But if any of the modules in your import chain contains any global code, it will get executed, and you may get an error.

In [the next part of the series](../mocking-es6-dependencies-1.html), I will explore an alternative technique which can alleviate the above issue - mocking up Javascript module dependencies with [proxyquire](https://github.com/thlorenz/proxyquire).

_The source code of the examples for this article can be downloaded from [my Github repository](https://github.com/ozmoroz/es6-unit-mockups)._