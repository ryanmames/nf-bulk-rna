process PREPDE {
    publishDir "$params.outputDir/prepde/", mode: params.saveMode

    conda '/Users/ryanames/opt/miniconda3/envs/stringtie'

    input:
    path(gft)

    output:
    path('gene_count_matrix.csv')         , emit: genes
    path('transcript_count_matrix.csv')   , emit: transcripts
    
    script:
    """
    prepDE.py -i .
    """
}