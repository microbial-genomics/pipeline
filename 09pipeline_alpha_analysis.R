#make individual heat maps
#directories
qpy
py_join
taxa_summary.dir
taxa_summary_files
taxa_summary_files<-list.files(taxa_summary.dir,pattern=".biom")
taxa_summary_files_wpath<-paste(taxa_summary.dir,"/",taxa_summary_files,sep="")
n=length(taxa_summary_files_wpath)
taxa_summary_out.dir<-paste(taxa_summary.dir,"/otu/",sep="")
taxa_summary_out_files<-paste(taxa_summary_out.dir,"L",2:5,"_heatmap",sep="")
#heatmap command
heatmap.command<-paste(qpy, py_join,"make_otu_heatmap.py", " -i ", taxa_summary_files_wpath,
                       " -o ",taxa_summary_out_files, sep="")
for(command in heatmap.command){
  system(command)
}
# K.  Alpha analysis using QIIME
#directories
biom_file_wpath
map_file_wpath
arare.dir<-paste(otu.dir,"/alpha_rare/",sep="")
tree_file<-paste(otu.dir,"/rep_set.tre",sep="")
#Alpha analysis file command
alpha.command<-paste(qpy,py_join,"alpha_rarefaction.py", " -i ", biom_file_wpath, " -m ",
                     map_file_wpath ," -o ",arare.dir, " -f ", " -t ",
                     tree_file, sep="" )
for(command in alpha.command){
  system(command)
}

# L.	Beta analysis using QIIME
# M.	NMDS analysis using R
# N.	Heatmap generation using R