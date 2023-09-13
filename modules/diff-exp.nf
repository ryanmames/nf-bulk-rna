process DIFFEXP {
    publishDir "$params.outputDir/de/", mode: params.saveMode

    container 'ryanames/r-diff-exp:latest'

    input:
    path(matrix)
    path(metadata)

    output:
    path ("differential_expression.tsv")                , emit: results
    path ("differential_expression_significant.tsv")    , emit: signif_results
    path ("mean-difference.pdf")                        , emit: vis
   
   
    script:
    """
    Rscript /home/diff-exp/diff_exp.R  ${matrix} ${metadata} ${params.control} ${params.contrast}   
    """
}