test_that("detailed tourism datasets load with valid filtered records", {
  data("tourism_reason", package = "ecotourism")
  data("tourism_activity", package = "ecotourism")

  expect_s3_class(tourism_reason, "tbl_df")
  expect_named(
    tourism_reason,
    c("year", "month", "sa2_code_tra", "stop_reason", "trips", "n_sample")
  )
  expect_true(all(tourism_reason$trips != 0))
  expect_true(all(tourism_reason$n_sample != 0))

  expect_s3_class(tourism_activity, "tbl_df")
  expect_named(
    tourism_activity,
    c("year", "month", "sa2_code_tra", "stop_activity", "trips", "n_sample")
  )
  expect_true(all(tourism_activity$trips != 0))
  expect_true(all(tourism_activity$n_sample != 0))
})

test_that("tourism category codes have names", {
  data("tourism_reason", package = "ecotourism")
  data("tourism_reason_name", package = "ecotourism")
  data("tourism_activity", package = "ecotourism")
  data("tourism_activity_name", package = "ecotourism")

  expect_true(
    all(unique(tourism_reason$stop_reason) %in% tourism_reason_name$stop_reason)
  )
  expect_true(
    all(
      unique(tourism_activity$stop_activity) %in%
        tourism_activity_name$stop_activity
    )
  )
})
