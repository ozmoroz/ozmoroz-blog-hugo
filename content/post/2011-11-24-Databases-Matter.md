---
Title: Databases matter
Date: 2011-11-24
Author: Sergey Stadnik
categories: ["technology"]
Slug: databases-matter
Summary: Why every software developer needs to understand how databases work.
---

![Database](/images/2011-11-24_database.png)

Databases are at the core of virtually all modern information
technology systems. Sometimes these databases are exposed, for
example, as in data warehouse systems. The centrepiece of a system
like that is a powerful industrial database such as Oracle, or
Sybase, or Microsoft SQL Server, or something similar. The presence
of a database is pretty obvious in that case – only these powerful
databases can crunch the immense amounts of data processed by data
warehouses. In other cases databases are hidden. For example, Apple
iTunes uses a SQLite database to store the details of music tracks on
your computer. That database is not obvious; it does not advertise
itself, but it's there. It makes sure that the ratings you assigned
to songs are saved and can be synchronised between all your iPhones
and iPads. It counts the number of times every song was played so
that you don't listen to the same song twice when you put your iPhone
on shuffle. Databases are everywhere. They all serve the same purpose
– to store data and make its retrieval as easy and fast as possible
– but they are also vastly different from each other.

Let's take another example. When you log into your Google account
and bring up your Gmail inbox, all the emails you see are actually
stored in the remote database. That database is called BigTable, and
it contains not only your emails, but all the emails of all Gmail
users in the world, and also virtually all of Google's data. While
your iTunes SQLite database may be about 50 megabytes in size (and
that's assuming you have A LOT of songs), Google's BigTable contains
petabytes of data. That's your iTunes database times one billion.

If you think about it, it becomes obvious that these databases
require vastly different approaches to the way the data are stored
and retrieved: You can fit an iTunes database into memory and query
it whichever way you like without a performance penalty. At the same
time, no machine has been built yet that could apply the same
approach to Google's BigTable.

Unfortunately, not all software developers understand that.
Databases once were an inspiring topic but in recent years they went
out of fashion. Software developers are geeks; they like new toys;
they all want to work on something latest and greatest and
cutting-edge. So many new exciting things are happening in the area
of Information Technology – Web 2.0, HTML5 and Apple iOS to name
just a few – that databases just fade in comparison, despite the
fact that they make all these new shiny things tick. Most of the
developers these days take a database just as generic data storage:
“We'll just stuff the data in and we don't care what's inside.”
10 years ago SQL language was a necessary skill for database
application developers. Nowadays the majority of programmers don't
know SQL. They rely on frameworks such as Hibernate to produce SQL
statements for them. They think that all databases are the same and
therefore, if necessary, they can take one system that uses MS SQL
Server as a backend and put it onto Oracle and it will work just
fine.

Well, that may be true for very simple applications. The myth that
all databases are the same is flawed, especially when it comes down
to performance. Today cloud computing is a buzzword, and Google is
the patriarch of the cloud. Google's servers process billions of
requests every day, crunching petabytes of data. Yet, every request
made to a Google search engine is served within seconds. This places
such a high demand on the Google's database layer, that Google's
engineers couldn't afford using even the most powerful of industrial
databases, and they had to develop their own – the aforementioned
BigTable. If you told these guys that “all databases are the same”,
they would laugh into your face, and rightfully so, because Google
knows that performance matters and they try to squeeze every bit of
performance out of their systems.

Databases matter, and if you consider yourself a decent software
developer, you need to learn how to tame them. Learn the differences
between them. Learn what they are, what makes them tick, and the most
importantly, how to make them tick faster, because writing
applications that are slow is just bad taste.