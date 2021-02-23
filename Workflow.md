#Graded assignment 2 workflow:
```
#Start a Git repository:
cd /fs/ess/PAS1855/users/nghi/week06/
mkdir pracs-sp21-GA2
cd pracs-sp21-GA2
#Initialize a Git repository:
git init
git status
git add Workflow.md
git commit -m "Add workflow.md file"

#create README file:
touch README.md
echo "This is the repository of Graded Assignment2" > README.md
git status
git add README.md
git status
git commit -m "Create README file"
git status

#Copy FASTQ files:
mkdir data
ls
cd data
mkdir FASTQ
cd FASTQ
cp  /fs/ess/PAS1855/data/week05/fastq/*.fastq .
ls
git add /fs/ess/PAS1855/users/nghi/week06/pracs-sp21-GA2/data/FASTQ/*
git commit -m "Copy fastq files"
git status


#Make gitignore file to ignore fastq files:
echo "*.fastq" >> .gitignore
git add .gitignore
git commit -m "Added a gitignore file"
git status

#Load the Conda module at OSC and create a Conda environment for Cutadapt
module load python/3.6-conda5.2
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
conda config --get channels

#Add Cutadapt
conda create -n cutadaptenv cutadapt
#Activate the environment
module load python/3.6-conda5.2
source activate cutadaptenv 
#Check if it works
cutadapt --version 
#export Cutadapt environment
conda env export -n Cutadapt > Cutadapt.yml
source deactivate
git add Cutadapt.yml
git commit -m "Load the Conda module and create a Conda environment for Cutadapt and create YAML file"
git status
```

##Cutadapt scripts for one sample

```
#Execute the script
 sbatch cutadapt_single.sh "$R1_in" "$output_dir" "$primer_f" "$primer_r"

 #check in on the job 
 squeue -u $USER

less slurm-3047697.out


#check output dir
ls -lh $output_dir
ls

cd results
cp /fs/ess/PAS1855/users/nghi/week06/pracs-sp21-GA2/*.out .

git add --all

git commit -m "Last rerun and reorganized output files"

git remote add origin git@github.com:hellosoni/pracs-sp21-GA2.git
git branch -M main
git push -u origin main



