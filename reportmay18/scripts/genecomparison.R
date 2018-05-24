# take one file of orthogroups and see if the
genecomparison <- function() {
  infantum <-
    read.table(
      "/home/fatemeh/leshmania/Samplemay10/script/genemappedcomparison/aligned_infantum_coordinate.txt"
    )
  infantumgenes <- infantum$V3
  donovanistrain <-
    read.table(
      "/home/fatemeh/leshmania/Samplemay10/script/genemappedcomparison/aligned_donovani_strain_coordinate.txt"
    )
  donovanistraingenes <- donovanistrain$V3
  donovaniB2 <-
    read.table(
      "/home/fatemeh/leshmania/Samplemay10/script/genemappedcomparison/aligned_donovani_BP2_coordinate.txt"
    )
  donovaniB2genes <- donovaniB2$V3
  intersectB2strain <-
    intersect(donovaniB2genes, donovanistraingenes)
  intersectB2infantum <- intersect(donovaniB2genes, infantumgenes)
  intersectstraininfantum <-
    intersect(donovanistraingenes, infantumgenes)
  intersect123 <-
    intersect(intersectB2infantum,
              intersectB2strain)
  grid.newpage()
  draw.triple.venn(
    area1 = length(donovaniB2genes),
    area2 = length(donovanistraingenes),
    area3 = length(infantumgenes),
    n12 = length(intersectB2strain),
    n23 = length(intersectstraininfantum),
    n13 = length(intersectB2infantum),
    n123 = length(intersect123),
    category = c("donovaniB2", "donovanistrain", "infantumgenes"),
    lty = "blank",
    fill = c("skyblue", "pink1", "mediumorchid")
  )
}
