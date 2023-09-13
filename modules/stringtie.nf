process STRINGTIE {
    
    tag "$sample_id"
    publishDir "$params.outputDir/stringtie/", mode: params.saveMode

    conda '/Users/ryanames/opt/miniconda3/envs/stringtie'

    input:
    tuple val(sample_id), path(bam)
    path annotation

    output:
    path(sample_id), emit: gtf, type: 'dir'
    
    script:
    """
    mkdir ${sample_id}
    stringtie -o ${sample_id}/${sample_id}.gtf -G ${annotation} -e ${bam}
    """
}