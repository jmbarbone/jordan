test_that("NA_at() and NA_if() work as expected", {
  x <- -1:3

  # replaces first two
  at <- 1:2
  expect_equal(NA_at(-1:3, 1:2), c(NA, NA, 1:3))

  # replaces all around 2nd
  .if <- c(TRUE, FALSE, rep(TRUE, 3))
  expect_equal(NA_if(x, .if), c(NA, 0, NA, NA, NA))

  # replaces those above 0
  foo <- function(x) x > 0
  expect_equal(NA_if(-1:3, foo), c(-1, 0, NA, NA, NA))

  # y cannot be longer than x
  expect_error(NA_at(x, 1:10))
})

test_that("NA_in() and NA_at() work as expected", {
  x <- c("a", "b", "c", "b", "d")

  # replaced 'b' or 'd'
  at <- c("b", "d")
  expect_equal(NA_in(x, at), c("a", NA, "c", NA, NA))

  # can accept function
  foo <- function(x, d = FALSE) {
    x <- sort(x, decreasing = d)
    x <- unique(x)
    x[1:2]
  }

  expect_equal(NA_in(x, foo),  c(NA , NA , 'c', NA , 'd'))
  expect_equal(NA_out(x, foo), c('a', 'b', NA , 'b', NA ))
  expect_equal(NA_in(x, foo,  d = TRUE), c('a', 'b', NA , 'b', NA ))
  expect_equal(NA_out(x, foo, d = TRUE), c(NA , NA , 'c', NA , 'd'))

  # No error if y is longer
  expect_error(NA_in(x, letters), NA)
  expect_error(NA_out(x, letters), NA)
})

