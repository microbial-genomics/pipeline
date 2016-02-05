# F.  Randomly subsample reads using ShortRead and BioStrings Packages
#Files with dimension
ptm <- proc.time()
no_chimera_files <- list.files(rmchimera.dir)
no_chimera_files_wpath<-paste(rmchimera.dir,no_chimera_files,sep="")
unique_files_wpath <-paste(subsamp_files_seqs.dir,list.files(subsamp_files_seqs.dir),sep="") 

#Delete existing subsampled files and unique subsampled files before running subsampling scripts
#unlink(subsamp_files_wpath,recursive=FALSE,force=FALSE)
unlink(unique_files_wpath,recursive=FALSE,force=FALSE)

i=1
j=1
k=1
file_list <- list()
fas.subset<- list()
seq_count<- vector()

n <- length(no_chimera_files_wpath)

for (i in 1:n){
  current_file <- no_chimera_files_wpath[i]
  file_list[[i]]<-readDNAStringSet(current_file,"fasta")
  seq_count[[i]]<-length(file_list[[i]]) 
}  
seq_count
#min(seq_count)
no_chimera_wpath_min_seq <- no_chimera_files_wpath[which(seq_count>m)]

#no chimera seq min sample ids
nfiles.3 <- length(no_chimera_wpath_min_seq)

#file_names<-sample.id.2

file_list <- list()
i=1
j=1
k=1
q <-length(no_chimera_wpath_min_seq)
for (j in 1:q){
  current_file <- no_chimera_wpath_min_seq[j]
  current_file_name <- sample.id.2[j]
  file_list[[j]]<-readDNAStringSet(current_file,"fasta")
  for (k in 1:q){
    fas.subset[[k]] <- file_list[[j]][sample(length(file_list[[j]]),m)]

    fas.subset.out <- writeFasta(fas.subset[[k]],paste(subsamp.dir, current_file_name,"_sub.fasta", sep=""))
  }
}

list.files(subsamp.dir)
#File Command:  Count Sequences in the subsampled data to be sure they are equal
#counts each individual file:  count_seqs.command <- paste(qpy,py_join,"count_seqs.py"," -i ",rmchimera.dir,"/",no_chimera_files," -o ",rmchimera.dir,"/",no_chimera_files,".seq_counts.txt",sep="")
count_seqs.command <- paste(qpy,qiime.dir,"count_seqs.py"," -i ", '"',subsamp.dir, "*.fasta",'"', " -o ",
                            subsamp.dir,"sub_seq_counts.txt",sep="")

for(command in count_seqs.command){
  system(command)
}
checked.sequence.counts <- paste(subsamp.dir,"sub_seq_counts.txt",sep="")
checked.sequence.counts
#Subsampled files with dimension
subsamp_files<-list.files(subsamp.dir,pattern=".fasta")
subsamp_files_wpath<-paste(subsamp.dir,subsamp_files,sep="")


seqnames <-as.character(seq(1,m,1))
samples <- as.character(sample.id.2)
newname<- list()
file_list<- list()
z=length(no_chimera_wpath_min_seq)
p=1
for (p in 1:z){
  current_file<-subsamp_files_wpath[p]
  current_file_name<-sample.id.2[p]
  file_list[[p]]<-readDNAStringSet(current_file,"fasta")
  newname[[p]] <- paste(samples[[p]],"_",seqnames,sep="") 
  file_list[[p]]@ranges@NAMES <- newname[[p]]
  out <- writeFasta(file_list[[p]],paste(subsamp_files_seqs.dir, 
                                         current_file_name,"_seqs_uq.fasta", sep=""))
}
#NOTE:  there is nothing in the "out" variable but the files are written to the subsamp_files_seqs.dir
sub.seqs.wpath <- paste(subsamp_files_seqs.dir,list.files(subsamp_files_seqs.dir),sep="")
proc.time() - ptm
