# DESP/R/DESP_MST.R by A. S. Dalalyan and S. Balmand  Copyright (C) 2015-
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License (version 3) as published by
#  the Free Software Foundation.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  A copy of the GNU General Public License is available at
#  http://www.r-project.org/Licenses/
#

DESP_MST <-
function(X,B,Theta=NULL) {
  # estimation of the diagonal of the precision matrix using minimum spanning trees, when the true value of B is known or has already been estimated
  # the observations of the data matrix X are assumed to have zero mean

  # read the sample size and the number of variables
  D = dim(X);
  n = D[1];               # n is the sample size
  p = D[2];               # p is the dimension

  # compute the sample cov matrix
  if(is.null(Theta))
    {
    S = crossprod(X)/n;
    }
  else
    {
    S = crossprod(X - Theta %*% MASS::ginv(B))/n;
    }
  
  G = DESP_Weighted_Graph(B,n);
  trees = DESP_MST_MaxDegreeRoot(G);
  Phi = DESP_MST_Phi(S,B,trees);

  return(1/Phi);
}

DESP_MST_Phi <-
function(S,B,trees) {
  return(DESP_SPT_Phi(S,B,trees));
}
