process FASTP {

	tag "$sample_id"
	publishDir "$params.outputDir/fastp/$sample_id", mode: params.saveMode

    conda '/Users/ryanames/opt/miniconda3/envs/fastp'

	input: 
	tuple val(sample_id), path(reads)

    output:
    tuple val(sample_id), path("*.trim.fastq.gz")  , emit: trimmed_reads_ch
    tuple val(sample_id), path("*.json")           , emit: json
    tuple val(sample_id), path("*.html")           , emit: html

	script:
    """
    fastp \\
        --thread $params.fastp_threads \\
        --in1 ${reads[0]} \\
        --in2 ${reads[1]} \\
        --detect_adapter_for_pe \\
        --out1 ${sample_id}_1.trim.fastq.gz \\
        --out2 ${sample_id}_2.trim.fastq.gz \\
        --json ${sample_id}.fastp.json \\
        --html ${sample_id}.fastp.html \\
        2> ${sample_id}.fastp.log
    """
}