#' @include utils.R
NULL

#' Title
#'
#' @param y
#' @param arima
#' @param X
#' @param mean
#' @param outliers
#' @param filter
#' @param fast
#'
#' @returns
#' @export
#'
#' @examples
#'
regarima_outlier<-function(y, arima, X=NULL, mean=FALSE, outliers=c("ao", "ls", "tc:0.7"), filter=c("fast", "ansley", "kalman", "x12", "ljungbox"), fast = TRUE){
  filter<-match.arg(filter)
  jarima<-.jd3_arima(arima)
  jrslt<-.jcall('jdplus/sts/base/r/Outliers', 'Ljdplus/toolkit/base/api/math/matrices/Matrix;', 'regarimaOutlier',
                 as.numeric(y), .jcast(jarima,'jdplus/toolkit/base/core/arima/IArimaModel'), mean, rjd3toolkit::.r2jd_matrix(X),
                .jarray(outliers), filter, as.logical(fast))

  return (rjd3toolkit::.jd2r_matrix(jrslt))
}

#' Title
#'
#' @param y
#' @param arima
#' @param X
#' @param mean
#' @param critical.value
#' @param outliers
#' @param fast
#'
#' @returns
#' @export
#'
#' @examples
regarima_outliers<-function(y, arima, X=NULL, mean=FALSE, critical.value = 0, outliers=c("ao", "ls", "tc:0.7"), fast = TRUE){
  jarima<-.jd3_arima(arima)
  jrslt<-.jcall('jdplus/toolkitx/base/r/Outliers', 'Ljdplus/toolkit/base/api/math/matrices/Matrix;', 'regarima_outliers',
                as.numeric(y), .jcast(jarima,'jdplus/toolkit/base/core/arima/IArimaModel'), mean, rjd3toolkit::.r2jd_matrix(X),
                as.numeric(critical.value), .jarray(outliers), as.logical(fast))

  return (1+rjd3toolkit::.jd2r_matrix(jrslt))
}

#' Title
#'
#' @param y
#' @param bsm
#' @param X
#' @param mad
#'
#' @returns
#' @export
#'
#' @examples
#' bsm<-rjd3sts::bsm_model(12)
#' q<-bsm_outlier(rjd3toolkit::Retail$BookStores, bsm=bsm)
#' matplot(q[,c(4,5,6,7)], type='l')
bsm_outlier<-function(y, bsm, X=NULL, mad =FALSE){
  jbsm<-rjd3sts::.r2jd_bsm(bsm)
  jrslt<-.jcall('jdplus/sts/base/r/Outliers', 'Ljdplus/toolkit/base/api/math/matrices/Matrix;', 'bsmOutlier',
                as.numeric(y), jbsm, rjd3toolkit::.r2jd_matrix(X), as.logical(mad))

  return (rjd3toolkit::.jd2r_matrix(jrslt))
}

#' Title
#'
#' @param y
#' @param arima
#' @param X
#' @param mean
#' @param critical.value
#' @param outliers
#' @param fast
#' @param ml
#'
#' @returns
#' @export
#'
#' @examples
tramo_outliers<-function(y, arima, X=NULL, mean=FALSE, critical.value = 0, outliers=c("ao", "ls", "tc:0.7"), fast = TRUE, ml=FALSE){
  jarima<-rjd3toolkit::.r2jd_sarima(arima)
  jrslt<-.jcall('jdplus/sts/base/r/Outliers', 'Ljdplus/toolkit/base/api/math/matrices/Matrix;', 'tramoOutliers',
                as.numeric(y), jarima, mean, rjd3toolkit::.r2jd_matrix(X),
                as.numeric(critical.value), .jarray(outliers), as.logical(fast), as.logical(ml))

  return (rjd3toolkit::.jd2r_matrix(jrslt))
}

#' Title
#'
#' @param y
#' @param arima
#' @param X
#' @param mean
#' @param critical.value
#' @param outliers
#' @param fast
#'
#' @returns
#' @export
#'
#' @examples
x12_outliers<-function(y, arima, X=NULL, mean=FALSE, critical.value = 0, outliers=c("ao", "ls", "tc:0.7"), fast = FALSE){
  jarima<-rjd3toolkit::.r2jd_sarima(arima)
  jrslt<-.jcall('jdplus/sts/base/r/Outliers', 'Ljdplus/toolkit/base/api/math/matrices/Matrix;', 'x12Outliers',
                as.numeric(y), jarima, mean, rjd3toolkit::.r2jd_matrix(X),
                as.numeric(critical.value), .jarray(outliers), as.logical(fast))

  return (rjd3toolkit::.jd2r_matrix(jrslt))
}


#' Title
#'
#' @param y
#' @param bsm
#' @param X
#' @param critical.value
#' @param ao
#' @param ls
#' @param so
#' @param mad
#' @param forward
#' @param backward
#'
#' @returns
#' @export
#'
#' @examples
bsm_outliers<-function(y, bsm, X=NULL, critical.value = 0, ao=TRUE, ls=TRUE, so=FALSE, mad =TRUE, forward=c("Full", "Score", "Point"), backward=c("Point", "Score","Full")){
  forward=match.arg(forward)
  backward=match.arg(backward)
  jbsm<-rjd3sts::.r2jd_bsm(bsm)
  jspec<-rjd3sts::.bsm2spec(jbsm)
  jrslt<-.jcall('jdplus/toolkitx/base/r/Outliers', 'Ljdplus/toolkit/base/api/math/matrices/Matrix;', 'bsm_outliers',
                as.numeric(y), as.integer(bsm$period), jspec, rjd3toolkit::.r2jd_matrix(X),
                as.numeric(critical.value), as.logical(ao), as.logical(ls), as.logical(so),
                as.logical(mad), forward, backward)

  return (rjd3toolkit::.jd2r_matrix(jrslt))
}
