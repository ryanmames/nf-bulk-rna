# nf-bulk-rna
A nextflow bulk RNA-Seq processing pipeline

## Setup 
Clone the git repe
```
git clone https://github.com/ryanmames/nf-bulk-rna.git
```

Install the necessary conda environments
```
cd conda/
conda env create -f fastp.yaml
conda env create -f fastqc.yaml
conda env create -f hisat2.yaml
conda env create -f python.yaml
conda env create -f samtools.yaml
conda env create -f stringtie.yaml
```
*Note:* Nextflow modules (in the modules directory) will need the `conda` directive modified to include your personal path to the conda installation directory

Install the necessary docker environment
```
cd docker/
docker build -t="ryanames/r-diff-exp" ./
```

