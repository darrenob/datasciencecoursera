pollutantmean <- function(directory, pollutant, id = 1:332) {
  
  # Set up frame
  pollutedata <- data.frame()
  
  # Load data from each file
  for(monitor in id){
    filename <- paste0(sprintf("%03d",monitor), ".csv")
    file <- file.path(getwd(), directory, filename)
    pollutedata <- rbind(pollutedata, read.csv(file))
  }
  
  # return the mean of whatever column was passed in 'pollutant' parameter
  mean(pollutedata[[pollutant]], na.rm = TRUE)
}
