
include { VALIDATE  } from '../modules/validate.nf'
include { EXIT      } from '../modules/exit.nf'
include { FASTP     } from '../modules/fastp.nf'
include { FASTQC    } from '../modules/fastqc'
include { HISAT2    } from '../modules/hisat2'
include { SAMTOOLS  } from '../modules/samtools'
include { STRINGTIE } from '../modules/stringtie'
include { PREPDE    } from '../modules/prepde'
include { DIFFEXP   } from '../modules/diff-exp'

workflow BULKRNA {

    // Validate inputs
    metadata = Channel.fromPath(params.metadata)
    directory = Channel.fromPath(params.inputDir)
    VALIDATE(metadata, directory)
    EXIT(VALIDATE.out.errors)
    
    // Get the input reads
    reads_ch = channel.fromFilePairs( params.reads, checkIfExists: true )

    // Quality control
    FASTP(reads_ch)
    FASTQC(FASTP.out.trimmed_reads_ch)

    // Alignment
    genome_ch = Channel.value(file("${params.genome}.*"))
    HISAT2(FASTP.out.trimmed_reads_ch, genome_ch)

    // Post-processing
    SAMTOOLS(HISAT2.out.sam)

    // Quantification
    annotation_ch = Channel.value(file(params.annotation))
    STRINGTIE(SAMTOOLS.out.bam, annotation_ch)
    PREPDE(STRINGTIE.out.gtf.collect())

    // Differential expression
    DIFFEXP(PREPDE.out.genes, metadata)

}

workflow.onComplete {
    log.info ( workflow.success ? "Done!" : "Oops .. something went wrong" )
}