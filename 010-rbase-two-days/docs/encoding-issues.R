# reading files with different encodings
# example with LATIN1

options(encoding = "LATIN1")

read.table("~/dev/qtraining/010-rbase-two-days/data/tuscany-encoding-latin1.txt",
           stringsAsFactors = FALSE, 
           sep= "|", header=TRUE)

