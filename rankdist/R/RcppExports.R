# This file was generated by Rcpp::compileAttributes
# Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

KendallNeighbour <- function(rank) {
    .Call('rankdist_KendallNeighbour', PACKAGE = 'rankdist', rank)
}

CayleyNeighbour <- function(rank) {
    .Call('rankdist_CayleyNeighbour', PACKAGE = 'rankdist', rank)
}

LogC <- function(fai) {
    .Call('rankdist_LogC', PACKAGE = 'rankdist', fai)
}

CWeightGivenPi <- function(r1, r2) {
    .Call('rankdist_CWeightGivenPi', PACKAGE = 'rankdist', r1, r2)
}

FindV <- function(obs, pi0) {
    .Call('rankdist_FindV', PACKAGE = 'rankdist', obs, pi0)
}

LogC_Component <- function(fai) {
    .Call('rankdist_LogC_Component', PACKAGE = 'rankdist', fai)
}

cycle_decomp <- function(comp) {
    .Call('rankdist_cycle_decomp', PACKAGE = 'rankdist', comp)
}

FindCayley <- function(obs, pi0) {
    .Call('rankdist_FindCayley', PACKAGE = 'rankdist', obs, pi0)
}

Wtau <- function(obs, pi0) {
    .Call('rankdist_Wtau', PACKAGE = 'rankdist', obs, pi0)
}

AllPerms <- function(nobj) {
    .Call('rankdist_AllPerms', PACKAGE = 'rankdist', nobj)
}

