process VALIDATE {

	publishDir "$params.outputDir/validation/", mode: params.saveMode

    conda '/Users/ryanames/opt/miniconda3/envs/python'

	input: 
	path(metadata)
    path(directory)

    output:
    path("errors.txt"), emit: errors, optional: true

	script:
    """
    validation.py --metadata ${metadata} --directory ${directory}
    """
}