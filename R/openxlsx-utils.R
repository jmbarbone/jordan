#' Wrappers for openxlsx pacakge functions
#'
#' Add data to sheet
#'
#' A wrapper function to use within the openxlsx workbook building.
#' This adds additional functionality to override within the function and provude an output that can be piped.
#'
#' @details These should be applied to a string starting with [openxlsx::createWorkbook()] then piped through with the functions below.
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

#' Add style to a sheet
#'
#' A wrapper funcion
#'

# wb_add_style <- function(wb, sheetname, style, rows = NULL, cols = NULL) {
#   openxlsx::addStyle(wb = wb,
#                      sheet = sheetname,
#                      style = style,
#                      )
#   invisible(wb)
# }
#
# addStyle(wb = wb, sheet = sheet, style = createStyle(numFmt = "#,##0.00"), rows = 2:6, cols = 2)
