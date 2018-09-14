---
Title: "Mocking ES6 module dependencies with proxyquire"
Series: ["Mocking ES6 module dependencies"]
Date: 2017-09-28
Author: Sergey Stadnik
categories: ["technology"]
Tags: [javascript]
Slug: mocking-es6-dependencies-2
---

In <a href="../../../2017/09/mocking-es6-dependencies-1.html">part one</a>, I wrote about mocking ES6 module dependencies using the ES6 native <code>import * from</code> construct. It works mostly fine. However, you need to be aware of a potential issue:
  
  * You need to import modules to mock them, which means that those modules will be evaluated. That may be a problem if you don't want the code in this modules to be executed.
  
Another method I found to work well is using <a href="https://github.com/thlorenz/proxyquire">proxyquire</a>.  It is one of many libraries aiming to streamline mocking dependencies to simplify unit testing.
<!--more-->

### Summary:
* <a href="https://github.com/thlorenz/proxyquire">proxyquire</a> is a 3rd party library which enables mocking Javascript (and ES6) module dependencies by importing them via <code>proxyquire</code> instead of <code>require</code> or <code>import</code>.
* It provides an feature to disable the evaluation of all or some of the mocked modules via its `noCallThru` option.

Let's look at the same examples as in <a href="../mocking-es6-dependencies-1.html">part one</a> and rewrite their unit tests with proxyquire.

Just like in the `import * as` example, we have a module, this time it is `export2.js` which exports a single function:

{{<highlight javascript>}}
console.log('If you can see that, export2.js is evaluated');

export const exportFunc = () => {
  return 'This is real exportFunc from export2';
};
{{</highlight>}}

Again, if we see the message printed by the `console.log` statement, than means this module is evaluated by the unit test.

`module2` module imports and calls the function exported from `export2.js`:

{{<highlight javascript>}}
import { exportFunc} from './export2';

export const myFunc = () => {
  return exportFunc();
};
{{</highlight>}}

Our unit test for <code>module2</code> which mocks <code>export2</code> with proxyquire looks like this:

{{<highlight javascript>}}
'use strict';

// We using proxyquire with noCallThru option here
// to stop index module from being evaluated.
const proxyquire = require('proxyquire').noCallThru();

/* global beforeEach, describe, sinon */

describe.only('proxyquire - a dependency in another module', () => {
  let module2;
  let export2Mock;

  let export2 = {
    exportFunc: function() {}
  };

  beforeEach(() => {
    export2Mock = sinon.mock(export2);
    export2Mock
      .expects('exportFunc')
      .once()
      .returns('This is mocked exportFunc');

    module2 = proxyquire('./module2', {
      './export2': export2
    });
  });

  it('exportFunc function should be called', () => {
    module2.myFunc();
    export2Mock.verify();
  });

  afterEach(() => {
    export2Mock.restore();
  });
});
{{</highlight>}}

![Test passed](/images/proxyquire_test_1_success.png)

The test passed, our mocked-up `exportFunc` was called, and, since we didn't see the message printed by `console.log`, the code of `export2` module **was not evaluated**.

Now, let's figure out what's going on in the unit test step by step.

{{<highlight javascript>}}
const proxyquire = require('proxyquire').noCallThru();
{{</highlight>}}

Here we import proxyquire into our project. `noCallThru()` here indicates that the module dependencies **should not be evaluated**.
I used `require` here to make `noCallThru()` a part of the import, which is more convenient to do with `require` than ES6 `import`.

Then we create an object representing our <code>export2</code> module.

{{<highlight javascript>}}
let export2 = {
  exportFunc: function() {}
};
{{</highlight>}}

After that, we create a <a href="http://sinonjs.org/releases/v4.0.0/mocks/">sinon mock</a> of our <code>export2</code> module. We expect `exportFunc` to be called once and it returns string `'This is mocked exportFunc'`.

<em>The reason why we need to </em>create <em><code>export2</code></em> object<em> above is </em>because sinon<em> mocks can only be created on <strong>existing</strong> objects.</em>

{{<highlight javascript>}}
export2Mock = sinon.mock(export2);
export2Mock
  .expects('exportFunc')
  .once()
  .returns('This is mocked exportFunc');
{{</highlight>}}

Next, we import <code>module2</code> into our test using proxyquire, and we specify that its <code>./export2.js</code> dependency must be substituted by <code>export2</code> created above. Note that the substituted dependencies are specified by their <strong>path</strong> rather than module name. Unfortunately, we can't use <code>require</code> or <code>import</code> here.

{{<highlight javascript>}}
module2 = proxyquire('./module2', {
  './export2': export2
});
{{</highlight>}}

Finally, we call <code>myFunc</code> from the module we imported via proxyquire and verify that the sinon mock's conditions are met.

{{<highlight javascript>}}
it('exportFunc function should be called', () => {
    module2.myFunc();
    export2Mock.verify();
  });
{{</highlight>}}

And, as the last step, we reset the sinon mock.

{{<highlight javascript>}}
afterEach(() => {
  export2Mock.restore();
});
{{</highlight>}}

As you can see, _proxyquire_ provides features for mocking-up Javascript modules similar to ES6 `import * as...` construction, it also allows disabling the evaluation of _real_ dependency modules via `noCallThru()` option. Although in my example I specified `noCallThru` at the import level, it also can be applied to the individual dependencies like this:

{{<highlight javascript "hl_lines=1 5">}}
const proxyquire = require('proxyquire');
...
let export2 = {
  exportFunc: function() {},
  '@noCallThru': true
};
...
module2 = proxyquire('./module2', {
  './export2': export2
});
{{</highlight>}}

However, there is one issue for which neither `import * as` nor proxyquire provides a solution. I will examine it in the next article.

_The source code of the examples for this article can be downloaded from [my Github repository](https://github.com/ozmoroz/es6-unit-mockups)._
