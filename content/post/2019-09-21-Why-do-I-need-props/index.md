---
Title: "Why do I need props?"
Date: 2019-09-21
Author: Sergey Stadnik
categories: ["technology"]
Tags: [javascript, react]
Slug: why-do-i-need-props
---

{{<responsive-figure src="props.jpg" width="640px" alt="Props???">}}

If you are new to React, you may be wondering what that *props* business is all about. Components make sense. But why do they need props? Why should you use them, or then, or how? After all, you can build a perfectly functioning React application without those pesky *props*.

Well, you don't have you use props inside your React components. It is fair that not all the components require props. But still, they are worth understanding. And here is why.

<!--more-->

Props allow us to write *reusable* components, thus reducing the amount of code we need to write. Reusing the existing code is possibly be the most efficient way to lift a programmer's productivity.

Let's look at an example. One day you decide to write a web app to list all the books you want to read. You roll up your sleeves and come up with this React component:

```javascript
const Books = () => {
  return (
    <div>
      <h1>Books</h1>
      <div>
        <img
          src="/images/harry_potter_sorcerers_stone.jpg"
          alt="Harry Potter and the Sorcerer's Stone"
        />
        <p>Title: Harry Potter and the Sorcerer's Stone</p>
        <p>Author: J.K. Rowling</p>
      </div>
      <div>
        <img src="/images/hunger_games.jpg"
             alt="The Hunger Games" />
        <p>Title: The Hunger Games</p>
        <p>Author: Suzanne Collins</p>
      </div>
      <div>
        <img src="/images/angels_and_demons.jpg"
             alt="Angels & Demons" />
        <p>Title: Angels & Demons</p>
        <p>Author: Dan Brown</p>
      </div>
      <div>
        <img src="/images/girl_on_train.jpg"
             alt="The Girl on the Train" />
        <p>Title: The Girl on the Train</p>
        <p>Author: Paula Hawkins</p>
      </div>
    </div>
  );
};
```

It does the job perfectly fine. However, that was a lot of typing! And copy-pasting. You don't need to look too closely to notice that your component essentially is made of four repeating sections - one for each book. Every section contains an image tag with a cover image, a paragraph for a book title and another one for an author's name. What if instead of four sections you could write just one and reuse it?

Enter *props*.

Let's create a Book component which shows the info for one book only.

```javascript
const Book = ({ cover, title, author }) => (
  <div>
    <img src={cover} alt={title} />
    <p>Title: {title}</p>
    <p>Author: {author}</p>
  </div>
);
```

`Book` is a [functional React component](https://ozmoroz.com/2018/08/react-functional-vs-class-components/). It takes 4 props: `cover`, `title` and `author`. When we put those props into curly braces inside the body of that component, they are **substituted with values of those props**. Note that we reuse `title` prop as our cover *alt* string.

Therefore, we can rewrite our `Books` component like this:

```javascript
const Books = () => {
  return (
    <div>
      <h1>Books</h1>
      <Book
        cover="/images/harry_potter_sorcerers_stone.jpg"
        title="Harry Potter and the Sorcerer's Stone"
        author="J.K. Rowling"
      />
      <Book
        cover="/images/hunger_games.jpg"
        title="The Hunger Games"
        author="Suzanne Collins"
      />
      <Book
        cover="/images/angels_and_demons.jpg"
        title="Angels & Demons"
        author="Dan Brown"
      />
      <Book
        cover="/images/girl_on_train.jpg"
        title="The Girl on the Train"
        author="Paula Hawkins"
      />
    </div>
  );
};
```

Ok, let's sum up what we just did. We created a **reusable** `Book` component. Then we reused it four times to make up our book list. Our initial implementation of `Books` component effectively contained HTML markup for all the books. If we wanted to make a change to the way books are represented, for example, apply the same CSS style to every book, we'd need to hardcode it as many times as the books we have.

```javascript
const Books = () => {
  return (
    <div>
      <h1>Books</h1>
      <div className="book">
        ...
      <div className="book">
        ...
      </div>
      <div className="book">
        ...
      </div>
      <div className="book">
        ...
      </div>
    </div>
  );
};
```

On the other hand, our latest implementation of `Books` contains very little markup, and none of it is for books. All markup for all of the books is encapsulated inside `Book` component. All we need to do to apply the same CSS style to every book is to add a single line:

```javascript
const Book = ({ cover, title, author }) => (
  <div className="book">
    <img src={cover} alt={title} />
    <p>Title: {title}</p>
    <p>Author: {author}</p>
  </div>
);
```

That is a power of components, props and code reuse.

But please bear with me a little longer. I'll show you something cool. The real magic starts if you apply a *data-driven* approach. Let's say you consolidate the data about books into a single array.

```javascript
const books = [
  {
    cover: '/images/harry_potter_sorcerers_stone.jpg',
    title: "Harry Potter and the Sorcerer's Stone",
    author: 'J.K. Rowling'
  },
  {
    cover: '/images/hunger_games.jpg',
    title: 'The Hunger Games',
    author: 'Suzanne Collins'
  },
  {
    cover: '/images/angels_and_demons.jpg',
    title: 'Angels & Demons',
    author: 'Dan Brown'
  },
  {
    cover: '/images/girl_on_train.jpg',
    title: 'The Girl on the Train',
    author: 'Paula Hawkins'
  }
];
```

Then we can replace our `Books` component with this:

```javascript
const Books = () => (
  <div>
    <h1>Books</h1>
    {books.map(book => (
      <Book
        key={book.title}
        cover={book.cover}
        title={book.title}
        author={book.author}
      />
    ))}
  </div>
);
```

Here we loop through `books` array with [Array's map function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/map) and render all the individual `Book` components with props taken out of that array.

Note `key` prop. It is a special prop React requires when rendering multiple elements of the same type using loops. You can read more on that here: [Lists and Keys](https://reactjs.org/docs/lists-and-keys.html). It needs to be unique across all elements in the list. In our case, use the cover image URL as a key assuming that it is highly unlikely that two books have the same cover.

## Let's recap what we learned about props:

- Props allow us to pass data into the components.
- They enable use to write *reusable* code.
- Reusable components encapsulate markup and styling inside them making code changes and maintenance easier.
- A *data-driven* approach combined with reusable components allows us to write very compact code.
- Finally, less code we write, more productive we are.

Happy coding!
