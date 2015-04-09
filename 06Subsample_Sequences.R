# F.  Optional: random subsample reads using in-house R script and ShortRead and BioStrings Packages
#directories
rmchimera.dir
no_chimera_files <- list.files(rmchimera.dir)
subsamp.dir<-paste(pipeline.dir,"SFBR_no_chimeras_subsampled/",sep="")

subsamp_files<-list.files(subsamp.dir,pattern=".fasta")
subsamp_files_wpath<-paste(subsamp.dir,subsamp_files,sep="")
subsamp_files_seqs.dir<-paste(subsamp.dir,"SFBR_subsampled_wseqs/",sep="")

pipeline.dir
qiime.dir
qpy
py_join

#directory<-"/Users/KenBradshaw/git/pipeline/SFBR_no_chimeras/"
#directory_sub<-"/Users/KenBradshaw/git/pipeline/SFBR_no_chimeras_subsampled/"

no_chimera_files_wpath<-paste(rmchimera.dir,no_chimera_files,sep="")
i=1
j=1
k=1
file_list <- list()
fas.subset<- list()
seq_count<- vector()
file_names<-list.files(rmchimera.dir)
n<-length(no_chimera_files_wpath)
for (i in 1:n){
  current_file <- no_chimera_files_wpath[i]
  file_list[[i]]<-readDNAStringSet(current_file,"fasta")
  seq_count[[i]]<-length(file_list[[i]]) 
}  
seq_count
min_seq<-min(seq_count)

m <- min_seq

i=1
j=1
k=1
for (j in 1:n){
  current_file <- no_chimera_files_wpath[j]
  current_file_name <- file_names[j]
  file_list[[j]]<-readDNAStringSet(current_file,"fasta")
  for (k in 1:n){
    fas.subset[[k]] <- file_list[[j]][sample(length(file_list[[j]]),m)]

    fas.subset.out <- writeFasta(fas.subset[[k]],paste(subsamp.dir, current_file_name,"sub.fasta", sep=""))
  }
}


#File Command:  Count Sequences in the subsampled data to be sure they are equal
#counts each individual file:  count_seqs.command <- paste(qpy,py_join,"count_seqs.py"," -i ",rmchimera.dir,"/",no_chimera_files," -o ",rmchimera.dir,"/",no_chimera_files,".seq_counts.txt",sep="")
count_seqs.command <- paste(qpy,py_join,"count_seqs.py"," -i ", '"',subsamp.dir, "*.fasta",'"', " -o ",
                            subsamp.dir,"sub_seq_counts.txt",sep="")

for(command in count_seqs.command){
  system(command)
}


seqnames <-as.character(seq(1,m,1))
samples_m<-matrix(500:504)
samples<-as.list(samples_m)
samples <- as.character(list(500,501,502,503,504)) #Manually create a list of samples names maybe we can automate this at some point
newname<- list()
z=length(subsamp_files_wpath)
p=1
for (p in 1:z){
  current_file<-subsamp_files_wpath[p]
  current_file_name<-file_names[p]
  file_list[[p]]<-readDNAStringSet(current_file,"fasta")
  newname[[p]] <- paste(samples[[p]],"_",seqnames,sep="") 
  file_list[[p]]@ranges@NAMES <- newname[[p]]
  out <- writeFasta(file_list[[p]],paste(subsamp_files_seqs.dir, 
                                         current_file_name,"_seqs_uq.fasta", sep=""))
}

# H.  Make mapping file--Manually
# I.	Build OTU table using QIIME
# J.	Summarize taxonomy using QIIME
# K.	Alpha analysis using QIIME
# L.	Beta analysis using QIIME
# M.	NMDS analysis using R
# N.	Heatmap generation using R

