#!/usr/bin/env nextflow
// this workflow will evaulate SAM file and generate statics about the alignment

// define inputs that you want to be available from the start of a process
// this line creates a 'source channel' called input_sam that can send the file referenced in our nextflow.config file
input_sam = file(params.analysis_sam)

// define the Flagstat process
process Flagstat {
    // define the inputs required for this process to run
    // an input definition is formatted with an input qualifier, name, the key word 'from', and then the channel the inputs are received from
    // the input qualifier can be 'val', 'env', 'file', 'path', 'stdin', 'tuple', and 'each'
    input:
    file input_sam from input_sam

    // in the output block, you define channels to send out the results produced by the process
    // an output definition starts with an output qualifier, name, the keyword 'into', and then one or more channels over which to send the outputs.
    // The qualifiers can be 'val', 'env', 'file', 'path', 'stdout', and 'tuple'.
    output:
    file "${params.flagstat_output_name}" into flagstat_output_channel

    // define the command to be run by this task, note the parameterization of arguments
    """
    samtools flagstat ${input_sam} > ${params.flagstat_output_name}
    """
}
