test_that("oz_sa2 has the documented spatial structure", {
  skip_if_not_installed("sf")
  data("oz_sa2", package = "ecotourism")

  expect_s3_class(oz_sa2, "sf")
  expect_named(oz_sa2, c("sa2_code_tra", "lat", "lon", "geometry"))
  expect_equal(nrow(oz_sa2), 2350)
  expect_false(anyDuplicated(oz_sa2$sa2_code_tra) > 0)
  expect_true(all(is.finite(oz_sa2$lat)))
  expect_true(all(is.finite(oz_sa2$lon)))
  expect_equal(sf::st_crs(oz_sa2)$epsg, 7844)
  expect_true(all(sf::st_is_valid(oz_sa2)))
})

test_that("oz_sa2 covers detailed tourism dataset SA2 codes", {
  data("oz_sa2", package = "ecotourism")
  data("tourism_reason", package = "ecotourism")
  data("tourism_activity", package = "ecotourism")

  expect_true(
    all(unique(tourism_reason$sa2_code_tra) %in% oz_sa2$sa2_code_tra)
  )
  expect_true(
    all(unique(tourism_activity$sa2_code_tra) %in% oz_sa2$sa2_code_tra)
  )
})
