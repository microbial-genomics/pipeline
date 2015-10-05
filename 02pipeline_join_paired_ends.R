# C.	Join paired end reads using join_paired_ends.py from QIIME 
# install macqiime: http://www.wernerlab.org/software/macqiime/macqiime-installation
#also fastq to qiime: http://www.wernerlab.org/software/macqiime/add-fastq-join-to-macqiime-1-8-0

#create script filenames with dimension
fastq.scripts <- sub("fastq","script",fastq.files.unfiltered)
fastq.scripts.wpath <- paste(fastq.scripts.dir,fastq.scripts,sep="")
#Delete existing join_paired_end scripts prior to creating new join_paired_end.py scripts
unlink(fastq.scripts.wpath,recursive=FALSE,force=FALSE)

#file names with dimension
fastq.files.paired.wpath <- paste(fastq.paired.dir, paste("paired_",fastq.files.unfiltered,sep=""),sep="") 
nfiles <- length(fastq.files.filtered)

#delete any files in the fastq.paired.dir prior to running script
unlink(fastq.files.paired.wpath,recursive=TRUE,force=FALSE)

#http://www.wernerlab.org/software/macqiime/macqiime-installation
#chmod 755 for new script files so that R system can run them
for(i in seq(1,nfiles,2)){
  print(i) 
  join.paired.ends.command <- paste(qpy, py_join, "join_paired_ends.py", sep="")
  file.exists(fastq.files.filtered.wpath[i])
  file.exists(fastq.files.filtered.wpath[i+1])
  write("#!/bin/bash",file=fastq.scripts.wpath[i],append=FALSE)
  write("source /macqiime/configs/bash_profile.txt",file=fastq.scripts.wpath[i],append=TRUE)
  file.command <- paste("join_paired_ends.py -f ", fastq.files.filtered.wpath[i], " -r ", fastq.files.filtered.wpath[i+1],
                        " -o ", fastq.files.paired.wpath[i], sep="")
  write(file.command, file=fastq.scripts.wpath[i],append=TRUE)
  print(file.command)
  chmod <- "chmod 755 SFBR_Scripts/SFBR-Rain-Event-*_S*_L001_R1_001.script"
  system(chmod)
  system(fastq.scripts.wpath[i])
  #change name of output
}

#Get Sample IDs
#Gets the Sample # out of the file string
in.files <- list.files(fastq.unfiltered.dir)
nfiles2 <- length(in.files)
sample.id <- NA
for(i in seq(1,nfiles2,2)){
  sample.id[i] <- na.exclude(substring(in.files[i],17,19)) #hard coded to SFBR data string lengths 
}
sample.id
sample.id.2 <- na.exclude(sample.id)
sample.id.2

#Delete any existing files in the SFBR_Joined directory prior to copying new files
fastq.files.joined.wpath <- paste(fastq.paired.join.dir,"/",list.files(fastq.paired.join.dir),sep="")
unlink(fastq.files.joined.wpath,recursive=FALSE, force=FALSE)

#paired output
nfiles3 <- length(fastq.files.paired.wpath)
joined_files_to_copy <- paste(fastq.files.paired.wpath,"/fastqjoin.join.fastq",sep="")[seq(1,nfiles3,by=2)]
joinedfiles <- paste("/fastq",sample.id.2,sep="") #gets the sample name from the substring of sample.id
joined_files_copied <- paste(fastq.paired.join.dir,joinedfiles,sep="")
file.copy(joined_files_to_copy, joined_files_copied) #copies .fastq files from SFBR_Data_Paired and pastes to SFBR_joined

#Look for the fastjoin.join.fastq in the output_file folder, use the joined fastq file. 

#Delete any existing files in the fastq.convert.fasta.dir prior to running convert_fastaqual_fastq.py
fasta.files <-paste(fastq.convert.fasta.dir,list.files(fastq.convert.fasta.dir),sep="")
unlink(fasta.files,recursive=FALSE,force=FALSE)

#file commands to be run to convert fastq to fasta

fastq.to.fasta.command <- paste(py_join,"convert_fastaqual_fastq.py -c fastq_to_fastaqual -f ", joined_files_copied,
                                                 " -o ", fastq.convert.fasta.dir, sep="")

for(command in fastq.to.fasta.command){
  system(command)
}

