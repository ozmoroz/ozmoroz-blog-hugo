---
Title: How to get size of all tables in an Oracle database schema
slug: how-to-get-size-of-all-tables-in-oracle
Date: 2013-08-27
categories: ["technology"]
Tags: [oracle]
Author: Sergey Stadnik
Summary: An SQL script to get size of all tables in an Oracle database schema.
aliases:
  - /2013/08/how-to-get-size-of-all-tables-in-oracle.html
---

If you ever wanted to know how what's taking space in an Oracle database, or how large is the table you're working on, here's a script which answers these questions. It shows the size of all the database objects large than 10 Mb in a particular database schema.

The following columns are returned:

 * Owner schema.
 * Object name and type (INDEX, TABLE, etc.).
 * Name of the table this object is associated with. E.g. indexes are associated with their parent tables.
 * Database space occupied by the object in megabytes.
 * Tablespace this object is in.
 * Number of extents allocated for the object.
 * Size of the initial extent in bytes.
 * Total database size occupied by the parent table. E.g. for indexes it will be the size of the parent \* table plus sizes of all the indexes on that table.

 {{<gist ozmoroz 47367399d7ca0b4b7262aa3a039b778c>}}

This script is based on the [Stackoverflow.com discussion](http://stackoverflow.com/questions/264914/how-do-i-calculate-tables-size-in-oracle).
