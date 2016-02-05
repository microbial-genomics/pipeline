#G. removes white space from file headers
ptm <- proc.time()
#Delete existing no_tag files prior to copying SeqFiltered files to notag.write direcotry 
#and running remove headspace script
notag.write.dir.wpath <- paste(notag.write.dir,"/",list.files(notag.write.dir),sep="")
unlink(notag.write.dir.wpath,recursive=FALSE,force=FALSE)

#copy NoTrim files from each SeqFiltered sample directory
seqfiltered_files_to_copy <- paste(filtered.dir.wpath,"/result_dir/NoTag/NoTag_trimmed.fasta",sep = "")
seqfilteredfiles <- paste("/NoTag_trimmed_",sample.id.2,".fasta",sep = "")
seqfiltered_files_copied <- paste(notag.write.dir,seqfilteredfiles,sep = "")
file.copy(seqfiltered_files_to_copy,seqfiltered_files_copied)

#file command
remove_whitespace.command <- paste("python ",pipeline.dir,"Heading_Rename_Whitespace.py ", seqfiltered_files_copied,sep = "")

for(command in remove_whitespace.command){
  system(command)
}

proc.time() - ptm
