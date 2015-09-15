# H.  Make mapping file--Manually
# I.  Build OTU table using QIIME
#Build OTU table using qiime and mapping file generated manually for SFBR samples

#directories
pipeline.dir
qiime.dir
qpy
py_join
subsamp_files_seqs.dir
subsamp_file_seqs<-list.files(subsamp_files_seqs.dir,pattern="uq.fasta")
subsamp_file_seqs_wpath<-paste(subsamp_files_seqs.dir,subsamp_file_seqs,sep="")
seqs_in.dir<-paste(pipeline.dir,"SFBR_seqs_in_otu/",sep="")
seqs_in_file<-list.files(seqs_in.dir)
seqs_in_file_wpath<-paste(seqs_in.dir,seqs_in_file,sep="")
otu.dir <- paste(pipeline.dir,"otus",sep="")
picked_otu.dir<-paste(otu.dir,"/uclust_picked_otus/",sep="")
po.script<-paste(pipeline.dir,"po.script",sep="")


#combine sequences from all files and write to single fasta file
seqs_combined<-readDNAStringSet(subsamp_file_seqs_wpath,"fasta")
out <-writeFasta(seqs_combined,paste(seqs_in.dir,"SFBR_all_seqs.fasta",sep=""))
list.files(seqs_in.dir)
#file command to run pick_de_novo_otus.py-DOES NOT RUN FROM R BUT RUNS FROM TERMINAL


otus.command <- paste(qpy, py_join,"pick_de_novo_otus.py", " -i ",seqs_in_file_wpath," -o ", otu.dir," -f ",sep="")
write("#!/bin/bash",file=po.script,append=FALSE)
write("source /macqiime/configs/bash_profile.txt",file=po.script,append=TRUE)
write(otus.command, file=po.script,append=TRUE)
print(otus.command)
chmod <- "chmod 755 po.script"
system(chmod)
system(po.script)

# J.	Summarize taxonomy using QIIME
# K.	Alpha analysis using QIIME
# L.	Beta analysis using QIIME
# M.	NMDS analysis using R
# N.	Heatmap generation using R
