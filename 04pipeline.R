#We did part G first when we were doing this back in Septermber...this removes white space
#directories
filtered.dir
pipeline.dir
SFBR_notag.write.dir <- paste(pipeline.dir,"SFBR_notag/",sep = "")
list.files(SFBR_notag.write.dir)
headspace_remove.dir
chimeras_removed.dir <- paste(pipeline.dir,"SFBR_no_chimeras/",sep = "")

#seq filtered sample ids
nfiles.2 <- length(filtered.dir)
sample.id.3 <- NA
for(i in 1:nfiles.2){
  sample.id.3[i] <- substring(filtered.dir[i],55,57)
}
sample.id.3


#copy NoTrim files from each SeqFiltered sample directory
seqfiltered_files_to_copy <- paste(filtered.dir,"/result_dir/NoTag/NoTag_trimmed.fasta",sep = "")
seqfilteredfiles <- paste("/NoTag_trimmed_",sample.id.3,".fasta",sep = "")
seqfiltered_files_copied <- paste(SFBR_notag.write.dir,seqfilteredfiles,sep = "")
file.copy(seqfiltered_files_to_copy,seqfiltered_files_copied)

#file command
remove_whitespace.command <- paste("python ",headspace_remove.dir,"/Heading_Rename_Withspace_copy.py ", seqfiltered_files_copied,sep = "")

for(command in remove_whitespace.command){
  system(command)
}

# G Rename sequence heading using in-house python program if no random subsampling--DONE IN THIS STEP
# E.  Remove Chimera reads using usearch from http://www.drive5.com/usearch/ 
# F.	Optional: random subsample reads using in-house JAVA program or QIIME

# H.	Make mapping file
# I.	Build OTU table using QIIME
# J.	Summarize taxonomy using QIIME
# K.	Alpha analysis using QIIME
# L.	Beta analysis using QIIME
# M.	NMDS analysis using R
# N.	Heatmap generation using R