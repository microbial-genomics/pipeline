# B.	Filter low quality reads using fastq quality trimmer from FASTX.
#what we have coming in
pipeline.dir
fastq.dir
fastq_join.dir
qiime.dir

#directory names
fastq.unfiltered.dir #unfiltered fastq data directory
fastq.filtered.dir #filtered fastq data directory
fastq.paired.dir #paired fastq data directory

#file names with dimension
fastq.files.unfiltered # has dimension equal to number of unfiltered files
fastq.files.filtered <- paste("filtered_",fastq.files.unfiltered,sep="") #prepend filtered_ to file name
fastq.files.filtered
fastq.files.unfiltered.wpath <- paste(fastq.unfiltered.dir,fastq.files.unfiltered,sep="")  
fastq.files.filtered.wpath <- paste(fastq.filtered.dir,fastq.files.filtered,sep="")
fastq.files.unfiltered.wpath #unfiltered file 
fastq.files.filtered.wpath #filtered file that is to be paired

#file commands to be run
fastq.trim.commands  <- paste(fastq.dir,"fastq_quality_trimmer -t 20 -Q33 -i ", fastq.files.unfiltered.wpath, 
                        " -o ", fastq.files.filtered.wpath, sep="")
fastq.trim.commands

for(command in fastq.trim.commands){
  system(command)
}
