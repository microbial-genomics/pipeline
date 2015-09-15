#Make OTU network with mapping file
#directories
qpy
py_join
map.dir
map_file<-list.files(map.dir,pattern=".txt")
map_file_wpath<-paste(map.dir,map_file,sep="")
biom_file<-list.files(otu.dir,pattern=".biom")
biom_file_wpath<-paste(otu.dir,"/",biom_file,sep="")
otu.dir
#Make OTU network command--RUNS
otu_network.command<-paste(qpy, py_join,"make_otu_network.py", " -m ", map_file_wpath, " -i ",
                           biom_file_wpath, " -o ", otu.dir,sep="")
for(command in otu_network.command){
  system(command)
}
# J.  Summarize taxonomy using QIIME
#directories
biom_file_wpath
map_file_wpath
taxa_summary.dir<-paste(otu.dir,"/taxa_summary",sep="")
#summarize taxonomy command--RUNS
taxa.command<-paste(qpy, py_join, "summarize_taxa.py", " -i ",
                    biom_file_wpath, " -o ",taxa_summary.dir,sep="" )
for(command in taxa.command){
  system(command)
}
#taxomonmy plots directories
taxa_summary.dir
taxa_summary_files<-list.files(taxa_summary.dir)
taxa_otu_L2_file_wpath<-paste(taxa_summary.dir,"/",list.files(taxa_summary.dir,pattern="L2.txt"),sep="")
taxa_otu_L3_file_wpath<-paste(taxa_summary.dir,"/",list.files(taxa_summary.dir,pattern="L3.txt"),sep="")
taxa_otu_L4_file_wpath<-paste(taxa_summary.dir,"/",list.files(taxa_summary.dir,pattern="L4.txt"),sep="")
taxa_otu_L5_file_wpath<-paste(taxa_summary.dir,"/",list.files(taxa_summary.dir,pattern="L5.txt"),sep="")
taxa_otu_L6_file_wpath<-paste(taxa_summary.dir,"/",list.files(taxa_summary.dir,pattern="L6.txt"),sep="")
taxa_otu_files_in_wpath<-paste(taxa_otu_L2_file_wpath,",",taxa_otu_L3_file_wpath,",",
                               taxa_otu_L4_file_wpath,",",taxa_otu_L5_file_wpath,",",
                               taxa_otu_L6_file_wpath,sep="")
taxa_summary_plots.dir<-paste(taxa_summary.dir,"/taxa_summary_plots/",sep="")
#taxonomy plots command--RUNS
taxa_plots.command<-paste(qpy, py_join,"plot_taxa_summary.py", " -i ",taxa_otu_files_in_wpath,
                         " -o ", taxa_summary_plots.dir,sep="")
for(command in taxa_plots.command){
  system(command)
}

# K.	Alpha analysis using QIIME
# L.	Beta analysis using QIIME
# M.	NMDS analysis using R
# N.	Heatmap generation using R