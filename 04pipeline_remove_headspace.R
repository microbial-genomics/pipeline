#G. removes white space from file headers

#Delete existing no_tag files prior to copying SeqFiltered files to notag.write direcotry 
#and running remove headspace script
SFBR_notag.write.dir.wpath <- paste(SFBR_notag.write.dir,"/",list.files(SFBR_notag.write.dir),sep="")
unlink(SFBR_notag.write.dir.wpath,recursive=FALSE,force=FALSE)

#seq filtered sample ids
nfiles.2 <- length(filtered.dir.wpath)
sample.id.3 <- NA
for(i in 1:nfiles.2){
  sample.id.3[i] <- substring(filtered.dir.wpath[i],55,57)
}
sample.id.3


#copy NoTrim files from each SeqFiltered sample directory
seqfiltered_files_to_copy <- paste(filtered.dir.wpath,"/result_dir/NoTag/NoTag_trimmed.fasta",sep = "")
seqfilteredfiles <- paste("/NoTag_trimmed_",sample.id.3,".fasta",sep = "")
seqfiltered_files_copied <- paste(SFBR_notag.write.dir,seqfilteredfiles,sep = "")
file.copy(seqfiltered_files_to_copy,seqfiltered_files_copied)

#file command
remove_whitespace.command <- paste("python ",headspace_remove.dir,"/Heading_Rename_Withspace_copy.py ", seqfiltered_files_copied,sep = "")

for(command in remove_whitespace.command){
  system(command)
}
