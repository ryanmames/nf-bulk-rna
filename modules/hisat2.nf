process HISAT2 {
    
    tag "$sample_id"
    publishDir "$params.outputDir/hisat2/${sample_id}", mode: params.saveMode, pattern: "*.txt"

    conda '/Users/ryanames/opt/miniconda3/envs/hisat2'

    input:
    tuple val(sample_id), path(reads)
    path genome

    output:
    tuple val(sample_id), path('*.sam')  , emit: sam
    tuple val(sample_id), path('*.txt')   , emit: log
    
    script:
    """
    hisat2  -p $params.hisat2_threads \\
            -x ${genome[0].getSimpleName()} \\
            -1 ${reads[0]} \\
            -2 ${reads[1]} \\
            --summary-file ${sample_id}.txt \\
            --new-summary > ${sample_id}.sam
    """
}