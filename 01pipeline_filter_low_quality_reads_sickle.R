# B.	Filter low quality reads using trimmer from sickle (https://github.com/najoshi/sickle).

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

#R1.input<-NA
#for(i in seq(1,length(fastq.files.unfiltered),2)){
#  R1.input[i] <-  fastq.files.unfiltered[i]
#}
#R1.input<-na.exclude(R1.input)
#R1.input.wpath <- paste(fastq.unfiltered.dir,R1.input,sep="") #forward reads input wpath

#R1.output <- NA
#for(i in seq(1,length(fastq.files.filtered),2)){
#  R1.output[i] <-  fastq.files.filtered[i]
#}
#R1.output<-na.exclude(R1.output)
#R1.output.wpath <- paste(fastq.filtered.dir,R1.output,sep="") #forward reads output wpath

#R2.input<-NA
#for(i in seq(2,length(fastq.files.unfiltered),2)){
#  R2.input[i] <-  fastq.files.unfiltered[i]
#}
#R2.input<-na.exclude(R2.input)
#R2.input.wpath <- paste(fastq.unfiltered.dir,R2.input,sep="") #reverse reads input wpath

#R2.output <- NA
#for(i in seq(2,length(fastq.files.filtered),2)){
#  R2.output[i] <-  fastq.files.filtered[i]
#}
#R2.output<-na.exclude(R2.output)
#R2.output.wpath <- paste(fastq.filtered.dir,R2.output,sep="") #reverse reads output wpath
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
count.unfiltered.seqs.command <- paste(py_join,"count_seqs.py -i ", "'",fastq.unfiltered.dir, "*.fastq","'", " -o ",
                                     unfiltered.seqcounts.dir, "unfiltered_seqs.txt",sep="")
for(command in count.unfiltered.seqs.command){
  system(command)
}

#Count Filtered Sequences Command

count.filtered.seqs.command <- paste(py_join,"count_seqs.py -i ", "'", fastq.filtered.dir,"*.fastq","'", " -o ",
                                     filtered.seqcounts.dir,"filtered_seqs.txt", sep="")
for(command in count.filtered.seqs.command){
  system(command)
}

#Table with Pre and Post Quality Filter Counts
unfiltered_seqs_count_file.wpath <- paste(unfiltered.seqcounts.dir,"unfiltered_seqs.txt",sep="")
unfiltered_seqs_count_file <- read.table(unfiltered_seqs_count_file.wpath,sep=":",col.names=c("Unfiltered_Counts","File","Unfiltered_Stats"))
unfilt_dt <- data.table(unfiltered_seqs_count_file)
unfilt_dt <- subset(unfilt_dt, select = -Unfiltered_Stats)
unfilt_dt <- unfilt_dt[-nrow(unfilt_dt)]
unfilt_id1 <- substring(unfilt_dt$File, 60,62)
unfilt_id2 <- substring(unfilt_dt$File,nchar(as.character(unfilt_dt$File))-44,
                                   nchar(as.character(unfilt_dt$File))-43)
unfilt_id <- paste(unfilt_id1,"_",unfilt_id2,sep="")
unfilt_dt$Sample_ID <- unfilt_id
unfilt_dt$File <- NULL
unfilt_dt

filtered_seqs_count_file.wpath <- paste(filtered.seqcounts.dir,"filtered_seqs.txt",sep="")
filtered_seqs_count_file <- read.table(filtered_seqs_count_file.wpath,sep=":",col.names=c("Filtered_Counts","File","Filtered_Stats"))
filt_dt <- data.table(filtered_seqs_count_file)
filt_dt <- subset(filt_dt, select = -Filtered_Stats)
filt_dt <- filt_dt[-nrow(filt_dt)]
filt_id1 <- substring(filtered_dt$File, 78,80)
filt_id2 <- substring(filt_dt$File,nchar(as.character(filt_dt$File))-44,
                        nchar(as.character(filt_dt$File))-43)
filt_id <- paste(filt_id1,"_",filt_id2,sep="")
filt_dt$Sample_ID <- filt_id
filt_dt$File <- NULL
filt_dt

count.table <- merge(unfilt_dt, filt_dt, by = "Sample_ID", all=TRUE)



