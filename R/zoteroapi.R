#' Query the Zotero API
#'
#' @import httr plyr XML
#' @param type Type of account. One of users or groups
#' @param id A Zotero user or group ID.
#' @param itemkey An item key. The thing at the end of e.g.,
#'    ...items/collectionKey/98WBDEFI/itemKey/696NN26F
#' @param q Query search terms. If you specify an itemkey, you can't also
#'    query for something.
#' @param key The Zotero API key. Either pass in to the function, or store in
#'    your .Rprofile file like options(ZoteroKey = "<your key>").
#' @export
#' @examples \dontrun{
#' # Get a single item using itemkey
#' zotero_items(id=24101, itemkey='696NN26F')
#'
#' # Get many items
#' zotero_items(id=24101)
#'
#' # Search
#' zotero_items(id=24101, q='altmetrics')
#' }
zotero_items <- function(type='users', id, itemkey=NULL, q=NULL, qmode="titleCreatorYear", key=NULL, format='atom', content="json") {
  if(is.null(key))
    key = getOption("ZoteroKey", stop("need an API key for Zotero"))

  if(is.null(itemkey)){
    url <- sprintf('https://api.zotero.org/%s/%s/items', type, id)
    args <- compact(list(key=key, q=q, qmode=qmode, format=format, content=content))
  } else {
    url <- sprintf('https://api.zotero.org/%s/%s/items/%s', type, id, itemkey)
    args <- compact(list(key=key, format=format, content=content))
  }
  content(GET(url, query=args, config=c(verbose(), add_headers("Zotero-API-Version" = 2))), as="text")#,
}

# Retrieve default format for type
zotero_get <- function(type='journalArticle', id, key=NULL, format='atom', content="json") {

  if(is.null(key))
    key = getOption("ZoteroKey", stop("need an API key for Zotero"))

  url <- sprintf('https://api.zotero.org/items/new?itemType=%s', type)
  content(GET(url, query = compact(list(key=key, format=format, content=content)),  config=c(verbose(), add_headers("Zotero-API-Version" = 2))), as="text")
}
