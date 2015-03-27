# E.  Remove Chimera reads using usearch from http://www.drive5.com/usearch/ 
#directories
pipeline.dir
usearch.dir
SFBR_notag.write.dir
list.files(SFBR_notag.write.dir)
modified.write.dir <- paste(pipeline.dir,"SFBR_modified_headspace/",sep = "")
file.exists(modified.write.dir)
list.files(modified.write.dir)
rmchimera.dir <- paste(pipeline.dir,"SFBR_no_chimeras",sep ="")
rmchimerafiles <- paste("/rm_chimera_",500:504,".fasta",sep = "")
rmchimerawithpath <- paste(rmchimera.dir,rmchimerafiles,sep = "")


#copy Modified Headspace files from the SFBR_notag directory to the SFBR_modified_headspace directory
modified_files <- paste("NoTag_trimmed_",500:504,"_Modified.fasta",sep = "")
modified_files_copied <- paste(SFBR_notag.write.dir,modified_files, sep = "")
file.copy(modified_files_copied,modified.write.dir)

#file command
remove_chimera.command <- paste(usearch.dir,"usearch8.0.1517_i86osx32"," --uchime_ref ", modified_files_copied, " -db ", usearch.dir, "gold.fa", " --nonchimeras ",rmchimerawithpath," -strand plus", sep = "")

for(command in remove_chimera.command){
  system(command)
}
> # F.  Optional: random subsample reads using in-house JAVA program or QIIME
  > 
  > # H.	Make mapping file
  > # I.	Build OTU table using QIIME
  > # J.	Summarize taxonomy using QIIME
  > # K.	Alpha analysis using QIIME
  > # L.	Beta analysis using QIIME
  > # M.	NMDS analysis using R
  > # N.	Heatmap generation using R