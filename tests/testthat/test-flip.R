test_that("flip.default", {
  expect_equal(flip(letters), letters[26:1])
  x <- set_names0(1:5, letters[1:5])
  expect_named(flip(x))
  expect_equal(names(flip(x)), letters[5:1])
})

test_that("flip.data.frame", {
  res1 <- iris[6:1, ]
  res2 <- res1
  rownames(res1) <- NULL
  iris2 <- res1
  rownames(iris2) <- letters[1:6]
  res3 <- iris2[6:1, ]

  expect_equal(flip(head(iris)), res1)
  expect_equal(flip(head(iris), keep_rownames = TRUE), res2)
  expect_equal(flip(iris2), res3)
  expect_equal(flip(iris2, keep_rownames = TRUE), res3)
})

test_that("flip.matrix", {
  mat <- matrix(1:25, ncol = 5)
  res1 <- mat[5:1, ]
  expect_equal(flip(mat), res1)

  res2 <- mat[, 5:1]
  expect_equal(flip(mat, by_row = FALSE), res2)

  mat2 <- mat
  dimnames(mat2) <- list(letters[1:5])
  res3 <- mat2[5:1, ]
  expect_equal(flip(mat2), res3)
})
