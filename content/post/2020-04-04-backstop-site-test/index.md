---
Title: 'Introducing backstop-site-test - a visual regression checker for static sites'
Date: 2020-04-04
Author: Sergey Stadnik
categories: ['technology']
Tags: []
Slug: introducing-backstop-site-test
Description: Check your entire site for visual regressions and detect problems before you push it to production.
Twitter: https://twitter.com/stadniks/status/1246339233641426945
---

{{<responsive-figure src="feature-film-ruler.jpg" width="640" alt="Person with blue plastic ruler on mouth" caption="Photo by " attr="Linus Strandholm on Scopio" attrlink="https://scop.io/collections/vendors?q=Linus+Strandholm">}}

This site is built with [Hugo static site generator](https://gohugo.io/). Being a static site, it doesn't have a fancy back-end engine. No database either. Nothing breaks if left alone.

Still, Hugo team releases new versions from time to time. They add new features, fix some bugs and add new ones. I don't upgrade to every new version. But occasionally I want to upgrade.

However, every time I do something breaks. Most often the thing that breaks is not on the front page, it somewhere else deep inside the site.

Time over time again I would upgrade the site and spin it up in a local environment. I would click around it, and everything would look ok. I'd push it to production. Then, days later, I would find a bug that affects quite a few pages. Because it is already in production, I would rush to fix it in the middle of the night till 3 am.

Having been through that a few time, I asked myself: can I do that better? Can I somehow test the entire site for regression and detect problems **before** I push the site into production?

I rolled up my sleeves and made a thing.

Say hello to [backstop-site-test](https://github.com/ozmoroz/backstop-site-test).

<!--more-->

It is a visual regression tool for static sites. It is a very thin wrapper around [BackstopJS](https://github.com/garris/BackstopJS), an excellent visual regression testing framework.

Here's how it fits into a site upgrade workflow:

- Run the tool before you make a change. It parses a site map into a list off all the site's pages and takes reference screenshots of all the pages.
- Then you do the change.
- After the change, run the tool again. It takes new screenshots, compares them to the reference ones and shows you the difference.

I used it on this site when I did the last upgrade a few days ago. Thanks to it, I found a few broken elements across multiple pages I would have missed.

I hope it will be useful not just for me. It is still an early version but it works. If you find a bug, raise a GitHub issue, or better, fix it and send me a pull request.
