Sys.info()
R.Version()

library(rPython)

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
  qiime.dir <- "/macqiime/QIIME/bin/" 
  py_join <- "/macqiime/QIIME/bin/"
  seq_filter.dir <- ""
  #occfigs<-path.expand("~/Dropbox/occupancy_revisions/figures/")
}
if(Sys.info()[4]=="kens-air"){
  pipeline.dir<-path.expand("~/git/pipeline/")
  fastq.dir <- "/usr/local/Cellar/fastx_toolkit/0.0.14/bin/"
  fastq_join.dir <- "/macqiime/bin/fastq-join"
  qiime.dir <- path.expand("~/Documents/qiime/MacQIIME_1.8.0-20140103_OS10.6/macqiime/QIIME/bin/")
  py_join <- "/macqiime/QIIME/bin/"
  seq_filter.dir <- "/Users/KenBradshaw/Desktop/sfbr_metagenomic_example/sfbr_fastq_samples/RDPTools/SeqFilters/dist/"
  #occfigs<-path.expand("~/Dropbox/occupancy_revisions/figures/")
  headspace_remove.dir <- "/Users/KenBradshaw/git/pipeline"
  usearch.dir <- "/Users/KenBradshaw/git/pipeline/"
}
if(Sys.info()[4]=="Kens-MacBook-Air.local"){
  pipeline.dir<-path.expand("~/git/pipeline/")
  fastq.dir <- "/usr/local/Cellar/fastx_toolkit/0.0.14/bin/"
  fastq_join.dir <- "/macqiime/bin/fastq-join"
  qiime.dir <- path.expand("~/Documents/qiime/MacQIIME_1.8.0-20140103_OS10.6/macqiime/QIIME/bin/")
  py_join <- "/macqiime/QIIME/bin/"
  seq_filter.dir <- "/Users/KenBradshaw/Desktop/sfbr_metagenomic_example/sfbr_fastq_samples/RDPTools/SeqFilters/dist/"
  #occfigs<-path.expand("~/Dropbox/occupancy_revisions/figures/")
  headspace_remove.dir <- "/Users/KenBradshaw/git/pipeline"
  usearch.dir <- "/Users/KenBradshaw/git/pipeline/"
}
if(Sys.info()[4]=="blakes-mbp"){
  pipeline.dir<-path.expand("~/Dropbox/pipeline/")
  fastq.dir <- "/usr/local/bin/fastq_quality_trimmer"
  qiime.dir <- "~/Documents/macqiime/QIIME/bin/"
  #occfigs<-path.expand("~/Dropbox/occupancy_revisions/figures/")
}

file.exists(pipeline.dir)
file.exists(fastq.dir)
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
fastq.unfiltered.dir <- paste(pipeline.dir,"SFBR_Data/",sep="")
fastq.filtered.dir <- paste(pipeline.dir,"SFBR_Data_filtered/",sep="")
fastq.paired.dir <- paste(pipeline.dir,"SFBR_Data_paired/",sep="")
fastq.files.unfiltered <- list.files(fastq.unfiltered.dir)

# extra stuff in macqiime echo $PATH
#/macqiime/sw/bin:/macqiime/sw/sbin:/macqiime/QIIME/bin:/macqiime/bin:/macqiime/rtax-0.984:/macqiime/rtax-0.984/scripts:/macqiime/microbiomeutil_2010-04-29/ChimeraSlayer:/macqiime/microbiomeutil_2010-04-29/NAST-Ier:/macqiime/microbiomeutil_2010-04-29/WigeoN:/macqiime/blat

