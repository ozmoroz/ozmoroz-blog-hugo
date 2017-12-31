---
Title: Role play modelling
Date: 2008-11-06
Author: Sergey Stadnik
Category: technology
Slug: role-play-modelling
---

Virtually every software development methodology stresses a need for
specifying how the software end product is expected to work before
starting the programming. But the truth is that writing specifications
is boring. And most programmers, being lazy people (in good meaning of
"lazy". Yes, I believe there is a good meaning) try to avoid boring work. So, when the specs are
written, they are often incomplete and don't cover all the possible
scenarios. Moreover, as the requirements change, these specs become
outdated and, hence, even less useful.

I wonder if there is a way to replace the boring specs with something
which is fun.

One possible way to go may be a "Role play-style modelling". Just think
about it. Usually software product consists of a number of modules
communicating to each other. Each module does a specific task. In a
typical software project, different developers are assigned to implement
different modules.

Now imaging that before diving into coding, you have a kind of a
role-playing game, where each of the programmers is actually pretending
to be a module he is going to program. It goes like that:

_Dave is a module that reads an XML file and converts it into a spreadsheet,
Bob is a module that is responsible for taking the spreadsheet and sending
it to users as an e-mail attachment._

__Dave:__ Trying to open the XML file. Wait a minute, what if it's
not a well-formed XML, what am I supposed to do then? I should probably
send an error message back. Ok, I read it and successfully transformed.
Now I notify Bob that it's ready. Bob, we need to decide on this
notification protocol. Now, it's your turn.

__Bob:__ Ok, first I need to create an e-mail. Where do we get the e-mail
address and subject line from – should we ask the user? This is something
to find out. Then I need to check that the e-mail address is well-formed
and the subject line is not empty. Then I read the spreadsheet file Dave
provided and attach it. Dave, how big this file can be?

__Dave:__ I reckon it's up to 1 Mb, but I need to clarify it.

__Bob:__ I need to find out if I need to compress it. Then I try to send
the e-mail. If it is sent successfully, I report Ok status back to Dave.
If it's failed, I report failure status with the error message.<br>
...<br>
And so on.

That would give all the participants the understanding of how the end
product should work. And, assuming the programmers are taking notes as
they do it, every one will end up with a mini-spec just for themselves.

Another advantage of such approach is that it would encourage people to
discuss every possible situation and ask "what if" questions. And asking
them is the most important part of the whole process. While there is at
least one outstanding question, the spec is incomplete. So, after our
game, Bob and Dave would depart on harassing whoever appropriate, like
business analysts or even end users, to extract the answers from them.
And once they have the answers, we would repeat the game again.

And would do it over and over again, until everything unknown is ruled
out.<br>
It sounds like a odd approach, but it just might be odd enough to work.