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
#file command to run pick_de_novo_otus.py-DOES NOT RUN FROM R BUT RUNS FROM TERMINAL

otus.command <- paste(qpy, py_join,"pick_de_novo_otus.py", " -i ",seqs_in_file_wpath," -o ", otu.dir," -f ",sep="")
write("#!/bin/bash",file=po.script,append=FALSE)
write("source /macqiime/configs/bash_profile.txt",file=po.script,append=TRUE)
write(otus.command, file=po.script,append=TRUE)
print(otus.command)
chmod <- "chmod 755 po.script"
system(chmod)
system(po.script)

#for(command in otus.command){
#  system(command)
#}
#pick otus command file-DOES NOT RUN FROM R BUT RUNS FROM TERMINAL
#pick_otus.command<-paste(qpy, py_join,"pick_otus.py", " -i ",
#seqs_in_file_wpath," -o ", picked_otu.dir,sep="")
#for(command in pick_otus.command){
#system(command)
#}
#pic-rep otus directories
#picked_otus.dir <-paste(otu.dir,"/uclust_picked_otus/",sep="")
#picked_otus_file<-list.files(picked_otus.dir,pattern=".txt")
#picked_otus_file_wpath<-paste(picked_otus.dir,picked_otus_file,sep="")
#rep.dir<-paste(otu.dir,"/rep_set/",sep="")

#pick rep-otus command file--RUNS
#rep.command<-paste(qpy, py_join, "pick_rep_set.py", " -i ", picked_otus_file_wpath, " -f ",
#                   seqs_in_file_wpath, " -l ", rep.dir, "SFBR_all_seqs_rep_set.log", " -o ",
#                   rep.dir, "SFBR_all_seqs_rep_set.fasta", sep="")
#for(command in rep.command){
#  system(command)
#}
#assign taxonomy directories
#rep_set_file<-list.files(rep.dir,pattern=".fasta")
#rep_set_file_wpath<-paste(rep.dir,rep_set_file,sep="")
#assign.dir<-paste(otu.dir,"/uclust_assigned_taxonomy/",sep="")
#assign taxonomy command--DOES NOT RUN FROM R BUT RUNS FROM TERMINAL
#assign.command<-paste(qpy, py_join, "assign_taxonomy.py", " -i ", rep_set_file_wpath, " -o ",
#                      assign.dir,sep="")
#for(command in assign.command){
#  system(command)
#}
#make OTU table directories
#assign_files<-list.files(assign.dir,pattern=".txt")
#assign_files_wpath<-paste(assign.dir,assign_files,sep="")
#picked_otus_file_wpath
#otu_table_file_wpath<-paste(otu.dir,"/otu_table.biom",sep="")
#align sequences command--RUNS
#otu_table.command<-paste(qpy, py_join, "make_otu_table.py", " -i ", picked_otus_file_wpath,
#                     " -t ", assign_files_wpath, " -o ", otu_table_file_wpath,sep="")
#for(command in otu_table.command){
#  system(command)
#}
#align sequences directories
#rep_set_file_wpath
#aligned_seqs.dir<-paste(otu.dir,"/pynast_aligned_seqs",sep="")
#uclust<-"/macqiime/bin/uclust "
#template_path<-"/macqiime/lib/python2.7/site-packages/qiime_default_reference-0.1.1-py2.7.egg/qiime_default_reference/gg_13_8_otus/rep_set_aligned/85_otus.fasta "
#align sequences command--DOES NOT RUN FROM R BUT RUNS FROM TERMINAL
#align.command<-paste(qpy, py_join, "align_seqs.py"," -i ",rep_set_file_wpath, " -o ",
#                     aligned_seqs.dir,sep="")
#for(command in align.command){
#  system(command)
#}
#filter alignment directories
#aligned_seqs_files<-list.files(aligned_seqs.dir,pattern="aligned.fasta")
#aligned_seqs_files_wpath<-paste(aligned_seqs.dir,"/",aligned_seqs_files,sep="")
#aligned_seqs.dir
#filter alignment command--RUNS
#filter_alignment.command<-paste(qpy, py_join, "filter_alignment.py", " -i ",
#                                aligned_seqs_files_wpath, " -o ", aligned_seqs.dir,
#                                sep="")
#for(command in filter_alignment.command){
#  system(command)
#}
#phylogenetic tree directories
#filtered_aligned_seqs_files<-list.files(aligned_seqs.dir,pattern="pfiltered.fasta")
#filtered_aligned_seqs_files_wpath<-paste(aligned_seqs.dir,"/",filtered_aligned_seqs_files,sep="")
#tree_out<-paste(otu.dir,"/rep_set.tre",sep="")
#phylogenetic tree command--DOES NOT RUN FROM R BUT RUNS FROM TERMINAL
#tree.command<-paste(qpy, py_join, "make_phylogeny.py", " -i ", filtered_aligned_seqs_files_wpath,
#                    " -o ", tree_out,sep="")
#for(command in tree.command){
#  system(command)
#}


# J.	Summarize taxonomy using QIIME
# K.	Alpha analysis using QIIME
# L.	Beta analysis using QIIME
# M.	NMDS analysis using R
# N.	Heatmap generation using R
