# H.  Make mapping file--Manually
# I.  Build OTU table using QIIME
#Build OTU table using qiime and mapping file generated manually for SFBR samples

#Files with dimension
subsamp_file_seqs<-list.files(subsamp_files_seqs.dir,pattern="uq.fasta")
subsamp_file_seqs_wpath<-paste(subsamp_files_seqs.dir,subsamp_file_seqs,sep="")
pick_otu.script<-paste(pipeline.dir,"pick_otu.script",sep="")
#otu_rm.script<-paste(pipeline.dir,"otu_rm.script",sep="")

#Delete existing all_seqs.fasta and files in existing otu.cir file before creating new one
seqs_in_file_wpath <- paste(seqs_in.dir,seqs_in_file,sep="")
unlink(seqs_in_file_wpath,recursive=FALSE,force=FALSE)
otus.rm.wpath <- paste(otu.dir,"/",list.files(otu.dir),sep="")
unlink(otus.rm.wpath,recursive=TRUE,force=FALSE)

#combine sequences from all files and write to single fasta file
seqs_combined<-readDNAStringSet(subsamp_file_seqs_wpath,"fasta")
out <-writeFasta(seqs_combined,paste(seqs_in.dir,"SFBR_all_seqs.fasta",sep=""))

#input sequences file with path
seqs_in_file<-list.files(seqs_in.dir)
seqs_in_file_wpath<-paste(seqs_in.dir,seqs_in_file,sep="")

#file command to run pick_de_novo_otus.py
otus.command <- paste(qpy, py_join,"pick_de_novo_otus.py", " -i ",seqs_in_file_wpath," -o ", otu.dir," -f ",sep="")
write("#!/bin/bash",file=pick_otu.script,append=FALSE)
write("source /macqiime/configs/bash_profile.txt",file=pick_otu.script,append=TRUE)
write(otus.command, file=pick_otu.script,append=TRUE)
print(otus.command)
chmod <- "chmod 755 pick_otu.script"
system(chmod)
system(pick_otu.script)

#Remove singletons from OTU table
otu_w_singletons <- paste(otu.dir,"/", "otu_table.biom",sep="")
otu_singletons_rm <- paste(otu.dir, "/", "otu_table_no_singletons.biom",sep="")

#file command to remove singletons from otu table
otus.rm.singleton.commmand <- paste(qpy,py_join,"filter_otus_from_otu_table.py", " -i ", otu_w_singletons, " -o ",
                                    otu_singletons_rm, " -n 10",sep="")
for(command in otus.rm.singleton.commmand){
  system(command)
}
otu.no.singletons.file.wpath <- paste(otu.dir,"/","otu_table_no_singletons.biom",sep="")

