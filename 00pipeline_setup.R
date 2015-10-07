ptm <- proc.time()
Sys.info()
R.Version()

library("rPython")
library("ShortRead")
library("Biostrings")

#git clone QIIME in terminal with
#git clone git://github.com/qiime/qiime.git Qiime

## CHECKING INSTALLATION of macqiime
#in terminal run "macqiime"
#then "print_qiime_config.py -t"

#to see what is in path
# echo "$PATH"

Sys.which("macqiime")
Sys.which("fastq_quality_trimmer")
Sys.which("fastq-join")
Sys.which("join_paired_ends.py")

if(Sys.getenv("LOGNAME")=="puruckertom"){ #macqiime is on root on the mac hard drive
  pipeline.dir<-path.expand("~/Dropbox/pipeline/")
  fastq.dir <- "/usr/local/bin/"
  fastq_join.dir <- "/macqiime/bin/fastq-join"
  qiime.dir <- "/macqiime/bin/" 
  py_join <- "/macqiime/bin/"
  seq_filter.dir <- ""
  #occfigs<-path.expand("~/Dropbox/occupancy_revisions/figures/")
}
if(Sys.info()[4]=="kens-air"){
  pipeline.dir<-path.expand("~/git/pipeline/")
  #fastq.dir <- "/usr/local/Cellar/fastx_toolkit/0.0.14/bin/"
  sickle.dir <- "/usr/bin/"
  fastq_join.dir <- "/macqiime/bin/fastq-join"
  qiime.dir <- "/macqiime/bin/"
  py_join <- "/macqiime/bin/"
  qpy <- "/macqiime/bin/python "
  seq_filter.dir <- "/Users/KenBradshaw/Desktop/sfbr_metagenomic_example/sfbr_fastq_samples/RDPTools/SeqFilters/dist/"
  headspace_remove.dir <- "/Users/KenBradshaw/git/pipeline"
  usearch.dir <- "/Users/KenBradshaw/git/pipeline/"
  map.dir <- "/Users/KenBradshaw/git/pipeline/SFBR_mapping_files/"
}
if(Sys.info()[4]=="Kens-MacBook-Air.local"){
  pipeline.dir<-path.expand("~/git/pipeline/")
  #fastq.dir <- "/usr/local/Cellar/fastx_toolkit/0.0.14/bin/"
  sickle.dir <- "/usr/bin/"
  fastq_join.dir <- "/macqiime/bin/fastq-join"
  qiime.dir <- "/macqiime/bin/"
  py_join <- "/macqiime/bin/"
  qpy <- "/macqiime/bin/python "
  seq_filter.dir <- "/Users/KenBradshaw/Desktop/sfbr_metagenomic_example/sfbr_fastq_samples/RDPTools/SeqFilters/dist/"
  headspace_remove.dir <- "/Users/KenBradshaw/git/pipeline"
  usearch.dir <- "/Users/KenBradshaw/git/pipeline/"
  map.dir <- "/Users/KenBradshaw/git/pipeline/SFBR_mapping_files/"
}


file.exists(pipeline.dir)
file.exists(sickle.dir)
file.exists(fastq_join.dir)
file.exists(qiime.dir)

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
fastq.unfiltered.dir <- paste(pipeline.dir,"SFBR_Data/",sep="") #Raw NGS Data Directory
fastq.filtered.dir <- paste(pipeline.dir,"SFBR_Data_filtered/",sep="") #Filtered Data Directory
trimmed.singles.dir <- paste(fastq.filtered.dir,"trimmed.singles/",sep="")
fastq.paired.dir <- paste(pipeline.dir,"SFBR_Data_paired/",sep="") #Paired Ends Data Directory
fastq.paired.write <- paste(fastq.paired.dir,"SFBR_joined",sep="") #Directory to write joined file names to
fastq.scripts.dir <- paste(pipeline.dir,"SFBR_Scripts/",sep="") #Directory with join paired ends scripts for each sample
fastq.convert.fasta.dir <- paste(pipeline.dir,"SFBR_paired_fastq_to_fasta/",sep="") #Directory with qual and fna names for each sample
fastq.paired.join.dir <- paste(pipeline.dir,"SFBR_joined",sep="") #Directory with joined paired ends file names
filtered.dir <- paste(pipeline.dir,"SFBR_SeqFiltered/",sep="") #Directory to save SeqFiltered files
SFBR_notag.write.dir <- paste(pipeline.dir,"SFBR_notag",sep = "") #Directory to save removed headspace files to
modified.write.dir <- paste(pipeline.dir,"SFBR_modified_headspace/",sep = "") #Directory to copy removed headspace files to
rmchimera.dir <- paste(pipeline.dir,"SFBR_no_chimeras/",sep ="") #Directory to save removed chimeras files to
subsamp.dir<-paste(pipeline.dir,"SFBR_no_chimeras_subsampled/",sep="") #Directory to store random subsampled reads
subsamp_files_seqs.dir<-paste(subsamp.dir,"SFBR_subsampled_wseqs/",sep="") #Directory to store unique subsampled sequence reads
seqs_in.dir<-paste(pipeline.dir,"SFBR_seqs_in_otu/",sep="") #Directory to store denovo pick input file (combined sequences)
otu.dir <- paste(pipeline.dir,"otus",sep="") #Directory to save pick denovo information
picked_otu.dir<-paste(otu.dir,"/uclust_picked_otus/",sep="") #Directory to save picked otus
taxa_summary.dir<-paste(otu.dir,"/taxa_summary",sep="") #Directory to save taxa summary information
taxa_summary_plots.dir<-paste(taxa_summary.dir,"/taxa_summary_plots/",sep="") #Directory to save taxa summary plots
taxa_summary_out.dir<-paste(taxa_summary.dir,"/otu/",sep="") #Directoy to save taxa summary outut
arare.dir<-paste(otu.dir,"/alpha_rare/",sep="") #Directroy for alpha analysis
beta_out_dir <-paste(otu.dir,"/beta_dir/",sep="") #Directory for beta analysis

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
source("09pipeline_alpha_analysis.R")

proc.time() - ptm


