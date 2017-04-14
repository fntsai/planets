import os
import sys
import glob

from subprocess import call

#Before running this script make sure to set the following values:

#Location of directory of files to be worked on. This must be an Absolute path.
input_dir = "/projects/b1063/POP3Colitis/output/POP3Colitis/bam"

#Pattern for matching files to work on.  For example: "*.fastq"
match_pattern = "*.bam"

#List of modules to be included. For example ["STAR", "java", "samtools/1.2"]
required_modules = ["python", "R"]

#Name of task being processed.  For example: "fastqc"
task_name = "GeneBody"


os.chdir(input_dir)

#Find files in specified directory and iterate through the list, creating associated shell scripts
for file in glob.glob(match_pattern):
    fname_toks = file.split(".") #recognizing file name with "."
    script_name = fname_toks[0]+"_genebody.sh"
    script_f = open(script_name, "w+")
    script = ""
    script += "#!/bin/bash\n"
    script += "#MSUB -A b1042\n"
    script += "#MSUB -q genomics\n"
    script += "#MSUB -l walltime=24:00:00\n"
    script += "#MSUB -m a\n"
    script += "#MSUB -j oe\n"
    script += "#MOAB -W umask=0113\n"
    script += "#MSUB -N "+fname_toks[0]+"_"+task_name+"\n"
    script += "#MSUB -l nodes=1:ppn=4\n\n"

    #Iterate through list of required modules and add to shell script
    for module in required_modules:
        script += "module load "+module+"\n"

    script += "\n"
#    script += "cd "+input_dir+"\n"
#    script += "\n"

    #Build out customized task to be performed
    script += "geneBody_coverage.py -o "+input_dir+"/"+fname_toks[0]+" -i "+input_dir+"/"+file+" -r "+input_dir+"/mm10_UCSC_knownGene.bed"
    script += "\n"

    script_f.write(script)
    script_f.close

    #Now that the shell script has been created - submit it...
    #call(["msub", script_name])

