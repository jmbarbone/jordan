#' Wrappers for openxlsx pacakge functions
#'
#' Add data to sheet
#'
#' A wrapper function to use within the openxlsx workbook building.
#' This adds additional functionality to override within the function and provude an output that can be piped.
#'
#' @details
#' These should be applied to a string starting with [openxlsx::createWorkbook()] then piped through with the functions below.
#'
#' @note
#' From author.  The `openxlsx` package is incredible, and as a constant users, I've found somet issues that don't work with my specific workflows.
#' These extensions allow for creating a workbook and piping it along to add data and eventually save.
#' This is a bit more intuitive than the current implementation which
#'
#' @param wb A Workbook object to attach the new worksheet and table
#' @param data A dataframe.
#' @param sheetname The worksheet to write to. Can be the worksheet index or name.
#' @param tableStyle Any excel table style name or "none".
#' @param bandedRows Logical. If TRUE, rows are colour banded
#' @param bandedCols Logical. If TRUE, the columns are colour banded
#' @param ... Additional arguments passed to openxlsx::writeDataTable that are not already listed
#' @param override Logical.  If TRUE, will delete the sheetname (if present)
#'
#' @export
#'
#' @seealso
#' [openxlsx:]

add_data_sheet <- function(wb, data, sheetname,
                           tableStyle = "TableStyleLight8", bandedRows = TRUE, bandedCols = TRUE, ...,
                           override = TRUE)
{
  require_namespace("openxlsx")

  if(override && sheetname %in% wb$sheet_names) openxlsx::removeWorksheet(wb, sheetname)

  openxlsx::addWorksheet(wb, sheetname)
  openxlsx::writeDataTable(wb, sheetname, x = data,
                           tableStyle = tableStyle,
                           bandedRows = bandedRows,
                           bandedCols = bandedCols,
                           ...)
  invisible(wb)
}

#' Add image to sheet
#'
#' A wrapper function to..
#'
#' @param wb A Workbook object to attach the new worksheet and table
#' @param file An image file. Valid file types are: jpeg, png, bmp
#' @param sheetname The worksheet to write to. Can be the worksheet index or name.
#' @param ... Additional arguments passed to openxlsx::insertImage
#' @param override Logical.  If TRUE, will delete the sheetname (if present)
#'
#' @export

add_image_sheet <- function(wb, file, sheetname, ..., override = TRUE)
{
  require_namespace("openxlsx")

  if(override && sheetname %in% wb$sheet_names) openxlsx::removeWorksheet(wb, sheetname)

  openxlsx::addWorksheet(wb, sheetname)
  openxlsx::insertImage(wb, sheetname, file = file, ...)
  invisible(wb)
}


create_workbook() %>%
  add_data_sheet(iris, "iris") %>%
  set_workbook_options()

## add attribute

create_workbook <- function() {
  wb <- openxlsx::createWorkbook()
  mywb <- setClass("mywb", contains = "Workbook", representation = representation(opts = "list"))
  new("mywb")
  wb <- as(wb, "workbook")
  wb@opts <- openxlsx_opts
  slot(wb, "opts") <- openxlsx_opts
  invisible(wb)
}
wb <- openxlsx::createWorkbook()
getSlots("workbook")
wb$this <- "?"

create_workbook()

set_workbook_options <- function(wb, ...) {
  vals <- list(...)
  opts <- names(vals)
  for(i in seq_along(opts)) {
    openxlsx_opts[opts[i]] <- vals[i]
  }
  wb
}

wb <- create_workbook()
class(wb)
xlsxopts(create_workbook(), "header")

# Gets value
xlsxopts <- function(wb, x) {
  UseMethod("xlsxopts", x)
}

xlsxopts.default <- function(wb, x) {
  stop("Must be a Workbook", call. = FALSE)
}

xlsxopts.openxlsx.Workbook <- function(wb, x) {
  ats <- attr(wb, "opts")
  ats[[which(ats == x)]]
}

#' @export
# List of all values

options('openxlsx' = list(
  globalOverwrite = FALSE,
  overwriteDataSheet = TRUE,
  overwriteFile = FALSE,
  gridExpand = TRUE,
  gridLines = TRUE,
  tabColour = NULL,
  zoom = 100,
  header = NULL,
  footer = NULL,
  evenHeader = NULL,
  evenFooter = NULL,


  colNames = TRUE,
  rowNames = TRUE,

  tableName = NULL,
  tableStyle = "TableStyleLight8",
  bandedRows = TRUE,
  bandedCols = TRUE,

  headerStyle = NULL,
  withFilter = TRUE,
  keepNA = FALSE,
  na.string = NULL,
  sep = ", ",
  stack = FALSE,
  firstColumn = FALSE,
  lastColumn = FALSE,

  NULL
))
