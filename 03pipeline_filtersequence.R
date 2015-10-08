# D.	Filter out the primer/barcode sequence using SeqFilters.jar from 
#https://github.com/rdpstaff/SeqFilters

#Files with dimension
fasta.files <-paste(fastq.convert.fasta.dir,list.files(fastq.convert.fasta.dir,pattern="fna"),sep="")
filtered.dir.wpath <- paste(filtered.dir,paste(list.files(fastq.convert.fasta.dir,pattern="fna"),sep=""),sep="")

#Delete any folders in the SFBR_SeqFiltered directory...the java script will not run if files already exist
unlink(filtered.dir.wpath,recursive=TRUE, force=FALSE)

#D. Filter out the primer/barcode sequence
#1.  Download SeqFilters.jar from https://github.com/rdpstaff/SeqFilters 
#2.  Run SeqFilters.jar with this command: java -jar /path/to/SeqFilters.jar

#File command
seqfilter.command <- paste("java -jar ",seq_filter.dir, "SeqFilters.jar", " --forward-primers CAGCMGCCGCGGTAATWC --max-forward 2 --reverse-primers CCGTCAATTCCTTTRAGGTT --max-reverse 1 --seq-file ", fasta.files,
                                " -o ", filtered.dir.wpath, sep="")                          
for(command in seqfilter.command){
  system(command)
}


