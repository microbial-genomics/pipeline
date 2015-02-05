Sys.info()
R.Version()

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
  fastq.dir <- "/usr/local/bin/fastq_quality_trimmer/"
  fastq_join.dir <- "/macqiime/bin/fastq-join"
  qiime.dir <- "/macqiime/QIIME/bin/"
  #occfigs<-path.expand("~/Dropbox/occupancy_revisions/figures/")
}
if(Sys.info()[4]=="kens-air"){
  pipeline.dir<-path.expand("~/Dropbox/pipeline/")
  fastq.dir <- "/usr/local/Cellar/fastx_toolkit/0.0.14/bin"
  fastq_join.dir <- "/macqiime/bin/fastq-join"
  qiime.dir <- path.expand("~/Documents/qiime/MacQIIME_1.8.0-20140103_OS10.6/macqiime/QIIME/bin/")
  py_join <- "/macqiime/QIIME/bin/"
  #occfigs<-path.expand("~/Dropbox/occupancy_revisions/figures/")
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
pipeline.fastq.dir <- paste(pipeline.dir,"SFBR_Data/",sep="")
pipeline.fastq.out.dir <- paste(pipeline.dir,"SFBR_Data_out/",sep="")
pipeline.fastq.paired.dir <- paste(pipeline.dir,"SFBR_Data_paired/",sep="")
fastq.files <- list.files(pipeline.fastq.dir)
fastq.files #10 files

# B.	Filter low quality reads using fastq quality trimmer from FASTX.
for(file in fastq.files){
  update.file <- paste(pipeline.fastq.dir,file,sep="")
  out.file <- paste("out_",file,sep="")
  update.outfile <- paste(pipeline.fastq.out.dir,out.file,sep="")
  print(update.file)
  print(out.file)
  file.command  <- paste("fastq_quality_trimmer -t 20 -Q33 -i ",update.file, " -o ", update.outfile,sep="")
  print(file.command)
  #system("fastq_quality_trimmer")
  system(file.command)
}

# C.	Join paired end reads using join_paired_ends.py from QIIME 
# install macqiime: http://www.wernerlab.org/software/macqiime/macqiime-installation
#also fastq to qiime: http://www.wernerlab.org/software/macqiime/add-fastq-join-to-macqiime-1-8-0
#system("macqiime") don't run- crashes R!
fastq.outfiles <- paste(pipeline.fastq.out.dir,list.files(pipeline.fastq.out.dir),sep="")
fastq.outfiles.2 <- sub(".fastq","",list.files(pipeline.fastq.out.dir))
fastq.outfiles
nfiles <- length(fastq.outfiles)
qpy <- "/macqiime/bin/python "
Sys.which("macqiime")
for(i in seq(1,nfiles,2)){
  print(i)
  fastq.paired.file <- paste(pipeline.fastq.paired.dir,paste("paired_",fastq.outfiles.2[i],sep=""),sep="")  
  join.paired.ends.command <- paste(qpy,py_join,"join_paired_ends.py",sep="")
  file.exists(fastq.paired.file)
  file.exists(fastq.outfiles[i])
  file.exists(fastq.outfiles[i+1])
  file.exists(fastq.paired.file)
  file.command <- paste(join.paired.ends.command ," -f ", fastq.outfiles[i], " -r ", fastq.outfiles[i+1],
                        " -o ", fastq.paired.file, sep="")
  print(file.command)
  system(file.command)
}

# D.	Filter out the primer/barcode sequence using SeqFilters.jar from https://github.com/rdpstaff/SeqFilters
# E.	Remove Chimera reads using usearch from http://www.drive5.com/usearch/ 
# F.	Optional: random subsample reads using in-house JAVA program or QIIME
# G.	Rename sequence heading using in-house python program if no random subsampling
# H.	Make mapping file
# I.	Build OTU table using QIIME
# J.	Summarize taxonomy using QIIME
# K.	Alpha analysis using QIIME
# L.	Beta analysis using QIIME
# M.	NMDS analysis using R
# N.	Heatmap generation using R
