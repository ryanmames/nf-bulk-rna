process FASTQC {
    tag "$sample_id"
    publishDir "$params.outputDir/fastqc/", mode: params.saveMode

    conda '/Users/ryanames/opt/miniconda3/envs/fastqc'

    input:
    tuple val(sample_id), path(reads)

    output:
    tuple val(sample_id), path("*.html"), emit: html
    tuple val(sample_id), path("*.zip") , emit: zip

    script:
    """
    fastqc --threads $params.fastqc_threads ${reads[0]} ${reads[1]}
    """
}