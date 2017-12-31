---
Title: Show information about Oracle sessions
slug: show-oracle-sessions
Date: 2015-01-20
Category: technology
Tags: [oracle]
Author: Sergey Stadnik
Summary: An SQL script which shows information about Oracle sessions.
---

Here is a small script which shows information about running Oracle sessions. You can use commented lines to filter by an Oracle instance (in case you have a RAC), OS user, session ID, process ID or an application name.

 {% include_code show_sessions.sql lang:plpgsql %}
