# RZotero

Is a set or routines for interacting with a [Zotero](http://www.zotero.org/)
library via the Zotero API. I love Zotero, but it lacks some key features.
Hence I was interested to see if these could achieve some of the things I was after in R.

Note, this material is in development and not currently working, so I do not recommend using it, at this stage.

## Zotero Wish List

Here are some of the features I would like:

1. Find and replace function
1. Ability to automatically clean journal names, according to a list of journal name substitutions
2. Ability to modify the author list
4. Ability to find missing DOIs
3. Ability to retrieve missing abstracts based on DOI
5. Ability to delete many (all) tags (i had hundreds)
5. Ability to analyse data from my library in R.
6. Fix broken pdf links: Remove links in Zotero when pdf deleted, and remove pdfs when zotero item deleted
7. Change dx.doi.org to doi.org (now preffered)

The best thing about Zotero is that it's open source and free. The software is maintained by a community of developers who give their time for free, and are actively working on improving it. However, there is also limited resources and a long queue of [feature requests](https://forums.zotero.org/7):

<blockquote class="twitter-tweet"><p><a href="https://twitter.com/adaptive_plant">@adaptive_plant</a> <a href="https://twitter.com/_inundata">@_inundata</a> one thing <a href="https://twitter.com/zotero">@zotero</a> does not lack is requests for features... much more helpful would be patches to 100+ tickets</p>&mdash; adam.smith (@adam42smith) <a href="https://twitter.com/adam42smith/statuses/325407488642011136">April 20, 2013</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

# Accessing Zotero via server API

The best way of interacting with your Zotero library is to write some code which connects to Zotero's [server](http://www.zotero.org/support/dev/server_api/) or [Javascript](http://www.zotero.org/support/dev/client_coding/javascript_api) API.

To access the API you'll need to set up API keys and save these in your
Rpofile, e.g.

```
# Zotero
options(ZoteroKey ="XXXXXX")
options(ZoteroID ="XXXXX")
```



```
library(plyr)
library(XML)
library(httr)
library(rjson)
source('R/zoteroapi.R')

# search for items
out <- zotero_items(id=options("ZoteroID")[[1]], q='Falster')
# Parse output
x <- xmlToList(out)

# return default for item type

out <- zotero_get("journalArticle")
```
