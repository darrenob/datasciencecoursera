corr <- function(directory, threshold = 0) {
  
  # Set up input and output frames
  pollutedata <- data.frame()
  final.cases <- data.frame()
  corrs <- numeric(0)
  
  # Load data from each file
  for(monitor in 1:332){
    filename <- paste0(sprintf("%03d",monitor), ".csv")
    file <- file.path(getwd(), directory, filename)
    pollutedata <- rbind(pollutedata, read.csv(file))
    
    # Get complete cases
    pollutedata.complete <- pollutedata[complete.cases(pollutedata),]
    
    # Count complete cases and append to output
    cases <- nrow(pollutedata.complete[pollutedata.complete$ID == monitor,])
    final.cases <- rbind(final.cases, c(monitor, cases))
  }
  
  colnames(final.cases) <- c("id","nobs") 
  
  # The monitor locations that were above the threshold
  ids.abovehreshold <- final.cases$id[final.cases$nobs > threshold]
  
  # Get the correlation of the monitor locations that were above threshold
  for(monitor in ids.abovehreshold){
    pollutedata.abovethreshold <- pollutedata.complete[pollutedata.complete$ID == monitor,]
    corrs <- c(corrs, cor(pollutedata.abovethreshold$sulfate, pollutedata.abovethreshold$nitrate))
  }
  return(corrs)
}