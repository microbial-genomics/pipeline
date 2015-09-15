# D.	Filter out the primer/barcode sequence using SeqFilters.jar from 
#https://github.com/rdpstaff/SeqFilters

#directories
pipeline.dir
fastq.convert.fasta.dir
fasta.files <-paste(fastq.convert.fasta.dir,list.files(fastq.convert.fasta.dir,pattern="fna"),sep="")
filtered.dir <- paste(pipeline.dir,"SFBR_SeqFiltered/",paste(list.files(fastq.convert.fasta.dir,pattern="fna"),sep=""),sep="")
seq_filter.dir

#D. Filter out the primer/barcode sequence
#1.  Download SeqFilters.jar from https://github.com/rdpstaff/SeqFilters 
#2.  Run SeqFilters.jar with this command: java -jar /path/to/SeqFilters.jar

#File command

seqfilter.command <- paste("java -jar ",seq_filter.dir, "SeqFilters.jar", " --forward-primers CAGCMGCCGCGGTAATWC --max-forward 2 --reverse-primers CCGTCAATTCCTTTRAGGTT --max-reverse 1 --seq-file ", fasta.files,
                                " -o ", filtered.dir, sep="")                          
for(command in seqfilter.command){
  system(command)
}



#--forward-primers CAGCMGCCGCGGTAATWC --max-forward 2 --reverse-primers CCGTCAATTCCTTTRAGGTT --max-reverse 1 --seq-file seq_input.fasta –o output_directory_name   the path is (/Users/KenBradshaw/Desktop/sfbr_metagenomic_example/sfbr_fastq_samples/RDPTools/SeqFilters/dist/SeqFilters.jar)

#Example for java run of SeqFilter.jar: java -jar /Users/KenBradshaw/Desktop/sfbr_metagenomic_example/sfbr_fastq_samples/RDPTools/SeqFilters/dist/SeqFilters.jar 
#--forward-primers CAGCMGCCGCGGTAATWC --max-forward 2 --reverse-primers CCGTCAATTCCTTTRAGGTT 
#--max-reverse 1 --seq-file fastqjoin.join.fna 
#-o /Users/KenBradshaw/git/pipeline/SFBR_barcode_filtered/barcode_filtered_SFBR-Rain-Event-500_S1_L001_R1_001.fasta
#This created a directory with the sample name containing the filtered data
#The seqfiltered data we need is called noTag_trimmed.fasta
#NOTE..if the filtered files already exist and you run this script again you get an error..need to figure out how we can
#overwrite so that errors is not thrown.
