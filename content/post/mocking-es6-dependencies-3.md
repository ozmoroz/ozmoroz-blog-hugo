---
Title: "Mocking same module ES6 dependencies"
Series: ["Mocking ES6 module dependencies"]
Date: 2017-10-16
Author: Sergey Stadnik
Category: technology
Tags: [javascript]
Slug: mocking-es6-dependencies-3
aliases:
  - /2017/10/mocking-es6-dependencies-3.html
---

There is a subtle issue for which, unfortunately, neither ES6 nor proxyquire provide a solution. It is well described in <a href="https://stackoverflow.com/a/41426098/10557">this stackoverflow.com answer</a>.
So far in the previous articles of the series, the dependencies we were mocking were in a _separate_ module from the code we were unit testing. But what if they were in the _same_ module?
<!--more-->

### Summary:

* Neither proxyquire nor <code>import * from</code> provides a way to isolate and mock a dependency if it is located **in the same** module as the function which is being tested.
* proxyquire is not designed for such application and throws an error.
* In order for <code>import * from</code> to work we need to prepend  calls to mocked functions with `export.`. That is because <a href="https://babeljs.io/">babel</a> places all the exported functions into export namespace while transpiling ES6 to ES5.

Suppose we have a module `module3.js` with two functions with one of the functions calling another one:

{{<highlight javascript>}}
export const function1 = () => {
  return function2();
};

export const function2 = () => {
  return 'This is real function2';
};
{{</highlight>}}

We want to test <code>function1</code> in isolation according to the <em>purity</em> principle and for that, we need to replace <code>function2</code> with a mock. We do just that using the same technique as before and run the test:

{{<highlight javascript>}}
'use strict';
import * as module3 from './module3';
import { function1 } from './module3';

/* global beforeEach, describe, sinon */

describe('import * from - a dependency in the same module', () => {
  let module3Mock;

  beforeEach(() => {
    module3Mock = sinon.mock(module3);
    module3Mock
      .expects('function2')
      .once()
      .returns('This is mocked function2');
  });

  it('function2 should be called', () => {
    console.log(function1());
    module3Mock.verify();
  });

  afterEach(() => {
    module3Mock.restore();
  });
});
{{</highlight>}}

![Test failed](/images/export_func1_function_called_failed.png)

As you can see, the test failed, and the _real_ function2 has been called instead of our mock.
Why? To figure that out let's examine the code of <code>module1</code> transpiled into ES5.

{{<highlight javascript>}}
'use strict';
Object.defineProperty(exports, '__esModule', { value: true });
var function1 = (exports.function1 = function function1() {
  return function2();
});

var function2 = (exports.function2 = function function2() {
  return 'This is real function2';
});
{{</highlight>}}

Here we can see that babel assigns two <em>references</em> to <code>function2()</code> : <code>exports.function2</code> and <code>function2</code>.  Then <code>function2()</code> is called from <code>function1()</code> via function2 reference. Since they both point to the same functions, it works as expected.

When we import module into our unit test, we actually import <code>exports.function2</code> reference. Then we replace the function <code>exports.function2</code> points to with our mocked-up version. But <code>function1</code> reference inside module1 still stays intact and still points to the original (not mocked) <code>function2()</code>.

It is like this:

Before function2() is mocked up:

![Before mocking](/images/es6_mock_before.svg)

After function2() is mocked up:

![Before mocking](/images/es6_mock_after.svg)

In order to fix that we need to change <code>function2()</code> call to <code>exports.function2()</code>. Then our code inside <code>function1</code> will call our mocked version of <code>function2()</code> instead of the original.

{{<highlight javascript "hl_lines=2">}}
export const function1 = () => {
  return exports.function2();
};

export const function2 = () => {
  return 'This is real function2';
};
{{</highlight>}}

![Test passed](/images/export_func1_function_called_passed_2.png)

Although you can do that every time you come across such a problem, I would be reluctant. It is a dirty hack, and I wouldn't make any dubious modifications to the code just to make unit tests pass.

But what about proxyquire? Will it help us in this case? Let's rewrite the test with proxyquire and see if we have more luck with it.

{{<highlight javascript>}}
'use strict';
const proxyquire = require('proxyquire').noCallThru();

/* global beforeEach, describe, sinon */

describe('proxyquire - a dependency in the same module', () => {
  let module3
  let mock;

  beforeEach(() => {
    module3 = proxyquire('./module3');

    mock = sinon.mock(module3);
    mock
      .expects('function2')
      .once()
      .returns('This is mocked function2');
  });

  it('function2 function should be called', () => {
    module3.function1();
    mock.verify();
  });

  afterEach(() => {
    mock.restore();
  });
});
{{</highlight>}}

![Test passed](/images/proxyquire_module3_test_failed.png)

Not quite. Proxyquire was designed to mock _module dependencies_ but not the modules themselves. Turns out we can't use it if the dependencies are in the same module.

So, that is it. Both ES6's `import * from...` and proxyquire provide convenient ways to mock Javascript dependencies. But no single approach is perfect. They all have their own features and limitations. I personally use <code>import * from...</code> whenever possible just because it doesn't require any 3rd party libraries, but take advantage of proxyquire's ability to disable the evaluation of dependency modules whenever I need that feature.

_The source code of the examples for this article can be downloaded from [my Github repository](https://github.com/ozmoroz/es6-unit-mockups)._
