# C.	Join paired end reads using join_paired_ends.py from QIIME 
# install macqiime: http://www.wernerlab.org/software/macqiime/macqiime-installation
#also fastq to qiime: http://www.wernerlab.org/software/macqiime/add-fastq-join-to-macqiime-1-8-0
#system("macqiime") don't run- crashes R!

#directories
fastq.filtered.dir
fastq.paired.dir
fastq.paired.write <- paste(fastq.paired.dir,"SFBR_joined",sep="")
fastq.scripts.dir <- paste(pipeline.dir,"SFBR_Scripts/",sep="")
fastq.convert.fasta.dir <- paste(pipeline.dir,"SFBR_paired_fastq_to_fasta/",sep="")
  
#pipeline.fastq.out.dir #*Data_out now filtered

#create script filenames
fastq.scripts <- sub("fastq","script",fastq.files.unfiltered)
fastq.scripts.wpath <- paste(fastq.scripts.dir,fastq.scripts,sep="")
fastq.scripts.wpath

#file names
fastq.files.filtered.wpath
fastq.files.paired.wpath <- paste(fastq.paired.dir, paste("paired_",fastq.files.unfiltered,sep=""),sep="") 
#paired.fastq.to.fasta.wpath <- paste("fasta_",
#fastq.files.filtered
#fastq.outfiles <- paste(fastq.filtered.dir,list.files(fastq.filtered.dir),sep="")
#fastq.outfiles.names <- sub(".fastq","",list.files(fastq.filtered.dir))
#fastq.outfiles

nfiles <- length(fastq.files.filtered)
qpy <- "/macqiime/bin/python "
Sys.which("macqiime")

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
  chmod <- "chmod 755 SFBR-Rain-Event-50*_S*_L001_R1_001.script"
  system(chmod)
  system(fastq.scripts.wpath[i])
  #change name of output
}

#paired output
joined_files_to_copy <- paste(fastq.files.paired.wpath,"/fastqjoin.join.fastq",sep="")[seq(1,10,by=2)]
joinedfiles <- paste("/fastq",500:504,sep="") #insert sample numbers here manually for now
joined_files_copied <- paste(fastq.paired.write,joinedfiles,sep="")
file.copy(joined_files_to_copy, joined_files_copied)

#Look for the fastjoin.join.fastq in the output_file folder, it is the joined fastq file. 
#Rename the file name to be more descriptive.
#Need to go into each paired_sample# directory and rename the fastjoin.join.fastq to append the sample name to it
#file names to convert to fasta (I manually renamed these and copied them into the /SFBR_joined directory for now)
fastq.paired.join.dir <- paste(fastq.paired.dir,"SFBR_joined",sep="")
file.exists(fastq.paired.join.dir)
fastq.files.joined <- list.files(fastq.paired.join.dir)
fastq.files.joined

#file commands to be run to convert fastq to fasta

fastq.to.fasta.command <- paste(py_join,"convert_fastaqual_fastq.py -c fastq_to_fastaqual -f ", joined_files_copied,
                                                 " -o ", fastq.convert.fasta.dir, sep="")

for(command in fastq.to.fasta.command){
  system(command)
}

