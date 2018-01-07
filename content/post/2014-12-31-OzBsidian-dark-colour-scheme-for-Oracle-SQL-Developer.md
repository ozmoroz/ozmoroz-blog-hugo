---
Title: OzBsidian colour scheme for Oracle SQL Developer
slug: ozbsidian-dark-colour-scheme-for-oracle
Date: 2014-12-31
categories: ["technology"]
Tags: [oracle]
Author: Sergey Stadnik
aliases:
  - /2014/12/ozbsidian-dark-colour-scheme-for-oracle.html
---

This is a spinoff of Obsidian colour scheme for Oracle SQL Developer. It is based on [Obsidian Eclipse colour scheme by Morinar](http://eclipsecolorthemes.org/?view=theme&id=21).

![OzBsidian colour shceme](/images/2014-12-31_ozbsidian-sqldev_1.png)

Unfortunately Oracle doesn't make it easy to import a new colour scheme into SQL Developer, thus a little bit of hacking is required.

- Close SQL Developer. This is important. If you modify the scheme file while SQL Developer is open, your changes won't be saved.

- Locate file `dtcache.xml` in the SQL Developer's settings directory. On my system it is located in directory `C:\Users\sergey\AppData\Roaming\SQL Developer\system4.0.3.16.84\o.ide.12.1.3.2.41.140908.1359`

- Locate `<schemeMap>` tag inside dtcache.xml file. Insert the content of [`ozbsidian-scheme.xml`](https://raw.githubusercontent.com/ozmoroz/ozbsidian-sqldeveloper/master/ozbsidian-scheme.xml) file inside `<schemeMap>` alongside the other colour schemes. Be careful not to break the XML.

![Insert the contents of ozbsidian-scheme.xml after opening schemeMap tag](/images/ozbzidian_insert_here.png)

- Launch SQL Developer. Navigate to menu Tools->Preferences, then select item Code Editor -> PL/SQL Syntax Colours in the left pane.

- Select "OzBsidian" in the "Scheme" drop down list on the top.

![SQL Developer Settings](/images/2014-12-31_ozbsidian-sqldev_2.png)

The colours are mostly match Obsidian scheme, although not exactly. For instance, the background is a bit darker. Hence the name is OzBsidian to differentiate it from the original scheme.

You can download the colour scheme with the installation instruction from [my GitHub account](https://github.com/ozmoroz/ozbsidian-sqldeveloper).

Enjoy!