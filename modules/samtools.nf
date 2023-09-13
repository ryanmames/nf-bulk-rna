process SAMTOOLS {
    tag "$sample_id"
    publishDir "$params.outputDir/samtools/", mode: params.saveMode

    conda '/Users/ryanames/opt/miniconda3/envs/samtools'

    input:
    tuple val(sample_id), path(sam)

    output:
    tuple val(sample_id), path('*.bam')  , emit: bam
    
    script:
    """
    samtools sort -o ${sample_id}.bam ${sam}
    """
}