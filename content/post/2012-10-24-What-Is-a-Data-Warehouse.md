---
title: "What is a data warehouse?"
date: 2012-10-24
author: Sergey Stadnik
category: technology
slug: what-is-data-warehouse
Summary: What data warehouses are, how they are different from OLTP databases, and why we may want to use them.
---

<div class="figure align-right">
    <img src="{filename}/images/2012-10-24_data_boxes.jpg" alt="Data warehouse boxes">
</div>

All database applications can be divided into 2 classes: OLTP and data
warehouses. OLTP stands for Online Transactions Processing. It's easy to explain
the difference between them by an example.

Imagine yourself buying groceries at your local supermarket. When you
are done filling your shopping basket and finally come to checkout,
here’s what happens:

-   A shopping assistant at the checkout register picks up your first
    item and scans its barcode. The computer built into the register
    turns the barcode into a series of characters and digits and queries
    the store’s database for the item’s description, price and picture.
    Then it adds the item into your virtual shopping cart.

-   You reach for your next item and all of those steps happen again: a
    few queries sent to the database, a few tables updated. And then
    again and again, until your basket is empty.

-   You swipe your credit card. The shop’s system sends a request to the
    credit card processing centre. It checks that you card is valid and
    that you are not over your credit limit. Then it asks you for your
    pin code, verifies it, and if all the checks are successful,
    withdraws the money.

-   Then the groceries you bought are marked as sold in the inventory
    control system. A receipt is printed, and the virtual shopping
    basket is cleared. That’s it. Thank you for shopping with us.

It probably took you less than 5 minutes to go through the register. But
the number of database queries and updates it resulted in was likely in
hundreds. Now multiply that by the number of checkout registers in the
shop, and you’ll get the picture. Checkout register is a typical OLTP
system.

OLTP applications are characterized by large volume of atomic database
transactions: retrieve 1 row from a database table here, 3 there, insert
a few lines into a third table or update a row of yet another table.

Most of OLTP-type applications are interactive: you press a button and
expect the system to respond within a few seconds at most. That presents
a challenge if the application is a multi-user system with hundreds of
users working at the same time. It is not uncommon for an OLTP system to
crunch tens of thousands, even millions of database operations per
minute. And because of that these operations need to be extremely fast.

Therefore OLTP systems are specifically engineered for a low latency in
conditions of high volume of elementary database operations.

Now imagine that at the end of the financial year the COO of the
supermarket chain requires a detailed sales report. He wants to know
which products were selling faster comparing to the previous 10 years
with a breakdown by geographical areas. He also wants to know the
correlation between the increased prices and sales volumes aggregated by
product categories, and so on. Every business requires hundreds and
hundreds of such reports, and not just at the end of the financial year
but sometimes every day. Financial departments, sales, marketing, and
management – they all want to know how the business is doing. In fact,
there is a special buzzword for that kind of reporting – “Business
Intelligence”. Another buzzword “Data mining” means “Looking for answers
for which we don’t know questions yet”. Data mining looks for trends
within the data and tries to find correlations to the known parameters.
An example of a data mining query is “Find out if the sales volume
changed within the last year and what else is changed that could explain
that”.

Business Intelligence and Data Mining reports tend to be highly complex.
Most of times they require querying data across very large datasets,
such as all sales over the last 10 years,  then aggregating it, then
calculating summaries, averages, correlations and so on. These are very
different types of operations from which OLTP systems are designed for.
And that is why running them against OLTP databases is usually not a
good idea. This is what data warehouses are for.

Data warehouses are database systems optimised for complex database
queries over large data sets.  They are predominantly used for Business
Intelligence and Data Mining reporting. Within large corporate data
warehouses it is common to have “sections” designed for specific
purpose, for example for particular types of financial reports. These
sections along with their business intelligence logic are called
Datamarts.

Data warehouses usually source data from multiple systems. For example,
sales data, financial data, inventory, vendors, etc. may come from
different geographically distributed platforms which otherwise don’t
talk to each other. Having all this information in one data warehouse
enables business users to get reports such as profits on sales of
certain goods per supplier.
