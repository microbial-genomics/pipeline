ptm <- proc.time()
Sys.info()
R.Version()

#library("rPython")
library("ShortRead")
library("Biostrings")
#library("data.table")

#git clone QIIME in terminal with
#git clone git://github.com/qiime/qiime.git Qiime

## CHECKING INSTALLATION of macqiime
#in terminal run "macqiime"
#then "print_qiime_config.py -t"

#to see what is in path
# echo "$PATH"

Sys.which("macqiime")
#Sys.which("fastq-join")
#Sys.which("join_paired_ends.py")

#Set system and data directory dependencies to work directly on machine
if(Sys.info()[4]=="Kens-MacBook-Air.local"|Sys.info()[4]=="kens-air"){
  pipeline.dir<-("/Users/KenBradshaw/git/pipeline/")
  data.dir <- "/Users/KenBradshaw/git/pipeline/"
  sickle.dir <- "/usr/bin/"
  qiime.dir <- "/macqiime/bin/"
  qpy <- "/macqiime/bin/python "
  seq_filter.dir <- "/RDPTools/SeqFilters/dist/"
}
#Change "remotedata" to "TRUE" to set system dependencies to run programs on machine and save data to an external hard drive.
remotedata = FALSE
if(Sys.info()[4]=="Kens-MacBook-Air.local" & remotedata|Sys.info()[4]=="kens-air" & remotedata){
  pipeline.dir<-("/Users/KenBradshaw/git/pipeline/")
  data.dir <- "/Volumes/oneTB/pipeline/"
  sickle.dir <- "/usr/bin/"
  qiime.dir <- "/macqiime/bin/"
  qpy <- "/macqiime/bin/python "
  seq_filter.dir <- "/RDPTools/SeqFilters/dist/"
}

file.exists(pipeline.dir)
file.exists(sickle.dir)
file.exists(qiime.dir)
file.exists(data.dir)

#edit terminal path as appropriate by modifying
#nano ~/.bash_profile

#set working directory
setwd(pipeline.dir) 
#setwd("/Users/KenBradshaw/Desktop/sfbr_metagenomic_example/sfbr_fastq_samples")
# A.  Download fastq files from https://basespace.illumina.com/home/index
#fastq is an ascii nucleotide sequence file format: http://en.wikipedia.org/wiki/FASTQ_format
#fastq also includes a read quality score, lowest to highest, for each nucleotide:
# !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~
#these are downloaded and live in

#Data and Script Directories
fastq.unfiltered.dir <- paste(data.dir,"unfiltered_NGS_data/",sep="") #Raw NGS Data Directory
fastq.filtered.dir <- paste(data.dir,"quality_filtered_data/",sep="") #Filtered Data Directory
filter.countseqs.dir <- paste(data.dir,"Seq_Counts/",sep="")#Directory to store pre and post trimmed seq counts
unfiltered.seqcounts.dir<- paste(filter.countseqs.dir,"Unfiltered_seq_counts/",sep="") #Unfiltered seq counts
filtered.seqcounts.dir<- paste(filter.countseqs.dir,"Filtered_seq_counts/",sep="") #Filtered seq counts
trimmed.singles.dir <- paste(fastq.filtered.dir,"trimmed.singles/",sep="") #Trimmed singles directory
fastq.paired.dir <- paste(data.dir,"data_paired/",sep="") #Paired Ends Data Directory
fastq.paired.join.dir <- paste(data.dir,"data_joined",sep="") #Directory with joined paired ends file names
fastq.scripts.dir <- paste(data.dir,"join_scripts/",sep="") #Directory with join paired ends scripts for each sample
fastq.convert.fasta.dir <- paste(data.dir,"paired_fastq_to_fasta/",sep="") #Directory with qual and fna names for each sample
filtered.dir <- paste(data.dir,"seqFiltered_data/",sep="") #Directory to save SeqFiltered files
notag.write.dir <- paste(data.dir,"notag_data",sep = "") #Directory to save removed headspace files to
modified.write.dir <- paste(data.dir,"modified_headspace_data/",sep = "") #Directory to copy removed headspace files to
rmchimera.dir <- paste(data.dir,"no_chimeras_data/",sep ="") #Directory to save removed chimeras files to
subsamp.dir<-paste(data.dir,"no_chimeras_subsampled_data/",sep="") #Directory to store random subsampled reads
subsamp_files_seqs.dir<-paste(subsamp.dir,"no_chimera_subsampled_wseqs/",sep="") #Directory to store unique subsampled sequence reads
seqs_in.dir<-paste(data.dir,"combined_seqs_in_otu/",sep="") #Directory to store denovo pick input file (combined sequences)
map.dir <- paste(data.dir,"mapping_files/",sep="") #mapping file directory
otu.dir <- paste(data.dir,"otus",sep="") #Directory to save pick denovo information
taxa_summary.dir<-paste(otu.dir,"/taxa_summary",sep="") #Directory to save taxa summary information
taxa_summary_plots.dir<-paste(taxa_summary.dir,"/taxa_summary_plots/",sep="") #Directory to save taxa summary plots
taxa_summary_out.dir<-paste(taxa_summary.dir,"/heatmaps/",sep="") #Directoy to save taxa summary heatmaps
arare.dir<-paste(otu.dir,"/alpha_rare/",sep="") #Directroy for alpha analysis
beta_out_dir <-paste(otu.dir,"/beta_dir/",sep="") #Directory for beta analysis

#mapping file
map_file<-"SFBR_RE_16S_mapping_file.txt"
map_file_wpath<-paste(map.dir,map_file,sep="")

#sample id file
sample.id.2<-read.csv(paste(data.dir,"sfbr.ids.csv",sep=""),as.is=TRUE)
sample.id.2 <- unlist(sample.id.2)

#Forward and reverse primer sequences for SeqFilters.jar in 03pipeline_filtersequence.R
forward.p <-"CAGCMGCCGCGGTAATWC"
reverse.p<-"CCGTCAATTCCTTTRAGGTT"

#number of reads to subsample in 06Subsample_sequences.R
m <- 5000 #user specifies the number of reads to subsample from each fasta file

# extra stuff in macqiime echo $PATH
#/macqiime/sw/bin:/macqiime/sw/sbin:/macqiime/QIIME/bin:/macqiime/bin:/macqiime/rtax-0.984:/macqiime/rtax-0.984/scripts:/macqiime/microbiomeutil_2010-04-29/ChimeraSlayer:/macqiime/microbiomeutil_2010-04-29/NAST-Ier:/macqiime/microbiomeutil_2010-04-29/WigeoN:/macqiime/blat

#Source Pipeline Scripts
source("01pipeline_filter_low_quality_reads_sickle.R")
source("02pipeline_join_paired_ends.R")
source("03pipeline_filtersequence.R")
source("04pipeline_remove_headspace.R")
source("05pipeline_remove_chimera_reads.R")
source("06Subsample_Sequences.R")
source("07pipeline_build_OTU_table.R")
source("08pipeline_summarize_taxonomy.R")
source("09pipeline_analysis.R")

proc.time() - ptm


