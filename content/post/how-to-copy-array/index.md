---
title: "How to make a copy of an array in JavaScript"
date: 2020-07-20T17:51:56+10:00
draft: false
Author: Sergey Stadnik
categories: ["technology"]
Tags: [javascript, react]
Slug: how-to-copy-array
---

{{<responsive-figure src="feature.jpg" alt="Copy machine">}}
---

Making copies of arrays in JavaScript is not as straightforward as it seems. It certainly not as easy as `b = a`.

Let's look at an example:

```jsx
let a = [1, 2, 3]
const b = a
console.log( a === a)
---
a is array of  [ 1, 2, 3 ]
b is array of  [ 1, 2, 3 ]
Is a equal b?  true
```

So far so good. Here's what we did:

- `a` is an array.
- We assigned it to `b`.
- Now `b` is also an array.
- It contains the same elements as `a`.
- And `a` equals `b`.

Is the job done? Not quite.

<!--more-->

Let's add one more step: change a value of one of the elements in `a` array after we "copy" it to `b`:

```jsx {hl_lines=[3,"9-10"]}
let a = [1, 2, 3]
const b = a
a[1] = 3

console.log('a is array of ', a)
console.log('b is array of ', b)
console.log('Is a equal b? ', a === b)
---
a is array of  [ 1, 3, 3 ]
b is array of  [ 1, 3, 3 ]
Is a equal b?  true
```

Wat? We changed the value of an element of `a` array, but `b` also god changed?

That happens because an array is a *reference type* in JavaScript.  When you assign a value of a reference type to another variable, you are not copying the value itself, **you just make another reference to it**.

In our case:

```jsx
let a = [1, 2, 3]
const b = a
```

- `[1, 2, 3]` is an array. `a` is a *reference* to that array.
- We make new *reference* `b` which is the same as `a`. That means that both `a` and `b` refer to the **same array**. And that's why changing the array via `a` also changes it in `b`.

> The whole topic of value types vs reference types is complicated. If you want to know more about that, leave a comment below (you'll need to log in for that). And I'll write something up.

However, sometimes we need to make a real copy of an array, not just make another reference to it. Like if we need to change it in one place without changing in the other.

## Making a true copy of an array

There are multiple ways of cloning an array in JavaScript. In my opinion, the simplest one is to take advantage of ES6 [spread syntax](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Spread_syntax):

```jsx {hl_lines=[2]}
let a = [1, 2, 3]
const b = [...a]
a[1] = 3

console.log('a is array of ', a)
console.log('b is array of ', b)
console.log('Is a equal b? ', a === b)
---
a is array of  [ 1, 3, 3 ]
b is array of  [ 1, 2, 3 ]
Is a equal b?  false
```

`[...a]` effectively makes a new array (for real) with all the elements the same as the original array. If we assign it to `b`, then `b` will still be a *reference*, however, it will point to **the new** array and not the original. Note that `a == b` is `false`. That's how we know that `a` and `b` do not refer to the same array any more.

> Yes, comparing reference types in JavaScript is not simple either. What to know more? Let me know by commenting under that post.

## Cloning a two-dimensional array

Ok, that's all good. But here's a trick question. What if we want to clone a two-dimensional array? Is doing `[...a]` enough?

Not quite. In JavaScript, a two-dimensional array is just an array of arrays. Therefore, cloning one dimension is not enough. We also need to clone all the sub-dimension arrays. Here's how we do that:

```jsx
function cloneGrid(grid) {
  // Clone the 1st dimension (column)
  const newGrid = [...grid]
  // Clone each row
  newGrid.forEach((row, rowIndex) => newGrid[rowIndex] = [...row])
  return newGrid
}

// grid is a two-dimensional array
const grid = [[0,1],[1,2]]
newGrid = cloneGrid(grid)

console.log('The original grid', grid)
console.log('Clone of the grid', newGrid)
console.log('They refer to the same object?', grid === newGrid)
---
The original grid [ [ 0, 1 ], [ 1, 2 ] ]
Clone of the grid [ [ 0, 1 ], [ 1, 2 ] ]
They refer to the same object? false
```

Or if we take advantage of [ES6 Array.map](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/map) operation, we can make `cloneGrid` function even simpler:

```jsx
const cloneGrid = (grid) => [...grid].map(row => [...row])
```

Happy coding!
