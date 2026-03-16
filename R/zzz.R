#' @include outliers.R
NULL

.onLoad <- function(libname, pkgname) {
<<<<<<< HEAD
  # For debugging: to see if Jars are effectively loaded
  # options(java.parameters = "-verbose:class")

  # TODO : devtools will look only in RJDemetra3\java for JAR files so copied them there too
  result <- .jpackage(pkgname, lib.loc=libname)
  if (!result) stop("Loading java packages failed")

  # what's your java  version?  Need > 1.5.0.
  jversion <- .jcall('java.lang.System','S','getProperty','java.version')
  if (jversion < "1.8.0") {
    stop(paste("Your java version is ", jversion,
               ".  Need 1.8.0 or higher.", sep=""))
  } else {
    cat("Java requirements fullfilled, found version ",jversion,"\n")
  }

  proto.dir <- system.file("proto", package = pkgname)
  readProtoFiles2(protoPath = proto.dir)
=======
  if (! requireNamespace("rjd3sts", quietly = T)) stop("Loading rjd3 libraries failed")

  result <- rJava::.jpackage(pkgname, lib.loc=libname)
  if (!result) stop("Loading java packages failed")

  # reload extractors
  rjd3toolkit::reload_dictionaries()
>>>>>>> 43a4da6ddda3ab7f7e6d38d569828647e86f9897
}

