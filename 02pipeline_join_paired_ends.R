# C.	Join paired end reads using join_paired_ends.py from QIIME 
# install macqiime: http://www.wernerlab.org/software/macqiime/macqiime-installation
#also fastq to qiime: http://www.wernerlab.org/software/macqiime/add-fastq-join-to-macqiime-1-8-0
ptm <- proc.time()
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
  join.paired.ends.command <- paste(qpy, qiime.dir, "join_paired_ends.py", sep="")
  file.exists(fastq.files.filtered.wpath[i])
  file.exists(fastq.files.filtered.wpath[i+1])
  write("#!/bin/bash",file=fastq.scripts.wpath[i],append=FALSE)
  write("source /macqiime/configs/bash_profile.txt",file=fastq.scripts.wpath[i],append=TRUE)
  file.command <- paste("join_paired_ends.py -f ", fastq.files.filtered.wpath[i], " -r ", fastq.files.filtered.wpath[i+1],
                        " -o ", fastq.files.paired.wpath[i], sep="")
  write(file.command, file=fastq.scripts.wpath[i],append=TRUE)
  print(file.command)
  chmod1 <- "chmod 755 join_scripts/SFBR-Rain-Event-*_S*_L001_R1_001.script"
  #chmod2 <- "chmod 755 /Volumes/oneTB/pipeline/join_scripts/*_S*_L001_R1_001.script"
  system(chmod1)
  system(fastq.scripts.wpath[i])
  #change name of output
}

proc.time() - ptm

ptm <- proc.time()
#Delete any existing files in the SFBR_Joined directory prior to copying new files
fastq.files.joined.wpath <- paste(fastq.paired.join.dir,"/",list.files(fastq.paired.join.dir),sep="")
unlink(fastq.files.joined.wpath,recursive=FALSE, force=FALSE)

#paired output
nfiles3 <- length(fastq.files.paired.wpath)
joined_files_to_copy <- paste(fastq.files.paired.wpath,"/fastqjoin.join.fastq",sep="")[seq(1,nfiles3,by=2)]
joinedfiles <- paste("/fastq",sample.id.2,sep="") #gets the sample name from read in id file
joined_files_copied <- paste(fastq.paired.join.dir,joinedfiles,".fastq",sep="")
file.copy(joined_files_to_copy, joined_files_copied) #copies .fastq files from SFBR_Data_Paired and pastes to SFBR_joined
joined.fastq.files.wpath <- paste(joined_files_copied)
joined.fastq.files.wpath

#Delete any existing files in the fastq.convert.fasta.dir prior to running convert_fastaqual_fastq.py
fasta.files <-paste(fastq.convert.fasta.dir,list.files(fastq.convert.fasta.dir),sep="")
unlink(fasta.files,recursive=FALSE,force=FALSE)

#file commands to be run to convert fastq to fasta

fastq.to.fasta.command <- paste(qiime.dir,"convert_fastaqual_fastq.py -c fastq_to_fastaqual -f ", joined_files_copied,
                                                 " -o ", fastq.convert.fasta.dir, sep="")
ptm <- proc.time()
for(command in fastq.to.fasta.command){
  system(command)
}
proc.time() - ptm
fasta.fasta_qual.files.wpath <- paste(fastq.convert.fasta.dir,list.files(fastq.convert.fasta.dir),sep="")
fasta.fasta_qual.files.wpath
proc.time() - ptm

