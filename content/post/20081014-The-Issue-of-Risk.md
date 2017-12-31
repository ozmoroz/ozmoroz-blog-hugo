---
Title: The issue of risk
Date: 2008-10-14
Author: Sergey Stadnik
Category: technology
Slug: issue-of-risk_13
---

Once during one of the projects I was asked what was the risk of
something going wrong. I remember I answered that we, programmers, do
not assess risks. We just do everything possible to prevent them. “There
is no point”, I said, “to calculate the chances and the impact of a file
not being in the incoming directory upon the start-up of the process if
we can implement a simple check and avoid the disaster”.
Needless to say, I was wrong.

Nowadays I work in a bank. And one of the things I learned about banks,
they all have departments responsible for managing risks. A bank in its
business plays a risky game - it lends money. It is risky because
there's always a possibility that it will not get them back. And banks
learnt to manage these risks. They ask: "What can go wrong? What can we
do to prevent that? And what can we do to minimize the impact if we
won't manage to prevent it?"

Software industry is much much younger than banking. But we are proud of
ourselves, because we use cutting-edge technology and most modern
methodologies. Yet, we haven't learnt some basic principles other
industries employ for decades.

We don't manage risks.

I've seen a few projects screw-ups, all for various reasons: a
technology chosen wasn't robust enough to support the solution, the
staff's skills were not strong enough to implement the solutions,
requirements were unrealistic... The cause may be different, but the
result is always the same - failure, or infinite slippage of the
deadline, which is the same as a failure.
And in every case the failure seemed to have been unexpected. It
puzzled me - why could nobody predict it? And it happens over and over
again. A few years ago I was a faithful reader of [The Daily WTF blog](http://thedailywtf.com/). Every day it published failure stories
like the ones I witnessed. So, if we are so smart, why does it keep
happening over and over again?

Because in a software project nobody asks what can go wrong.

Not all risks are the same. Some risks can be assessed and eliminated.
Such as a risk that the existing or planned hardware will not be able to
manage the workload. This kind of risk is calculable. We can do a stress
test, measure the execution time, do basic calculations and determine
not only that we need a new server with more powerful CPU, but how
exactly powerful it needs to be.

Others are harder to predict. How would you assess a risk of your
project manager being a crook and ruining a project?

And, finally, there's a mother of all risks – a highly improbable event,
the Black Swan, as Nassim Nicholas Taleb calls it in his book "[The Black Swan: The Impact of the Highly
Improbable](https://en.wikipedia.org/wiki/The_Black_Swan_%282007_book%29)".
(I would highly recommend it to everyone who wants to learn more about
risks) What, for example, is going to happen to your project if all the
programmers decide to quit at the same time?

Some time ago I worked on a project that employed so called custom rules engines
for performing complex batch calculations on a huge dataset - about a
hundred million rows. We had a few thousand rules defined by business
people, and in order to get a result we needed to apply every rule to
the source dataset. As you can imagine, it was slow. Scanning a hundred
million rows is not fast, especially when you need to do it a thousand
times. So, a strategic decision was made to speed it up. One of our
local geniuses came up with a brilliant, as he thought, idea: instead of
applying a thousand rules hundred thousand times each, we will reformat
the existing rules so that they form one monstrous rule, containing all
thousand, which can be applied to the source dataset in one pass. And so
we did. One thing, though, we didn't take into account: when combined
all together, the rules formed a frankensteinian SQL expression more
than 1,000,000 character long (that's right, more than a million). Yes, it
worked, and the process became reasonably fast. But what was the price
paid?

Imagine that you are a support programmer. You are quite unhappy with
your life, and your job in particular, because you're fed up with those
stupid users and their problems. And on one evening, just as you were
going to go home, you get a call. Apparently, the rules engine failed.
You open the log and what do you see? A million characters long SQL and
at an error message the end, saying that an error happened somewhere in
there. Yep, somewhere in those million chars. You see, that's the way
Oracle works. It tells you that an error has happened and tells which
one (let's say, division by zero), but doesn't tell where exactly within
the given SQL it has happened. So, what are you going to do, step by
step? Don't know about you, but I would start writing a resignation
letter. And I wasn't the only one confused. No one I asked could answer
that question.

You may ask, what does it have to do with risk? There is a direct
connection.<br>
We had certain risk that the system being built couldn't handle the
workload. The amount of that risk __was known__. We could calculate how much time it took to process the
data set, extrapolate it to the given requirements and find out that it
took 10 times more time than was acceptable. We could resolve it by
buying 10 times more powerful server, or cluster of less powerful
servers. In any case, the risk and the cost associated with eliminating
those risks were calculable.

After a strategic decision was made to solve the performance problem by
much more complex rules engine, the risk became __incalculable__. Yes, they
prevented the performance problem, but introduced another and much more
serious: in a case of a single failure the system was going to go down
for undefined time. Because no one would be able to fix it. And the
undefined downtime would mean an unlimited loss for the business,
because in a business world time is always money.

So, what they did is substituted an imminent, but assessable risk, that,
in fact, could be prevented, with a less probable, but potentially much
more severe which that could not be assessed. I don't believe that
solving a minor problem by introducing a much severe one, and hiding a
possibility of a failure under the rug is a proper risk management. In the long term it is never a good strategy.