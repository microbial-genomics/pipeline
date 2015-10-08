# B.	Filter low quality reads using trimmer from sickle (https://github.com/najoshi/sickle).

#file names with dimension
fastq.files.unfiltered <- list.files(fastq.unfiltered.dir)# has dimension equal to number of unfiltered files
fastq.files.filtered <- paste("filtered_",fastq.files.unfiltered,sep="") #prepend filtered_ to file name
fastq.files.unfiltered.wpath <- paste(fastq.unfiltered.dir,fastq.files.unfiltered,sep="")  
fastq.files.filtered.wpath <- paste(fastq.filtered.dir,fastq.files.filtered,sep="")

#Delete existing files in filtered directory before running trimmer
unlink(fastq.files.filtered.wpath,recursive=TRUE, force=FALSE) #Delete Previous Data_Filtered files

#Genereate input and out filenames wpath, with dimension
R1.input<-NA
for(i in seq(1,length(fastq.files.unfiltered),2)){
  R1.input[i] <-  fastq.files.unfiltered[i]
}
R1.input<-na.exclude(R1.input)
R1.input.wpath <- paste(fastq.unfiltered.dir,R1.input,sep="") #forward reads input wpath

R1.output <- NA
for(i in seq(1,length(fastq.files.filtered),2)){
  R1.output[i] <-  fastq.files.filtered[i]
}
R1.output<-na.exclude(R1.output)
R1.output.wpath <- paste(fastq.filtered.dir,R1.output,sep="") #forward reads output wpath

R2.input<-NA
for(i in seq(2,length(fastq.files.unfiltered),2)){
  R2.input[i] <-  fastq.files.unfiltered[i]
}
R2.input<-na.exclude(R2.input)
R2.input.wpath <- paste(fastq.unfiltered.dir,R2.input,sep="") #reverse reads input wpath

R2.output <- NA
for(i in seq(2,length(fastq.files.filtered),2)){
  R2.output[i] <-  fastq.files.filtered[i]
}
R2.output<-na.exclude(R2.output)
R2.output.wpath <- paste(fastq.filtered.dir,R2.output,sep="") #reverse reads output wpath

trimmed.singles.wpath <- paste(trimmed.singles.dir,R1.output,sep="") #trimmed singles output wpath

#file commands to be run sickle for quality filtering
sickle.command <- paste(sickle.dir,"sickle"," pe -f ", R1.input.wpath, " -r ", R2.input.wpath, " -t sanger ",
                        " -o ", R1.output.wpath, " -p ",R2.output.wpath, " -s ", trimmed.singles.wpath,
                        " -q 20 -x ",sep="" )
#run sickle commands
for(command in sickle.command){
  system(command)
}
