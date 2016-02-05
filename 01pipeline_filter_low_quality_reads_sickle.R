# B.	Filter low quality reads using trimmer from sickle (https://github.com/najoshi/sickle).
ptm <- proc.time()
#file names with dimension
#set knitr 
## @knitr sickle_filter
fastq.files.unfiltered <- list.files(fastq.unfiltered.dir)# has dimension equal to number of unfiltered files
fastq.files.filtered <- paste("filtered_",fastq.files.unfiltered,sep="") #prepend filtered_ to file name
fastq.files.unfiltered.wpath <- paste(fastq.unfiltered.dir,fastq.files.unfiltered,sep="")  
fastq.files.filtered.wpath <- paste(fastq.filtered.dir,fastq.files.filtered,sep="")

#Delete existing files in filtered directory before running trimmer

unlink(fastq.files.filtered.wpath,recursive=TRUE, force=FALSE) #Delete Previous Data_Filtered files

#Genereate input and out filenames wpath, with dimension
R1.input <- list.files(fastq.unfiltered.dir,pattern="R1_001.fastq")
R1.input.wpath <- paste(fastq.unfiltered.dir,R1.input,sep="")
R1.output <- paste("filtered_",R1.input,sep="") 
R1.output.wpath <- paste(fastq.filtered.dir,R1.output,sep="")

R2.input <- list.files(fastq.unfiltered.dir,pattern="R2_001.fastq")
R2.input.wpath <- paste(fastq.unfiltered.dir,R2.input,sep="")
R2.output <- paste("filtered_",R2.input,sep="") 
R2.output.wpath <- paste(fastq.filtered.dir,R2.output,sep="")
trimmed.singles.wpath <- paste(trimmed.singles.dir,R1.output,sep="") #trimmed singles output wpath


#file commands to be run sickle for quality filtering

sickle.command <- paste(sickle.dir,"sickle"," pe -f ", R1.input.wpath, " -r ", R2.input.wpath, " -t sanger ",
                        " -o ", R1.output.wpath, " -p ",R2.output.wpath, " -s ", trimmed.singles.wpath,
                        " -q 20 -x ",sep="" )

for(command in sickle.command){
  system(command)
}

## @knitr sickle_filtered_files
fastq.files.filtered.wpath #Filtered Sickle Files

#Count Unfiltered Sequences Command
## @knitr sickle_filtered_seq_count
count.unfiltered.seqs.command <- paste(qiime.dir,"count_seqs.py -i ", "'",fastq.unfiltered.dir, "*.fastq","'", " -o ",
                                     unfiltered.seqcounts.dir, "unfiltered_seqs.txt",sep="")
for(command in count.unfiltered.seqs.command){
  system(command)
}

#Count Filtered Sequences Command

count.filtered.seqs.command <- paste(qiime.dir,"count_seqs.py -i ", "'", fastq.filtered.dir,"*.fastq","'", " -o ",
                                     filtered.seqcounts.dir,"filtered_seqs.txt", sep="")
for(command in count.filtered.seqs.command){
  system(command)
}
proc.time() - ptm




