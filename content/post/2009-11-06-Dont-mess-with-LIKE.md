---
Title: "Don't mess with LIKE"
Series: ["Common mistakes of Oracle programmers"]
Date: 2009-11-06
Author: Sergey Stadnik
Category: technology
Tags: [oracle]
aliases:
  - /2009/11/dont-mess-with-like.html
---

As I have [already shown](../../2009/05/Date-conversions-in-Oracle.html) you, implicit type conversion is one of the most dangerous features of Oracle SQL and PL/SQL. It is dangerous because it happens automatically without your knowledge and may lead to unpredictable results. These problems are most common when dealing with DATE conversions, but not limited to them.

For example, let's have a look at this [Stackoverflow.com
question](http://stackoverflow.com/questions/1676064/) by [James
Collins](http://stackoverflow.com/users/143194/james-collins).
James had a problem, the following query was slow:

{{<highlight sql>}}
SELECT a1.*
FROM   people a1
WHERE  a1.ID LIKE '119%'
AND ROWNUM < 5
{{</highlight>}}

Despite column `A1.ID` was indexed, the index wasn't used and
the explain plan looked like this:

{{<highlight sql>}}
SELECT STATEMENT ALL_ROWS
Cost: 67 Bytes: 2,592 Cardinality: 4 2 COUNT STOPKEY 1 TABLE ACCESS FULL TABLE people
Cost: 67 Bytes: 3,240 Cardinality: 5
{{</highlight>}}

James was wondering why.

Well, the key to the issue lies, as it often happens with Oracle, in
an implicit data type conversion. Because Oracle is capable to perform
automatic data conversions in certain cases, it sometimes does that
without you knowing. And as a result, performance may suffer or code
may behave not exactly like you expect.

In our case that happened because `ID` column was `NUMBER`.
You see, `LIKE` pattern-matching condition expects to see character
types as both left-hand and right-hand operands. When it encounters a
`NUMBER`, it implicitly converts it to `VARCHAR2`. Hence, that query was basically silently rewritten to this:

{{<highlight sql>}}
SELECT a1.*
FROM   people a1
WHERE  To_Char(a1.ID) LIKE '119%'
AND ROWNUM < 5
{{</highlight>}}

That was bad for 2 reasons:

1.  The conversion was executed for every row, which was slow;
2.  Because of a function (though implicit) in a `WHERE`
    predicate, Oracle was unable to use the index on `A1.ID` column.

If you came across a problem like that, there is a number of
ways to resolve it. Some of the possible options are:

1.  Create a [function-based index](http://www.akadia.com/services/ora%5Ffunction%5Fbased%5Findex%5F2.html) on `A1.ID` column:

{{<highlight sql>}}
CREATE INDEX people_idx5 ON people (To_char(ID));
{{</highlight>}}

2.  If you need to match records on first 3 characters of `ID`
    column, create another column of type `NUMBER` containing just these 3
    characters and use a plain **=** operator on it.
3.  Create a **separate** column `ID_CHAR` of type `VARCHAR2` and fill it with
    `TO_CHAR(id)`. Then index it and use instead of `ID` in your `WHERE`
    condition.
4.  Or, as [David Aldridge](http://stackoverflow.com/users/6742/david-aldridge)
    pointed out: "It might also be possible to rewrite
    the predicate as `ID BETWEEN 1190000 and 1199999`, if the values are
    all of the same order of magnitude. Or if they're not then `ID = 119 OR
    ID BETWEEN 1190 AND 1199`, etc."

Of course if you choose to create an additional column
based on existing ID column, you need to keep those 2 synchronized.
You can do that in batch as a single `UPDATE`, or in an `ON-UPDATE` trigger,
or add that column to the appropriate `INSERT` and `UPDATE` statements in
your code.

James choose to create a function-based index and it worked like a charm.