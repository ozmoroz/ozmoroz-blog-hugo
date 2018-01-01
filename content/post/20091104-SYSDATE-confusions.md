---
Title: "SYSDATE confusions"
Series: ["Common mistakes of Oracle programmers"]
Date: 2009-11-04
Author: Sergey Stadnik
Category: technology
Tags: [oracle]
Slug: SYSDATE-confusions
aliases:
  - /2009/11/SYSDATE-confusions.html
---

`SYSDATE` is one of the most commonly used Oracle functions. Indeed,
whenever you need the current date or time, you just type `SYSDATE` and
you're done. However, sometimes it's not all that simple. There are a
few confusions associated with `SYSDATE` that are pretty common and, if
not understood, can cause a lot of damage.

First of all, `SYSDATE` returns not just current date, but **date and time
combined**. More precisely, the current date and time down to a second.
If just a date is needed, `TRUNC` function has to be applied, that is,
`TRUNC(SYSDATE)`. For a sake of a good database design, date should not be
confused with date/time. For example, if a column in a table is called
`transaction_date`, it would be natural for it to contain a **date**,
but not date/time. That may lead to a major confusion. Let's imagine
there is a table `BANK_TRANSACTIONS` containing the following fields:

{{<highlight sql>}}
txn_no     INTEGER,
txn_amount NUMBER(14,2),
txn_date   DATE
{{</highlight>}}

The last field is of the most interest to us. Apparently its data type
is `DATE`, but is it a date or date/time? We can't tell by just looking
at the table definition. Nonetheless, it is a very important thing to
know. A common case for using DATE columns is including them in date
range queries. Forexample, if we wanted to get all the bank transactions
from 1 January 2009 to 31 July 2009 we could write this:

{{<highlight sql>}}
SELECT txn_no,
       txn_amount
FROM   bank_transactions
WHERE  txn_date BETWEEN To_date('01-JAN-2009','DD-MON-YYYY')
AND    To_date('31-JUL-2009','DD-MON-YYYY')
{{</highlight>}}

And that would be fine if `TXN_DATE` were a **date** column. But if it is
a date/time, we would just have missed a whole day worth of data. And it
is because, as I said, `DATE` data type can hold date/time down to a
second. That means that for 31 July 2009 it could hold values ranging
from 0:00am to 11:59pm. But because `TO_DATE('31-JUL-2009',
'DD-MON-YYYY')` is basically an equivalent to `TO_DATE('31-JUL-2009
00:00:00', 'DD-MON-YYYY HH24:MI:SS')`, all the transactions happened
after 0:00am on 31 July 2009 would be missed out.

That kind of mistake is pretty common. Sometimes it's hard to tell by
just looking at the data whether a particular `DATE` column can have date
portion. Even if all the values in there are rounded to 0:00 hours, that
doesn't mean that a different time value can't appear there in the
future. The data dictionary can't help us here either – `DATE` type is
always the same whether it contains time or not. (By the way, Oracle
recommends using `TIMESTAMP` type for new
projects, but that is a whole different story.)

If you are working with an existing table and you are not sure, you can
use a fool-proof method like this:

{{<highlight sql>}}
SELECT txn_no,
       txn_amount
FROM   bank_transactions
WHERE  txn_date BETWEEN To_date('01-JAN-2009','DD-MON-YYYY')
AND    To_date('31-JUL-2009','DD-MON-YYYY') + 1 – 1/24/3600
{{</highlight>}}

`+1 – 1/24/3600` here means “Plus 1 day minus 1 second”. That is because
“1” in `DATE` type means “1 day”, “1/24” - 1 hour, and there are 3600
seconds in an hour.

The above expression will retrieve all the transactions from “01 January
2009 0:00am” to “31 July 2009 0:00am plus 1 day minus 1 second”, i.e. to
“31 July 2009 23:59pm”.

If you are charged with designing an application and need to create a
table with a `DATE` column, it is worth to keep yourself and others from
future confusions by a simple trick: name columns that only contain date
portions as `DATE` and add `TIME` to the name of the columns that
you know will contain time components. In our case it would be prudent
to call the
date/time column `TXN_DATE_TIME`.

The second issue I'd like to discuss is much more subtle, but can do
even more damage.

Imagine that you are charged with developing a report that returns all
the transaction for the previous month. It looks like a job for SYSDATE!
You fetch your trusty keyboard and after a few minutes of typing you
come up with something like this:

{{<highlight sql>}}
SELECT txn_no,
       txn_amount
FROM   bank_transactions
WHERE  txn_date BETWEEN Last_day(Add_months(Trunc(SYSDATE),-2)) + 1
AND    Last_day(Add_months(Trunc(SYSDATE),-1))
{{</highlight>}}

You create a few lines in `BANK_TRANSACTIONS` table, run a few unit tests
to make sure your code works and check it into the source control. Job
done! You congratulate yourself on the productive work and spend the
rest of the day reading your friends' blogs and dreaming about your next
vacation. And the next day you move on to another task and get as busy
as ever.

After some time, which may be a few days or months, depending on the
pace of the project, the code you wrote gets migrated into the UAT
environment. And a task force of a few testers and end users is assigned
to test the report you wrote. And as it often happens in UAT, they are
going to test in on **real data** they extracted from the production
system – that is, the last year's data.

Got it? __Last year's__.

The final stages of testing, such as UAT, have to prove that the system
does what it is expected to do in conditions that resemble the
production as closely as possible. And the best way to do that is to
test it on the retrospective production data – the data that is proven.
That makes it possible to compare the outcome to the actual production
system, and thus, prove or disprove that the new system works.

That sounds reasonable. But one of the implications for you is that
`BANK_TRANSACTIONS` table is not going to contain previous month's
transactions. Hence, your report will be blank. You can't rewind back
time because you hard-coded `SYSDATE`, which has only one meaning – “right
now”. Test failed.

If you have known that when you wrote it, you wouldn't have used the
`SYSDATE`. You would use a parameter, something like `v_run_date`, which
you could set to whatever date you wanted. And that would do. Well, now
you know.