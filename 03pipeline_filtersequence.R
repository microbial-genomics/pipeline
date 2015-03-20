# D.	Filter out the primer/barcode sequence using SeqFilters.jar from 
#https://github.com/rdpstaff/SeqFilters


#D. Filter out the primer/barcode sequence
#1.  Download SeqFilters.jar from https://github.com/rdpstaff/SeqFilters 
#2.  Run SeqFilters.jar with this command: java -jar /path/to/SeqFilters.jar
#--forward-primers CAGCMGCCGCGGTAATWC --max-forward 2 --reverse-primers CCGTCAATTCCTTTRAGGTT --max-reverse 1 --seq-file seq_input.fasta –o output_directory_name   the path is (/Users/KenBradshaw/Desktop/sfbr_metagenomic_example/sfbr_fastq_samples/RDPTools/SeqFilters/dist/SeqFilters.jar)

#first I created a directory in pipeline called SFBR_barcode_filtered
#then from the directory containing the .fna file created in the last step of 02pipeline
#I ran java -jar /Users/KenBradshaw/Desktop/sfbr_metagenomic_example/sfbr_fastq_samples/RDPTools/SeqFilters/dist/SeqFilters.jar 
#--forward-primers CAGCMGCCGCGGTAATWC --max-forward 2 --reverse-primers CCGTCAATTCCTTTRAGGTT 
#--max-reverse 1 --seq-file fastqjoin.join.fna 
#-o /Users/KenBradshaw/git/pipeline/SFBR_barcode_filtered/barcode_filtered_SFBR-Rain-Event-500_S1_L001_R1_001.fasta
#This created a directory with the sample name containing the filtered data
#The data ends up being under /Users/KenBradshaw/git/pipeline/SFBR_barcode_filtered/barcode_filtered_SFBR-Rain-Event-500_S1_L001_R1_001.fasta/result_dir/NoTag
#named NoTag_trimmed.fasta
#We will have to set the paths to wherever the SeqFilter.jar file is located on the 
#local machine.  Mine's in the desktop SFBR examples folder.  Maybe it should be moved
#or redownloaded to the /usr/local directory for easier access