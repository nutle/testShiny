'installPackages' <- function (package1, ...)  {   
  
  # convert arguments to vector
  packages <- c(package1, ...)
  
  # start loop to determine if each package is installed
  for(package in packages){
    
    # if package is installed locally, load
    if(package %in% rownames(installed.packages()))
      do.call('library', list(package))
    
    # if package is not installed locally, download, then load
    else {
      install.packages(package, repos = 'http://cran.rstudio.com/')
      do.call("library", list(package))
    }
  } 
}

current.list <- c('DT', 'proxy','dbscan','mlbench','randomForest','autoencoder',
                  'fclust', 'DMwR', 'HighDimOut', 'robustbase', 'SeleMix', 'httr', 'xml2', 'quantmod',
                  'shinythemes', 'shinydashboard')


#  ------------------------------------------------------------------------


installPackages(current.list)