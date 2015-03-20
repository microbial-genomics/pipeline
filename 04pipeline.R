#We did part G first when we were doing this back in Septermber...this removes white space
#you have to specify the path in line 3 of the "Heading_Rename_Whitespace.py" file
#and also change the sample number to the correct sampled in line 18.  So for sample #500
#I changed the directory to /Users/KenBradshaw/git/pipeline/SFBR_barcode_filtered/barcode_filtered_SFBR-Rain-Event-500_S1_L001_R1_001.fasta/result_dir/NoTag/NoTag_trimmed.fasta
#in line 3 and the sample name to >500 in line 18, then I ran
#python Heading_Rename_Withspace.py" from the pipeline directory and a new file was created
#in /Users/KenBradshaw/git/pipeline/SFBR_barcode_filtered/barcode_filtered_SFBR-Rain-Event-500_S1_L001_R1_001.fasta/result_dir/NoTag/
#called NoTag_trimmed_Modified.fasta

# E.  Remove Chimera reads using usearch from http://www.drive5.com/usearch/ 
# F.	Optional: random subsample reads using in-house JAVA program or QIIME
# G.	Rename sequence heading using in-house python program if no random subsampling
# H.	Make mapping file
# I.	Build OTU table using QIIME
# J.	Summarize taxonomy using QIIME
# K.	Alpha analysis using QIIME
# L.	Beta analysis using QIIME
# M.	NMDS analysis using R
# N.	Heatmap generation using R