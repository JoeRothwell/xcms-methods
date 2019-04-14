mass <- 1.9958 # mass difference for S34 isotope
tolerance <- 0.001
mzmin <- mass - tolerance
mzmax <- mass + tolerance

mat <- matrix(NA, 8, 4)
colnames(mat) <- c("mzmin", "mzmax", "intmin", "intmax")
mat[1, ] <- c(mzmin , mzmax, 1.0, 150)
mat[2, ] <- c(mzmin, mzmax, 0.01, 200)
mat[3, ] <- c(mzmin, mzmax, 0.001, 200)
mat[4, ] <- c(mzmin, mzmax, 0.0001, 200)
mat[5, ] <- c(mzmin, mzmax, 0.00001, 200)
mat[6, ] <- c(mzmin, mzmax, 0.000001, 200)
mat[7, ] <- c(mzmin, mzmax, 0.0000001, 200)
mat[8, ] <- c(mzmin, mzmax, 0.00000001, 200) 

mat2 <- matrix(NA, 8, 4);
colnames(mat2) <- c("mzmin", "mzmax", "intmin", "intmax")
mat2[1, ] <- c(1.995 , 1.999, 1.0, 150)
mat2[2, ] <- c(1.995 , 1.999, 0.01, 200)
mat2[3, ] <- c(1.995 , 1.999, 0.001, 200)
mat2[4, ] <- c(1.995 , 1.999, 0.0001, 200)
mat2[5, ] <- c(1.995 , 1.999, 0.00001, 200)
mat2[6, ] <- c(1.995 , 1.999, 0.000001, 200)
mat2[7, ] <- c(1.995 , 1.999, 0.0000001, 200)
mat2[8, ] <- c(1.995 , 1.999, 0.00000001, 200)  


mat3 <- matrix(NA, 8, 4);
colnames(mat3) <- c("mzmin", "mzmax", "intmin", "intmax")
mat3[1, ] <- c(1.995 , 1.999, 1, 0)
mat3[2, ] <- c(1.995 , 1.999, 1, 0)
mat3[3, ] <- c(1.995 , 1.999, 1, 0)
mat3[4, ] <- c(1.995 , 1.999, 1, 0)
mat3[5, ] <- c(1.995 , 1.999, 1, 0)
mat3[6, ] <- c(1.995 , 1.999, 1, 0)
mat3[7, ] <- c(1.995 , 1.999, 1, 0)
mat3[8, ] <- c(1.995 , 1.999, 1, 0)  