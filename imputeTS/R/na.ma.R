#' @title Missing Value Imputation by Weighted Moving Average
#' 
#' @description Missing value replacement by weighted moving average. Uses semi-adaptive window size to ensure all NAs are replaced.
#' @param x Numeric Vector (\code{\link{vector}}) or Time Series (\code{\link{ts}}) object in which missing values shall be replaced
#' @param weighting Weighting to be used. Accepts the following input:
#' \itemize{
#'    \item{"simple" - Simple Moving Average (SMA)}
#'    \item{"linear" - Linear Weighted Moving Average (LWMA)}
#'    \item{"exponential" - Exponential Weighted Moving Average (EWMA)}
#'    }
#'    
#' @param k integer width of the moving average window. Expands to both sides of the center element 
#' e.g. k=2 means 4 observations (2 left, 2 right) are taken into account. If all observations in the current window are NA,
#' the window size is automatically increased until there are at least 2 non-NA values present.
#' 
#' @return Vector (\code{\link{vector}}) or Time Series (\code{\link{ts}}) object (dependent on given input at parameter x)
#' 
#' @details In this function missing values get replaced by moving average values. Moving Averages are also sometimes 
#' refered to as "moving mean", "rolling mean", "rolling average" or "running average".
#' 
#' The mean in this implementation taken from an equal number of observations on either side of a central value. 
#' This means for an NA value at position \code{i} of a time series, the obervations i-1,i+1 and i+1, i+2 (assuming a window size of k=2)
#' are used to calculate the mean.
#' 
#' Since it can in case of long NA gaps also occur, that all values next to the central value are also NA, the algorithm has 
#' a semi-adaptive window size. Whenever there are less than 2 non-NA values in the complete window available, the window size
#' is incrementally increased, till at least 2 non-NA values are there. In all other cases the algortihm sticks preset window
#' size.
#' 
#' Ther are options for using Simple Moving Average (SMA), Linear Weighted Moving Average (LWMA) and 
#' Exponential Weighted Moving Average (EWMA).
#' 
#' SMA: all observations in the window are equally weighted for calculating the mean.
#' 
#' LWMA: weights decrease in arithmetical progression. The observations directly next to a central value i, have weight 1/2,
#' the observations one further away (i-2,i+2) have weight 1/3, the next (i-3,i+3) have weight 1/4, ...
#' 
#' EWMA: uses weighting factors which decrease exponentially. The observations directly next to a central value i, have weight 1/2^1,
#' the observations one further away (i-2,i+2) have weight 1/2^2, the next (i-3,i+3) have weight 1/2^3, ...
#' 
#' 
#' @author Steffen Moritz
#' 
#' @seealso  \code{\link[imputeTS]{na.interpolation}},
#' \code{\link[imputeTS]{na.kalman}}, \code{\link[imputeTS]{na.locf}},
#' \code{\link[imputeTS]{na.mean}},
#'  \code{\link[imputeTS]{na.random}}, \code{\link[imputeTS]{na.replace}},
#'  \code{\link[imputeTS]{na.seadec}}, \code{\link[imputeTS]{na.seasplit}}
#'  
#' @examples
#' #Prerequisite: Load Time series with missing values
#' x <- tsAirgap
#' 
#' #Example 1: Perform imputation with simple moving average
#' na.ma(x, weighting = "simple")
#' 
#' #Example 2: Perform imputation with exponential weighted moving average
#' na.ma(x)
#' 
#' #Example 3: Perform imputation with exponential weighted moving average, window size 6
#' na.ma(x, k=6)
#' 
#' @import stats
#' @export

na.ma <- function(x, k =4, weighting = "exponential") {

  data <- x
  
  #Check for wrong input 
  data <- precheck(data)
  
  #if no missing data, do nothing
  if(!anyNA(data)) {
    return(data)
  }
  
  #Stop for wrong k values
  if (k < 1) {
    stop("Parameter k has  to be larger than 0")
  }
  
  ##
  ## Imputation Code
  ##
  tempdata <- data
  
  for(i in 1:length(tempdata)) {
    
    if(is.na(tempdata[i])) {
    
      ktemp <- k 
      #Get indices needed for mean calaculation + delete negative indices
      usedIndices <- (i-ktemp):(i+ktemp)
      usedIndices <- subset(usedIndices,usedIndices >= 1)
      t <- tempdata[usedIndices]
      
      #If only NAs in selected indices increase window size
      while(length(t[!is.na(t)])<2) {
        ktemp <- ktemp+1
        usedIndices <- (i-ktemp):(i+ktemp)
        usedIndices <- subset(usedIndices,usedIndices >= 1)
        t <- tempdata[usedIndices]
      }
      if(weighting =="simple") {
        data[i] <- mean(tempdata[usedIndices], na.rm=T)
      }
      else if(weighting =="linear") {
        #Calculate weights based on indices 1/(distance from current index+1)
        #Set weights where data is NA to 0
        #Sum up all weights (needed later) to norm it
        #Create weighted data (weights*data)
        #Sum up
        weightsData <- 1/(abs(usedIndices-i)+1)
        naCheck <- ifelse(is.na(tempdata[usedIndices]),0,1)
        weightsData <- weightsData *naCheck
        sumWeights <- sum(weightsData)
        weightedData <- (tempdata[usedIndices]* weightsData)/ sumWeights
        data[i] <- sum(weightedData, na.rm=T)
      }
      else if(weighting =="exponential"){
        #Calculate weights based on indices 1/ 2 ^ (distance from current index)
        #Set weights where data is NA to 0
        #Sum up all weights (needed later) to norm it
        #Create weighted data (weights*data)
        #Sum up
        weightsData <- 1/(2^abs(usedIndices-i))
        naCheck <- ifelse(is.na(tempdata[usedIndices]),0,1)
        weightsData <- weightsData *naCheck
        sumWeights <- sum(weightsData)
        weightedData <- (tempdata[usedIndices]* weightsData)/ sumWeights
        data[i] <- sum(weightedData, na.rm=T)
      }
      
    }
  }
  
  return(data)
}

