---
Title: "Date conversions in Oracle"
Series: ["Common mistakes of Oracle programmers"]
Date: 2009-05-13
Author: Sergey Stadnik
Category: technology
Tags: [oracle]
Slug: Date-conversions-in-Oracle
---

When I was going through PL/SQL procedures written by some of my
colleagues, I noticed a few mistakes made around the Oracle’s date
conversion functions. There are some peculiarities about those functions
that I thought everyone knew about. But I reckon if I write about it, it
may help others to avoid such mistakes. I also allowed myself to outline
a few rules that, if you adhere to them, will help you to write better
programmes.

There are 2 functions in Oracle to convert strings to dates and back.

The first one is
[`TO_DATE`](http://download.oracle.com/docs/cd/B19306_01/server.102/b14200/functions183.htm#i1003589)
– it takes a **string** parameter and returns a **date**. Ok, it’s
actually a**date/time** combination enclosed into a single data type –
Oracle’s `DATE`.

The second one is
[`TO_CHAR`](http://download.oracle.com/docs/cd/B19306_01/server.102/b14200/functions180.htm#i1009324)
– does the opposite: it takes **date/time** as Oracle’s `DATE` data type
and converts it to **string**.

Actually, these functions are bit more complex than that, but for our
purpose that will do. What’s important to understand here is the distinction between date as a `DATE` data type and its string representation.

For example, when you type `’01-APR-09’` in the procedure’s text, that’s a
**string**, representing a date. Pay attention here: although you meant
a date, Oracle sees a string. For Oracle everything that is enclosed in
single quotation marks is a string. To make it a date, we need to
convert this string to a `DATE` data type. Such conversion can be carried
out by 2 possible ways: explicitly and implicitly.

Explicit conversion is when we apply the `TO_DATE` function to the
string:

~~~~plpgsql
v_date DATE;
v_date := TO_DATE('01/04/2009', 'DD/MM/YYYY');
~~~~

Now `v_date` is a date, representing April 1st, 2009.

Implicit conversion is when we let Oracle to perform the conversion:

~~~~plpgsql
v_date DATE;
v_date := '01-APR-09';
~~~~

It has the same effect. Every time Oracle sees a string in place where
it expects a date, it is smart enough to perform the conversion for us.
"Well", you may think, - "That’s great. Oracle does it all for us, so we
don’t have to do it. Life is easier, let’s go for another coffee break".

Not quite.

You see, when Oracle does such implicit conversion, it relies on some
assumptions. If you read the documentation for `TO_DATE` and `TO_CHAR`
functions, you’ll find that they take another
optional parameter – the **date format**. That format tells Oracle how
the string representing the date/time should be treated. If the format
parameter is not specified, it is taken from `NLS_DATE_FORMAT` Oracle
parameter. Here’s the crux: We can’t assume that this parameter will be
the same on all Oracle systems. Although it is ‘DD-MON-RR’ by default
and it is left like that on most Oracle systems, we can’t assume that
it’s going to be like this always and everywhere. And if you rely on
implicit date conversions and some DBA changes `NLS_DATE_FORMAT`
parameter – WHAM! – All your programs will stop working.

So, a good practice and rule of thumb for you should be:

<p class="text-danger">Never ever rely on implicit date conversions! Whenever you need to convert date to string or vice versa, use an appropriate <code>TO_DATE</code> or <code>TO_CHAR</code> function and always specify a date format.
</p>

Just like this:

~~~~plpgsql
v_date DATE;
v_date := TO_DATE('01/04/2009', 'DD/MM/YYYY');
~~~~

The danger of `NLS_DATE_FORMAT` being changed is the biggest threat but
not the only one.

Pay attention to the default date format I provided just above –
`‘DD/MM/RR’`. Do you notice anything suspicious? The year is 2 digits.
Here Oracle tries to be smartass and [tries to
guess](http://download.oracle.com/docs/cd/B19306_01/server.102/b14200/sql_elements004.htm#SQLRF00215)
whether you mean XX or XXI century. Your only hope that it can figure
out what you meant and doesn’t make a mistake. But if it mistakes –
oops, welcome back the Millennium Bug. This brings us to the second
rule:

<p class="text-danger">Always specify the 4-digit year.</p>

Another dangerous programming technique is trying to convert Date to
Date where no conversion is necessary.

Let’s have a look at the following example, or should I say a puzzle?

~~~~plpgsql
DECLARE
   v_date DATE := '01-APR-09';
   v_date_2 DATE := TO_DATE (v_date, 'DD/MM/YYYY');
BEGIN
   dbms_output.put_line (TO_CHAR (v_date_2, 'DD/MM/YYYY'));
END;
~~~~

Try to guess what will be printed as a result.

If you think ‘01/04/2009’, you’ve just screwed your business critical
application and have sent it two thousand years back in time.

In fact, you’ll get **‘01/04/0009’**.

This is where it all goes bad:

~~~~plpgsql
v_date_2 DATE := TO_DATE (v_date, 'DD/MM/YYYY');
~~~~

And here’s why:

The first thing Oracle tries to do is to execute `TO_DATE` function.
There is only one `TO_DATE` function in Oracle – the one that takes a
string and converts it to a date. Despite we know that `v_date` is not a
string, Oracle still proceeds with its logic. If you run this code, it
won’t produce an error.

Oracle successfully convinces itself that it sees a String where it has
a Date. That happens because Oracle is able to implicitly convert that
date to a string, effectively turning that line
into

~~~~plpgsql
v_date_2 DATE := TO_DATE (TO_CHAR(v_date), 'DD/MM/YYYY');
~~~~

But, as we’ve already learned, implicit date to string conversions are
performed using the date format recorded in `NLS_DATE_FORMAT` Oracle
parameter, which is by default set to `‘DD-MM-RR’`. Hence, what Oracle
effectively does is this:

~~~~plpgsql
v_date_2 DATE := TO_DATE (TO_CHAR(v_date, 'DD-MM-RR'), 'DD/MM/YYYY');
~~~~

Can you spot the error already? The date formats are inconsistent! This
is what you get when you don’t pay attention to the details.

So, here comes rule 3:

<p class="text-danger">Avoid unnecessary conversions. Never convert dates to dates.</p>

If you think that all this stuff is pretty confusing, that's because it
indeed is. The good news is that you can avoid the confusion altogether
by learning to program in a more clear, more concise way. That is a
foundation of a good programming style.