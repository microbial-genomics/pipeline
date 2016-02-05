#Make OTU network with mapping file
ptm <- proc.time()
#Files with dimension
otu.no.singletons.file.wpath

#Make OTU network command--RUNS
otu_network.command<-paste(qpy, qiime.dir,"make_otu_network.py", " -m ", map_file_wpath, " -i ",
                           otu.no.singletons.file.wpath, " -o ", otu.dir,sep="")
for(command in otu_network.command){
  system(command)
}
# J.  Summarize taxonomy using QIIME

#summarize taxonomy command--RUNS
taxa.command<-paste(qpy, qiime.dir, "summarize_taxa.py", " -i ", otu.no.singletons.file.wpath," -o ",taxa_summary.dir,sep="")
for(command in taxa.command){
  system(command)
}
#Files with dimension for taxomonmy plots directories
taxa_summary_files<-list.files(taxa_summary.dir)
taxa_otu_L2_file_wpath<-paste(taxa_summary.dir,"/",list.files(taxa_summary.dir,pattern="L2.txt"),sep="")
taxa_otu_L3_file_wpath<-paste(taxa_summary.dir,"/",list.files(taxa_summary.dir,pattern="L3.txt"),sep="")
taxa_otu_L4_file_wpath<-paste(taxa_summary.dir,"/",list.files(taxa_summary.dir,pattern="L4.txt"),sep="")
taxa_otu_L5_file_wpath<-paste(taxa_summary.dir,"/",list.files(taxa_summary.dir,pattern="L5.txt"),sep="")
taxa_otu_L6_file_wpath<-paste(taxa_summary.dir,"/",list.files(taxa_summary.dir,pattern="L6.txt"),sep="")
taxa_otu_files_in_wpath<-paste(taxa_otu_L2_file_wpath,",",taxa_otu_L3_file_wpath,",",
                               taxa_otu_L4_file_wpath,",",taxa_otu_L5_file_wpath,",",
                               taxa_otu_L6_file_wpath,sep="")

#taxonomy plots command--RUNS
taxa_plots.command<-paste(qpy, qiime.dir,"plot_taxa_summary.py", " -i ",taxa_otu_files_in_wpath,
                         " -o ",taxa_summary_plots.dir,sep="")
for(command in taxa_plots.command){
  system(command)
}
##HTML files to view summarized taxa plots
area.charts.wpath <- paste(taxa_summary_plots.dir,"area_charts.html",sep="")
bar.charts.wpath <- paste(taxa_summary_plots.dir,"bar_charts.html",sep="")
area.charts.wpath
bar.charts.wpath
proc.time() - ptm
