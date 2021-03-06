test_that("default assignment", {
  x0 <- c(0.350, 0.992, 0.112, 0.735, 0.598, 0.178, 0.195, 0.766, 0.816, 0.574)
  x <- assign_labels(x0, "runs")
  x1 <- remove_labels(x)

  expect_false(inherits(x, "labelled")) # Hmisc::label produces this class
  expect_equal(attr(x, "label"), "runs")

  expect_error(assign_labels(x, NULL))
  expect_error(assign_labels(x, 1:2))

  expect_equal(x0, x1)
  expect_true(is.null(attr(x1, "label")))
})

test_that("data.frame assignment", {
  x0 <- head(iris)
  x <- assign_labels(x0, Sepal.Length = "a", Species = "b")

  exp <- data.frame(
    column = colnames(x0),
    label = c("a", NA, NA, NA, "b"),
    stringsAsFactors = FALSE
  )

  exp0 <- remove_labels(x, "Species")
  exp1 <- remove_labels(x, c("Sepal.Length", "Species"))
  # removes all columns -- shouldn't throw an error
  exp2 <- remove_labels(x)

  expect_equal(get_labels(x), exp)
  expect_error(assign_labels(x0, a = "x", b = "y", `1` = 2),
               "Columns not found: a, b, 1")

  expect_error(assign_labels(x0, NULL))

  expect_true(is.null(attr(exp0[["Species"]], "label")))
  expect_equal(attr(exp0[["Sepal.Length"]], "label"), "a")
  expect_equal(x0, exp2)
  expect_equal(exp1, exp2)
})

test_that("data.frame assign with data.frame", {
  op <- options()
  options(stringsAsFactors = FALSE)

  x <- assign_labels(iris, Sepal.Length = "a", Species = "b")

  labels <- data.frame(
    name = c("Sepal.Length", "Species"),
    label = c("a", "b"),
    stringsAsFactors = FALSE
  )

  y <- assign_labels(iris, labels)

  exp <- data.frame(
    column = colnames(iris),
    label = c("a", NA, NA, NA, "b"),
    stringsAsFactors = FALSE
  )

  expect_equal(get_labels(y), get_labels(y))

  bad_labels <- data.frame(
    v1 = c("a", "b", 1),
    v2 = c("x", "y", 2),
    stringsAsFactors = FALSE
  )
  expect_error(assign_labels(iris, bad_labels),
               "Columns not found: a, b, 1")

  options(op)
})
