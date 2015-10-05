# B.	Filter low quality reads using fastq quality trimmer from FASTX.

#file names with dimension
fastq.files.unfiltered <- list.files(fastq.unfiltered.dir)# has dimension equal to number of unfiltered files
fastq.files.filtered <- paste("filtered_",fastq.files.unfiltered,sep="") #prepend filtered_ to file name
fastq.files.unfiltered.wpath <- paste(fastq.unfiltered.dir,fastq.files.unfiltered,sep="")  
fastq.files.filtered.wpath <- paste(fastq.filtered.dir,fastq.files.filtered,sep="")

#Delete existing files in filtered directory before running trimmer
unlink(fastq.files.filtered.wpath,recursive=TRUE, force=FALSE) #Delete Previous Data_Filtered files

#file commands to be run
fastq.trim.commands  <- paste(fastq.dir,"fastq_quality_trimmer -t 20 -Q33 -i ", fastq.files.unfiltered.wpath, 
                        " -o ", fastq.files.filtered.wpath, sep="")
#fastq.trim.commands

for(command in fastq.trim.commands){
  system(command)
}
