---
Title: How to set up Git on Windows
Date: 2015-11-03
Author: Sergey Stadnik
categories: ["technology"]
---

I finally found a way to set up Git on Windows in a way that it isn't painful to use. Here's how to do that:


1. Uninstall all installations of git, TortoiseGit, etc.
1. Install [Git Extensions](https://gitextensions.github.io/). The easiest way to do that is via Chocolatey package manager:
    1. Install [Chocolatey](https://chocolatey.org/)
    1. Install [Git Extension package](https://chocolatey.org/packages/gitextensions) package.
1. Install [Git Credentials Manager for Windows](https://github.com/Microsoft/Git-Credential-Manager-for-Windows)

That's it.

Git Extensions come with a handy fully-functional UI.

![Git Exstensions User Interface](/images/2015-11-03_git_extensions.png)

And Git Credentials Manager securely stores your git passwords so that you don't need to re-enter them every single time.