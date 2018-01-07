---
Title: "Date conversion in Oracle part 2"
Series: ["Common mistakes of Oracle programmers"]
Date: 2009-05-18
Author: Sergey Stadnik
categories: ["technology"]
Tags: [oracle]
Slug: Date-conversion-in-Oracle-part-2
aliases:
  - /2009/05/Date-conversion-in-Oracle-part-2.html
---

It's a follow-up to [the previous post](../../2009/05/Date-conversions-in-Oracle.html).

As it turned out, implicit date conversions may also prevent Oracle from
doing the [partition
pruning](http://www.orafaq.com/tuningguide/partition%20prune.html).
For example, if you have a table `INVOICES` with a range partition on
`INVOICE_DATE` field, then expression

{{<highlight sql>}}
SELECT
...
WHERE invoice_date >= '01-MAR-09'
  AND invoice_date <  '02-MAR-09'
{{</highlight>}}

will not perform the partition pruning, whereas

{{<highlight sql>}}
SELECT
...
WHERE invoice_date >= TO_DATE('01/03/2009', 'DD/MM/YYYY')
 AND invoice_date <  TO_DATE('02/03/2009', 'DD/MM/YYYY')
{{</highlight>}}

will.

Because the efficiency of partition pruning is usually why partitioning
is used in the first place, the choice is obvious.

But after all, I’d use

{{<highlight sql>}}
SELECT
...
WHERE invoice_date BETWEEN TO_DATE( '01/03/2009', 'DD/MM/YYYY')
AND TO_DATE( '01/03/2009', 'DD/MM/YYYY') + 1 - 1/24/3600
{{</highlight>}}

since `BETWEEN` operation is specifically tailored for such situations.
"1/24/3600" here represents 1 second, and the whole statement should be
read as "From 01 March 2009 0:00am to 01 March 2009 11:59pm".