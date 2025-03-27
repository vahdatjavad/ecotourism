test_that("cuttlefish data loads correctly", {
  expect_true(exists(data(cuttlefish)))
  expect_s3_class(cuttlefish, "data.frame")
})


