test_that("eval_named_chunk()", {
  temp_rmd <- mark_temp(".rmd")

  text <- '
  ```{r not this label}
  print("that is wrong")
  ```

  ```{r hello label}
  text <- "hello, world"
  print(text)
  print(TRUE)
  ```

  ```{r another label}
  warning("wrong label")
  ```
  '

  writeLines(text, con = temp_rmd)
  expect_output(
    eval_named_chunk(temp_rmd, "hello label"),
    '\\[1\\] "hello, world"\n\\[1\\] TRUE'
  )
  file.remove(temp_rmd)
})

test_that("Rscript", {
  # skip_if_not(.Platform$OS.type == "windows")

  x <- test_path("scripts", "rscript-test.R")
  rscript(x, "vanilla", stdout = FALSE, stderr = FALSE)
  expect_false("dplyr" %in% search())

  rscript(x, stdout = FALSE, stderr = FALSE)
  expect_false("dplyr" %in% search())

  e <- source_to_env(x)
  expect_s3_class(e, c("source_env", "environment"))
  expect_identical(e$a_litte_note, "You're doing okay")
  expect_s3_class(e$out, "tbl_df")
})
