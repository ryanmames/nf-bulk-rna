/*
 * Bulk RNA-Seq Pipeline
 *
 * Authors:
 * Ryan Ames 
 *
 */

/*
 * enables modules
 */
nextflow.enable.dsl=2

/*
 * Defines some parameters 
 */

params.saveMode = 'copy'
params.inputDir         = "$projectDir/input-seqs/"
params.outputDir        = "$projectDir/pipeline-run/"
params.workDir          = "$projectDir/work/"

// User defined params  could be via config, command line etc
params.metadata         = "$projectDir/metadata.csv"
params.reads            = "$projectDir/input-seqs/SRR*/SRR*_{R1,R2}.fastq.gz"
params.control          = "control"
params.contrast         = "treatment"

// External DB
params.genome           = "$projectDir/reference/C_albicans_SC5314"
params.annotation       = "$projectDir/reference/C_albicans_SC5314.gtf"

// Running options
params.fastp_threads   = 6
params.fastqc_threads  = 6
params.hisat2_threads  = 6

/*
 * Import workflows
 */
include { BULKRNA } from './workflows/bulkrna'


/*
 * Run the workflow
 */ 
workflow {
    BULKRNA ()
}