complete <- function(directory, id = 1:332) {

  # Set up input and output frames
  pollutedata <- data.frame()
  final.cases <- data.frame()
 
  # Load data from each file
  for(monitor in id){
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
  return(final.cases)
}