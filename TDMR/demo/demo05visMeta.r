#*# This demo demonstrates TDMR's interactive visualization capabilities for a RES data frame
#*# generated by demo04cpu. See help(tdmPlotResMeta) for further details.

## set working directory, load package and load envT
#require(TDMR);
path <- paste(find.package("TDMR"), "demo01cpu",sep="/");
#path <- paste("../inst", "demo01cpu",sep="/");
oldwd <- getwd();   setwd(path);
load("demoCpu.RData");   # envT as saved by demo04cpu.r 

## interactive visualization of one or many RES data frames contained in envT
## via GUI twiddler and 3D-plots (RGL) or contour plots
tdmPlotResMeta(envT);

## restore old working directory
setwd(oldwd);

## A certain RGL window n can be selected with  > rgl.set(n).
## An interactively manipulated RGL window can be saved with > rgl.snapshot("myplot.png").