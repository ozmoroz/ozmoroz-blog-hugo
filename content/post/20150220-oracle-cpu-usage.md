---
Title: How to identify Oracle sessions consuming CPU time
Date: 2015-02-20
Author: Sergey Stadnik
categories: ["technology"]
Tags: [oracle]
Slug: oracle-cpu-usage
aliases:
  - /2015/02/oracle-cpu-usage.html
---

Identifying sessions consuming CPU time is a common task in Oracle performance tuning. However, as simple as it sounds, it is not that straightforward. Oracle recommends using [Enterprise Manager](http://www.oracle.com/technetwork/oem/grid-control/documentation/oem-091904.html) or [Automatic Workload Repository](http://oracle-base.com/articles/10g/automatic-workload-repository-10g.php) for that. The problem is that in real-life situations Enterprise Manager is often not installed, or you may not have access to it. You may not also have necessary privileges to run AWS. Besides, running AWS reports for such a simple task sounds like overkill.

Oracle database reports each session's CPU usage in `V$SYSSTAT` performance view. However, it only indicates a total CPU time used since the session's log in. And because different sessions may have logged in at different times, you can't compare the reported figures as they are. After all, it is obvious that a session logged in a few days ago cumulatively may have used more CPU time than a session started just a few minutes ago.

However, there is a workaround.
<!-- more -->

I wrote a script which accurately measures CPU time consumed by Oracle sessions within the given period (30 seconds by default). It works by taking a snapshot of CPU stats at the beginning of the interval, and then another one at the end. It then calculates the CPU time used during the interval and presents the sorted list.

It prints the result into dbms_output in the following CSV format:
`sid, serial#, cpu_seconds`

Once you identified the top CPU consuming sessions, you can use a script like this one to find out what they are doing.

You can <a href="https://raw.githubusercontent.com/ozmoroz/oracle-scripts/master/cpu_usage.sql" download="cpu_usage.sql" target="_blank">download cpu_usage.sql script</a> from [my GitHub page](https://github.com/ozmoroz/oracle-scripts).