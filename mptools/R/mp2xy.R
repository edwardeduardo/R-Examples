#' Back-transform RAMAS Metapop coordinates
#' 
#' Extracts population coordinates from a RAMAS Metapop .mp file, and converts 
#' them back to the coordinate system of the original habitat suitability grids 
#' (i.e. the grids supplied to the RAMAS patch-identification module, patch.exe 
#' or, in more recent versions of RAMAS GIS, SpatialData.exe).
#' 
#' @param mp A character string containing the path to a RAMAS Metapop .mp file.
#' @param r Either a character string containing the path to any of the raster
#'   files that were used by RAMAS Spatial Data for patch identification, or a
#'   \code{Raster*} object that was used for that purpose.
#' @param cell.length Numeric. The cell length of the grid, as specified in 
#'   RAMAS Spatial Data (note: this may be different to the native resolution of
#'   the grids).
#' @param plot Logical. Should the points be plotted? If \code{r} is a 
#'   \code{Raster*} object with more than one layer, the first layer will be 
#'   plotted.
#' @return A \code{data.frame} containing the names of all populations referred 
#'   to in the .mp file, as well as their coordinates (in both Metapop and 
#'   original coordinate systems). If \code{plot} is \code{TRUE}, a plot of the 
#'   raster layer, \code{r}, overlaid with points for all populations in the 
#'   metapopulation, is also produced.
#' @seealso \code{\link{mp2sp}}
#' @note \code{mptools} has been tested with outputs generated by RAMAS Metapop 
#'   version 5, and may produce unexpected results for other versions. A warning
#'   is issued if the user attempts to access files originating from other 
#'   versions of RAMAS Metapop. It is advised to verify that the returned 
#'   coordinates are sensible by referring to the plot that is returned by this 
#'   function.
#' @importFrom raster raster cellStats xmin ymin xres
#' @importFrom rasterVis levelplot
#' @importFrom latticeExtra layer
#' @importFrom sp sp.points SpatialPoints
#' @importFrom utils read.csv
#' @importFrom grDevices colorRampPalette terrain.colors
#' @importFrom methods is
#' @export
#' @examples
#' mp <- system.file('example.mp', package='mptools')
#' r <- system.file('example_001.tif', package='mptools')
#' coords <- mp2xy(mp, r, 9.975)
mp2xy <- function (mp, r, cell.length, plot=TRUE) {
  metapop <- check_mp(mp)
  metapop <- metapop[-(1:6)]
  pops <- metapop[39:(grep('^Migration$', metapop) - 1)]
  pops <- utils::read.csv(
    text=pops, stringsAsFactors=FALSE, header=FALSE)[, 1:3]
  if (!methods::is(r, 'Raster')) r <- raster::raster(r)
  x0 <- raster::xmin(r)
  y0 <- raster::ymin(r)
  cellsize <- raster::xres(r)
  nr <- nrow(r)
  y1 <- y0 + nr * cellsize
  colnames(pops) <- c('pop', 'x_mp', 'y_mp')
  scl <- cellsize/cell.length
  pops$x <- (x0 - 0.5 * cellsize) + scl * pops$x_mp
  pops$y <- (y1 + 0.5 * cellsize) - scl * pops$y_mp
  if (plot) {
    p <- rasterVis::levelplot(
      r[[1]], col.regions=viridis::viridis, 
      margin=FALSE, colorkey=list(height=0.6, raster=TRUE),
      at=seq(raster::cellStats(r[[1]], min), 
             raster::cellStats(r[[1]], max), len=101)) + 
      latticeExtra::layer(sp::sp.points(
        sp::SpatialPoints(pops[, c('x', 'y')]), col=1, fill='#ffffff80', pch=21), 
        data=list(pops=pops))
    print(p)
  }
  return(pops)
}
