# E.  Remove Chimera reads using usearch from http://www.drive5.com/usearch/ 
ptm <- proc.time()
#Files with dimension
list.files(notag.write.dir)
list.files(modified.write.dir)
rmchimerafiles <- paste("rm_chimera_",sample.id.2,".fasta",sep = "")
rmchimerawithpath <- paste(rmchimera.dir,rmchimerafiles,sep = "")

#Delete any existing files in the modified headspace directory and removed chimeras directory
modified.notag.rm <- paste(modified.write.dir,list.files(modified.write.dir),sep="")
unlink(modified.notag.rm,recursive=FALSE,force=FALSE)
rmchimera.dir.rm <- paste(rmchimera.dir,list.files(rmchimera.dir),sep="")
unlink(rmchimera.dir.rm,recursive=FALSE,force=FALSE)

#copy Modified Headspace files from the notag directory to the modified_headspace directory
modified_files <- paste("NoTag_trimmed_",sample.id.2,"_Modified.fasta",sep = "")
modified_files_copied <- paste(notag.write.dir,"/",modified_files, sep = "")
file.copy(modified_files_copied,modified.write.dir)

#file command
remove_chimera.command <- paste(pipeline.dir,"usearch8.0.1517_i86osx32"," --uchime_ref ", modified_files_copied, " -db ", pipeline.dir, "gold.fa", " --nonchimeras ",rmchimerawithpath," -strand plus", sep = "")

for(command in remove_chimera.command){
  system(command)
}
rmchimerawithpath
proc.time() - ptm
