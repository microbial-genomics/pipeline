#N. make individual heat maps
#Files with dimension
taxa_summary_files<-list.files(taxa_summary.dir,pattern=".biom")
taxa_summary_files_wpath<-paste(taxa_summary.dir,"/",taxa_summary_files,sep="")
n=length(taxa_summary_files_wpath)
taxa_summary_out_files<-paste(taxa_summary_out.dir,"L",2:5,"_heatmap",sep="")
alpha.script<-paste(pipeline.dir,"alpha.script",sep="")
tree_file<-paste(otu.dir,"/rep_set.tre",sep="")
beta.script<-paste(pipeline.dir,"beta.script",sep="")

#create the taxa_summary/otu directory
dir.create(taxa_summary_out.dir,showWarning = TRUE, recursive = FALSE)
#heatmap command

heatmap.command<-paste(qpy, py_join,"make_otu_heatmap.py", " -i ", taxa_summary_files_wpath,
                       " -o ",taxa_summary_out_files, sep="")
for(command in heatmap.command){
  system(command)
}

# K.  Alpha analysis using QIIME--default analysis

#Alpha analysis file command
alpha.command<-paste(qpy,py_join,"alpha_rarefaction.py", " -i ", biom_file_wpath, " -m ",
                     map_file_wpath ," -o ",arare.dir, " -f ", " -t ",
                     tree_file, sep="" )
write("#!/bin/bash",file=alpha.script,append=FALSE)
write("source /macqiime/configs/bash_profile.txt",file=alpha.script,append=TRUE)
write(alpha.command, file=alpha.script,append=TRUE)
print(alpha.command)
chmod <- "chmod 755 alpha.script"
system(chmod)
system(alpha.script)

# L.	Beta analysis using QIIME--default analysis

#file command
beta.command<-paste(qpy, py_join,"beta_diversity_through_plots.py", " -i ", biom_file_wpath, " -m ", map_file_wpath, " -t ",
                    tree_file, " -o ", beta_out_dir, " -f ", sep="")

write("#!/bin/bash",file=beta.script,append=FALSE)
write("source /macqiime/configs/bash_profile.txt",file=beta.script,append=TRUE)
write(beta.command, file=beta.script,append=TRUE)
print(beta.command)
chmod <- "chmod 755 beta.script"
system(chmod)
system(beta.script)

