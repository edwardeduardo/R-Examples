require(testthat)
require(pez)
require(ape)
context("Phylogeny simulation")

#Tests
# - no explicit test of edge2phylo because these test it
test_that("sim.bd.tree", {
    set.seed(123)
    tree <- sim.bd.phy()
    expect_that(tree, equals(structure(list(edge = structure(c(5, 5, 6, 6, 7, 7, 1, 6, 7, 
2, 3, 4), .Dim = c(6L, 2L)), tip.label = c("r_1", "r_2", "r_3", 
"r_4"), edge.length = c(21, 9, 3, 7, 9, 9), Nnode = 3L, traits = NULL), .Names = c("edge", 
"tip.label", "edge.length", "Nnode", "traits"), class = "phylo")))
    expect_that(length(tree$tip.label), equals(4))
    expect_that(is.ultrametric(tree), equals(FALSE))
})

test_that("sim.bd.tr.tree", {
    set.seed(123)
    tree <- sim.bd.tr.phy()
    expect_that(tree, equals(structure(list(edge = structure(c(38, 38, 39, 39, 40, 40, 42, 
42, 43, 43, 44, 44, 46, 46, 45, 45, 49, 49, 48, 48, 54, 54, 50, 
50, 55, 55, 53, 53, 56, 56, 57, 57, 59, 59, 60, 60, 41, 41, 52, 
52, 61, 61, 63, 63, 65, 65, 67, 67, 58, 58, 47, 47, 64, 64, 66, 
66, 51, 51, 62, 62, 68, 68, 69, 69, 70, 70, 71, 71, 72, 72, 73, 
73, 39, 40, 1, 2, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 
52, 53, 54, 55, 3, 56, 4, 57, 58, 59, 60, 61, 5, 6, 62, 7, 63, 
8, 9, 10, 11, 64, 12, 65, 66, 67, 13, 68, 69, 14, 15, 16, 17, 
18, 70, 19, 20, 21, 22, 71, 23, 24, 25, 26, 27, 72, 28, 29, 30, 
73, 31, 32, 33, 34, 35, 36, 37), .Dim = c(72L, 2L)), tip.label = c("r_1", 
"r_2", "r_3", "r_4", "r_5", "r_6", "r_7", "r_8", "r_9", "r_10", 
"r_11", "r_12", "r_13", "r_14", "r_15", "r_16", "r_17", "r_18", 
"r_19", "r_20", "r_21", "r_22", "r_23", "r_24", "r_25", "r_26", 
"r_27", "r_28", "r_29", "r_30", "r_31", "r_32", "r_33", "r_34", 
"r_35", "r_36", "r_37"), edge.length = c(1, 1, 2, 3, 13, 1, 2, 
3, 2, 1, 13, 6, 4, 7, 13, 8, 4, 2, 1, 3, 2, 4, 1, 5, 1, 1, 1, 
8, 8, 6, 8, 1, 2, 8, 8, 8, 4, 7, 1, 4, 1, 7, 5, 5, 6, 2, 6, 6, 
4, 2, 3, 3, 3, 3, 1, 3, 2, 2, 2, 2, 1, 2, 2, 2, 1, 2, 2, 2, 1, 
1, 1, 1), Nnode = 36L, traits = c(0.25, 0.75, 0, 0.525857547032189, 
0.995085970294524, 1, 0.95515429011881, 0.905441718454413, 0.807723581608364, 
0.977577145059405, 0.575386174682008, 0.467839245332762, 1, 0.777785857018962, 
0.938086883112271, 0.404820970064554, 0.673078236901868, 0.874418784792126, 
0.372504462421297, 0.373679105407267, 0.807688879521332, 1, 0.768831546243628, 
0.570736307271804, 0.324837070965564, 0.42017185387703, 0.634617355352803, 
0.506820361247994, 0.67268843609964, 0.956189924213305, 0.402937798134766, 
0.773308701631295, 0.301003375237698, 0.618508905217291, 0.877367199307171, 
1, 1, 0.402847097458953, 0.400873224853351, 0, 0.61538691457827, 
0, 0.91256809336392, 0, 0.978951252649258, 0.855679111912797, 
0.730134020596197, 0.946909292391895, 0.125941434091184, 0.555534993646155, 
0.498420683358936, 0.329043062834414, 0.877164329654132, 0.772882305925131, 
0, 0.21857349593138, 0.498023912605946, 0.780725064290637, 1, 
1, 0.909004905909167, 0.901420076991378, 0, 0.134139193746786, 
0.54793433683333, 0.714416938168076, 0, 0.0200336091175803, 0.90722331218179, 
0.910786499636543, 0.544134008426918, 0.551734665239742)), .Names = c("edge", 
"tip.label", "edge.length", "Nnode", "traits"), class = "phylo")))
    expect_that(length(tree$tip.label), equals(37))
    expect_that(is.ultrametric(tree), equals(FALSE))
})

