#devtools::use_package("testthat", type = "Suggests")

#Load rsvd library
library(rsvd)

#Set seed
set.seed(1234)

#Create real random test matrix of dimension m x n with target rank k
  m = 50
  n = 30
  k = 10
  testMat <- matrix(runif(m*k), m, k)
  testMat <- testMat %*% t(testMat)
  testMat <- testMat[,1:n]

#Set p, q
  p=5
  q=2

#Accuray
atol_float64 <- 1e-8


#*************************************************************************************
# dependency
#*************************************************************************************
testthat::test_that("Dependency", {
  testthat::expect_equal(requireNamespace("ggplot2", quietly = TRUE), TRUE)
  testthat::expect_equal(requireNamespace("plyr", quietly = TRUE), TRUE)
  testthat::expect_equal(requireNamespace("scales", quietly = TRUE), TRUE)
  testthat::expect_equal(requireNamespace("grid", quietly = TRUE), TRUE)
})

#*************************************************************************************
# Test 1
#*************************************************************************************

#Deterministic SVD
  svd_out <- svd(testMat)
  #Ak = svd_out$u %*% diag(svd_out$d) %*% t(svd_out$v)
  #print( sum((Ak-test)**2) )

#Randomized SVD k=n
  rsvd_out <- rsvd(testMat, method='standard')
  Ak = rsvd_out$u %*% diag(rsvd_out$d) %*% t(rsvd_out$v)
  testthat::test_that("Randomized SVD k=n", {
    testthat::expect_equal(svd_out$d[1:k], rsvd_out$d[1:k])
    testthat::expect_equal(testMat, Ak)
  })

#Fast randomized SVD k=n
  rsvd_out <- rsvd(testMat, method='fast')
  Ak = rsvd_out$u %*% diag(rsvd_out$d) %*% t(rsvd_out$v)
  testthat::test_that("Fast Randomized SVD k=n", {
    testthat::expect_equal(svd_out$d[1:k], rsvd_out$d[1:k])
    testthat::expect_equal(testMat, Ak)
  })

#Randomized SVD k=k
  rsvd_out <- rsvd(testMat, k=k, method='standard')
  Ak = rsvd_out$u %*% diag(rsvd_out$d) %*% t(rsvd_out$v)
  testthat::test_that("Randomized SVD k=k", {
    testthat::expect_equal(svd_out$d[1:k], rsvd_out$d[1:k])
    testthat::expect_equal(testMat, Ak)
  })

#Fast randomized SVD k=k
  rsvd_out <- rsvd(testMat, k=k, method='fast')
  Ak = rsvd_out$u %*% diag(rsvd_out$d) %*% t(rsvd_out$v)
  testthat::test_that("Fast Randomized SVD k=k", {
    testthat::expect_equal(svd_out$d[1:k], rsvd_out$d[1:k])
    testthat::expect_equal(testMat, Ak)
  })

#Randomized SVD k=k, p=0, q=0
  rsvd_out <- rsvd(testMat, k=k, p=0, q=0, method='standard')
  Ak = rsvd_out$u %*% diag(rsvd_out$d) %*% t(rsvd_out$v)
  testthat::test_that("Randomized SVD k=k, p=0, q=0", {
    testthat::expect_equal(svd_out$d[1:k], rsvd_out$d[1:k])
    testthat::expect_equal(testMat, Ak)
  })

#Fast randomized SVD k=k, p=0, q=0
  rsvd_out <- rsvd(testMat, k=k, p=0, q=0, method='fast')
  Ak = rsvd_out$u %*% diag(rsvd_out$d) %*% t(rsvd_out$v)
  testthat::test_that("Fast Randomized SVD k=n, p=0, q=0", {
    testthat::expect_equal(svd_out$d[1:k], rsvd_out$d[1:k])
    testthat::expect_equal(testMat, Ak)
  })



#*************************************************************************************
# Test 2: testMat.T
#*************************************************************************************

testMat <- t(testMat)
#Deterministic SVD
  svd_out <- svd(testMat)
  #Ak = svd_out$u %*% diag(svd_out$d) %*% t(svd_out$v)
  #print( sum((Ak-test)**2) )

#Randomized SVD k=n
  rsvd_out <- rsvd(testMat, method='standard')
  Ak = rsvd_out$u %*% diag(rsvd_out$d) %*% t(rsvd_out$v)
  testthat::test_that("Randomized SVD k=n", {
    testthat::expect_equal(svd_out$d[1:k], rsvd_out$d[1:k])
    testthat::expect_equal(testMat, Ak)
  })

#Fast randomized SVD k=n
  rsvd_out <- rsvd(testMat, method='fast')
  Ak = rsvd_out$u %*% diag(rsvd_out$d) %*% t(rsvd_out$v)
  testthat::test_that("Fast Randomized SVD k=n", {
    testthat::expect_equal(svd_out$d[1:k], rsvd_out$d[1:k])
    testthat::expect_equal(testMat, Ak)
  })

#Randomized SVD k=k
  rsvd_out <- rsvd(testMat, k=k, method='standard')
  Ak = rsvd_out$u %*% diag(rsvd_out$d) %*% t(rsvd_out$v)
  testthat::test_that("Randomized SVD k=k", {
    testthat::expect_equal(svd_out$d[1:k], rsvd_out$d[1:k])
    testthat::expect_equal(testMat, Ak)
  })

#Fast randomized SVD k=k
  rsvd_out <- rsvd(testMat, k=k, method='fast')
  Ak = rsvd_out$u %*% diag(rsvd_out$d) %*% t(rsvd_out$v)
  testthat::test_that("Fast Randomized SVD k=k", {
    testthat::expect_equal(svd_out$d[1:k], rsvd_out$d[1:k])
    testthat::expect_equal(testMat, Ak)
  })

#Randomized SVD k=k, p=0, q=0
  rsvd_out <- rsvd(testMat, k=k, p=0, q=0, method='standard')
  Ak = rsvd_out$u %*% diag(rsvd_out$d) %*% t(rsvd_out$v)
  testthat::test_that("Randomized SVD k=k, p=0, q=0", {
    testthat::expect_equal(svd_out$d[1:k], rsvd_out$d[1:k])
    testthat::expect_equal(testMat, Ak)
  })

#Fast randomized SVD k=k, p=0, q=0
  rsvd_out <- rsvd(testMat, k=k, p=0, q=0, method='fast')
  Ak = rsvd_out$u %*% diag(rsvd_out$d) %*% t(rsvd_out$v)
  testthat::test_that("Fast Randomized SVD k=n, p=0, q=0", {
    testthat::expect_equal(svd_out$d[1:k], rsvd_out$d[1:k])
    testthat::expect_equal(testMat, Ak)
  })




#*************************************************************************************
# Test 3: complex random test matrix
#*************************************************************************************
  testMat <- matrix(runif(m*k), m, k) + 1i* matrix(runif(m*k), m, k)
  testMat <- testMat %*% H(testMat)
  testMat <- testMat[,1:n]


  #Deterministic SVD
  svd_out <- svd(testMat)
  #Ak = svd_out$u %*% diag(svd_out$d) %*% t(svd_out$v)
  #print( sum((Ak-test)**2) )

  #Randomized SVD k=n
  rsvd_out <- rsvd(testMat, method='standard')
  Ak = rsvd_out$u %*% diag(rsvd_out$d) %*% H(rsvd_out$v)
  testthat::test_that("Randomized SVD k=n", {
    testthat::expect_equal(svd_out$d[1:k], rsvd_out$d[1:k])
    testthat::expect_equal(testMat, Ak)
  })

  #Fast randomized SVD k=n
  rsvd_out <- rsvd(testMat, method='fast')
  Ak = rsvd_out$u %*% diag(rsvd_out$d) %*% H(rsvd_out$v)
  testthat::test_that("Fast Randomized SVD k=n", {
    testthat::expect_equal(svd_out$d[1:k], rsvd_out$d[1:k])
    testthat::expect_equal(testMat, Ak)
  })

  #Randomized SVD k=k
  rsvd_out <- rsvd(testMat, k=k, method='standard')
  Ak = rsvd_out$u %*% diag(rsvd_out$d) %*% H(rsvd_out$v)
  testthat::test_that("Randomized SVD k=k", {
    testthat::expect_equal(svd_out$d[1:k], rsvd_out$d[1:k])
    testthat::expect_equal(testMat, Ak)
  })

  #Fast randomized SVD k=k
  rsvd_out <- rsvd(testMat, k=k, method='fast')
  Ak = rsvd_out$u %*% diag(rsvd_out$d) %*% H(rsvd_out$v)
  testthat::test_that("Fast Randomized SVD k=k", {
    testthat::expect_equal(svd_out$d[1:k], rsvd_out$d[1:k])
    testthat::expect_equal(testMat, Ak)
  })

  #Randomized SVD k=k, p=0, q=0
  rsvd_out <- rsvd(testMat, k=k, p=0, q=0, method='standard')
  Ak = rsvd_out$u %*% diag(rsvd_out$d) %*% H(rsvd_out$v)
  percent_error = 100*norm(testMat - Ak,'2')/norm(Ak,'2')
  testthat::test_that("Randomized SVD k=k, p=0, q=0", {
    testthat::expect_equal(svd_out$d[1:k], rsvd_out$d[1:k])
    testthat::expect_less_than(percent_error, 10)
  })

  #Fast randomized SVD k=k, p=0, q=0
  rsvd_out <- rsvd(testMat, k=k, p=0, q=0, method='fast')
  Ak = rsvd_out$u %*% diag(rsvd_out$d) %*% H(rsvd_out$v)
  percent_error = 100*norm(testMat - Ak,'2')/norm(Ak,'2')

  testthat::test_that("Fast Randomized SVD k=n, p=0, q=0", {
    testthat::expect_equal(svd_out$d[1:k], rsvd_out$d[1:k])
    testthat::expect_less_than(percent_error, 10)
  })




  #*************************************************************************************
  # Test 4: Exceptional cases
  #*************************************************************************************
  testMat <- matrix(runif(m*k), m, k) + 1i* matrix(runif(m*k), m, k)
  testMat <- testMat %*% H(testMat)
  testMat <- testMat[,1:n]

  testMat <- H(testMat)

  #Deterministic SVD
  svd_out <- svd(testMat)

  #Randomized SVD k=n
  k=k
  rsvd_out <- rsvd(testMat, method='standard', k=k, nu=k+2, nv=k+2)
  Ak = rsvd_out$u %*% diag(rsvd_out$d) %*% H(rsvd_out$v)
  testthat::test_that("Randomized SVD k=n", {
    testthat::expect_equal(svd_out$d[1:k], rsvd_out$d[1:k])
    testthat::expect_equal(testMat, Ak)
    })

  #Randomized SVD k=n
  k=k
  rsvd_out <- rsvd(testMat, method='fast', k=k, nu=k+2, nv=k+2)
  Ak = rsvd_out$u %*% diag(rsvd_out$d) %*% H(rsvd_out$v)
  testthat::test_that("Randomized SVD k=n", {
    testthat::expect_equal(svd_out$d[1:k], rsvd_out$d[1:k])
    testthat::expect_equal(testMat, Ak)
  })



  #*************************************************************************************
  # Test 5: Randomized PCA - center = TRUE, scale. = TRUE
  #*************************************************************************************
  testMat <- matrix(runif(m*k), m, k) + 1i* matrix(runif(m*k), m, k)

  #Deterministic PCA
  pca_out <- prcomp(testMat, center = TRUE, scale. = TRUE)

  #Randomized PCA
  rpca_out <- rpca(testMat, k=k, svdalg='rsvd')
  testthat::test_that("rPCA 1", {
    testthat::expect_equal(pca_out$sdev[1:k], rpca_out$sdev[1:k])
  })

  #Randomized PCA
  rpca_out <- rpca(testMat, k=k-5, p=5, q=0, svdalg='rsvd')
  testthat::test_that("rPCA 2", {
    testthat::expect_equal(pca_out$sdev[1:(k-5)], rpca_out$sdev[1:(k-5)])
  })

  #Randomized PCA
  rpca_out <- rpca(testMat, k=k, svdalg='rsvd')
  cum_var = cumsum(rpca_out$sdev**2 / rpca_out$var)
  testthat::test_that("rPCA 3", {
    testthat::expect_equal(cum_var[k], 1)
  })


  #*************************************************************************************
  # Test 6: Randomized PCA - center = T, scale. = F
  #*************************************************************************************
  testMat <- matrix(runif(m*k), m, k) + 1i * matrix(runif(m*k), m, k)

  #Deterministic PCA
  pca_out <- prcomp(testMat, center = TRUE, scale. = FALSE)

  #Randomized PCA
  rpca_out <- rpca(testMat, k=k, svdalg='rsvd', center = TRUE, scale = FALSE)
  testthat::test_that("rPCA 4", {
    testthat::expect_equal(pca_out$sdev[1:k], rpca_out$sdev[1:k])
  })

  #Randomized PCA
  rpca_out <- rpca(testMat, k=k-5, p=5, q=0, svdalg='rsvd', center = TRUE, scale = FALSE)
  testthat::test_that("rPCA 5", {
    testthat::expect_equal(pca_out$sdev[1:(k-5)], rpca_out$sdev[1:(k-5)])
  })

  #Randomized PCA
  rpca_out <- rpca(testMat, k=k, svdalg='rsvd', center = TRUE, scale = FALSE)
  cum_var = cumsum(rpca_out$sdev**2 / rpca_out$var)
  testthat::test_that("rPCA 6", {
    testthat::expect_equal(cum_var[k], 1)
  })

  #*************************************************************************************
  # Test 6: Randomized PCA - Predict complex
  #*************************************************************************************
  testMat <- matrix(runif(m*k), m, k) + 1i * matrix(runif(m*k), m, k)

  #Deterministic PCA
  pca_out <- prcomp(testMat, center = TRUE, scale. = FALSE)

  #Randomized PCA
  rpca_out <- rpca(testMat, k=k, svdalg='rsvd', retx=TRUE, center = TRUE, scale = FALSE)

  testthat::test_that("rPCA Predict 1", {
    testthat::expect_equal(rpca_out$x %*% H(rpca_out$rotation), pca_out$x %*% H(pca_out$rotation))
  })

  #Randomized PCA
  rpca_out <- rpca(testMat, k=k, svdalg='rsvd', retx=FALSE, center = TRUE, scale = FALSE)
  preds <- predict(rpca_out, newdata = testMat)
  testthat::test_that("rPCA Predict 2", {
    testthat::expect_equal(preds %*%  H(rpca_out$rotation), pca_out$x %*% H(pca_out$rotation) )
  })

  #*************************************************************************************
  # Test 6: Randomized PCA - Predict real
  #*************************************************************************************
  testMat <- matrix(runif(m*k), m, k)

  #Deterministic PCA
  pca_out <- prcomp(testMat, center = FALSE, scale. = FALSE)

  #Randomized PCA
  rpca_out <- rpca(testMat, k=k, svdalg='rsvd', retx=TRUE, center = FALSE, scale = FALSE)
  testthat::test_that("rPCA Predict 3", {
    testthat::expect_equal(rpca_out$x %*% H(rpca_out$rotation), pca_out$x %*% H(pca_out$rotation))
  })

  #Randomized PCA
  rpca_out <- rpca(testMat, k=k, svdalg='rsvd', retx=FALSE, center = FALSE, scale = FALSE)
  preds <- predict(rpca_out, newdata = testMat)
  testthat::test_that("rPCA Predict 5", {
    testthat::expect_equal(preds %*%  H(rpca_out$rotation), pca_out$x %*% H(pca_out$rotation) )
  })

  #Deterministic PCA
  pca_out <- prcomp(testMat, center = TRUE, scale. = FALSE)

  #Randomized PCA
  rpca_out <- rpca(testMat, k=k, svdalg='rsvd', retx=TRUE, center = TRUE, scale = FALSE)
  testthat::test_that("rPCA Predict 6", {
    testthat::expect_equal(rpca_out$x %*% H(rpca_out$rotation), pca_out$x %*% H(pca_out$rotation))
  })

  #Randomized PCA
  rpca_out <- rpca(testMat, k=k, svdalg='rsvd', retx=FALSE, center = TRUE, scale = FALSE)
  preds <- predict(rpca_out, newdata = testMat)
  testthat::test_that("rPCA Predict 7", {
    testthat::expect_equal(preds %*%  H(rpca_out$rotation), pca_out$x %*% H(pca_out$rotation) )
  })


  #Deterministic PCA
  pca_out <- prcomp(testMat, center = TRUE, scale. = TRUE)

  #Randomized PCA
  rpca_out <- rpca(testMat, k=k, svdalg='rsvd', retx=TRUE, center = TRUE, scale = TRUE)
  testthat::test_that("rPCA Predict 8", {
    testthat::expect_equal(rpca_out$x %*% H(rpca_out$rotation), pca_out$x %*% H(pca_out$rotation))
  })

  #Randomized PCA
  rpca_out <- rpca(testMat, k=k, svdalg='rsvd', retx=FALSE, center = TRUE, scale = TRUE)
  preds <- predict(rpca_out, newdata = testMat)
  testthat::test_that("rPCA Predict 9", {
    testthat::expect_equal(preds %*%  H(rpca_out$rotation), pca_out$x %*% H(pca_out$rotation) )
  })


  #*************************************************************************************
  # Test 6: Randomized PCA - Reconstruction error - real matrix
  #*************************************************************************************
  testMat <- matrix(runif(m*k), m, k)

  #Randomized PCA
  rpca_out <- rpca(testMat, k=k, svdalg='rsvd', retx=TRUE, center = FALSE, scale = FALSE)
  Re <- rpca_out$x %*% H(rpca_out$rotation) + rpca_out$center
  testthat::test_that("rPCA reconstruction 1", {
    testthat::expect_equal(Re, testMat )
  })

  #Deterministic PCA
  pca_out <- prcomp(testMat, center = TRUE, scale. = FALSE)
  Re <- (pca_out$x %*% H(pca_out$rotation)) + pca_out$center

  rpca_out <- rpca(testMat, k=k, svdalg='rsvd', retx=TRUE, center = TRUE, scale = FALSE)
  Re2 <- rpca_out$x %*% H(rpca_out$rotation) + pca_out$center

  testthat::test_that("rPCA reconstruction 2", {
    testthat::expect_equal(Re, Re2  )
  })


  #Deterministic PCA
  pca_out <- prcomp(testMat, center = TRUE, scale. = TRUE)
  Re <- (pca_out$x %*% H(pca_out$rotation)) + pca_out$center

  rpca_out <- rpca(testMat, k=k, svdalg='rsvd', retx=TRUE, center = TRUE, scale = TRUE)
  Re2 <- rpca_out$x %*% H(rpca_out$rotation) + pca_out$center

  testthat::test_that("rPCA reconstruction 3", {
    testthat::expect_equal(Re, Re2  )
  })

  #*************************************************************************************
  # Test 6: Randomized PCA - Reconstruction error
  #*************************************************************************************
  testMat <- matrix(runif(m*k), m, k) + 1i * matrix(runif(m*k), m, k)

  #Deterministic PCA
  pca_out <- prcomp(testMat, center = FALSE, scale. = FALSE)
  Re <- (pca_out$x %*% H(pca_out$rotation)) + pca_out$center

  #Randomized PCA
  rpca_out <- rpca(testMat, k=k, svdalg='rsvd', retx=TRUE, center = FALSE, scale = FALSE)
  Re2 <- rpca_out$x %*% H(rpca_out$rotation)
  testthat::test_that("rPCA reconstruction 4", {
      testthat::expect_equal(Re, Re2 )
  })


  #*************************************************************************************
  # Test 7: Randomized PCA - Transposed input matrix
  #*************************************************************************************

  testMat <- H(testMat)

  #Deterministic PCA
  pca_out <- prcomp(testMat, center = TRUE, scale. = TRUE)

  #Randomized PCA
  rpca_out <- rpca(testMat, k=k, svdalg='rsvd')
  testthat::test_that("Randomized SVD k=n", {
    testthat::expect_equal(pca_out$sdev[1:k], rpca_out$sdev[1:k])
  })

