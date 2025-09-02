test_that("glowworms dataset loads and has expected structure", {
  data("glowworms", package = "ecotourism")

  expect_s3_class(glowworms, "tbl_df")
  expect_true(all(c("sci_name", "obs_lat", "obs_lon", "month") %in% names(glowworms)))
  expect_gt(nrow(glowworms), 0)
})
