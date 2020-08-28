#' Git filter repo
#'
#' Filters git repository
#'
#' @param paths A character vector of exact paths (files or directories) to
#'   include in filtered history
#' @param invert_paths Logical, invert the selection of files from the specified
#'   paths options (i.e., only select files matching none of those options)
#' @param force Logical, if TRUE will force the filtering
#' @param create_local_copy Logical, if TRUE will create a local copy of the
#'   folder just in case.
#'
#' @export

git_filter_repo <- function() {

}


#' Git filter repo directories
#'
#' Filters a git repository by directories
#'
#' @param directories A character vector of directories
#' @param force Logical, if `TRUE` forces the rewriting
#' @param copy_local_project Logical, if `TRUE` copies local project

git_filter_repo_dir <- function() {

}

git_filter_repo_analyze <- function() {
  system("git filter-repo --analyze")
}
