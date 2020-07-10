#!/usr/bin/env nextflow

// This will be multi-process workflow example used in the training workshop.
// Workflow consists of two processes, one using bwa for alignment, the other using samtools flagstat.
// Each task has also been separated out into individual workflows, see bwa and samtools directories.

// Define inputs that you want to be available from the start of a process
// The following set of lines create 'source channels' over which the file referenced can be sent.
// For example, the first line creates a source channel called ref_fasta that can send the file referenced in our nextflow.config file.
ref_fasta = file(params.ref_fasta)
read1_fastq = file(params.read1_fastq)
read2_fastq = file(params.read2_fastq)
ref_fasta_fai = file(params.ref_fasta_fai)
ref_fasta_bwt = file(params.ref_fasta_bwt)
ref_fasta_sa = file(params.ref_fasta_sa)
ref_fasta_pac = file(params.ref_fasta_pac)
ref_fasta_amb = file(params.ref_fasta_amb)
ref_fasta_ann = file(params.ref_fasta_ann)

// In Nextflow, processes are isolated and execute independently of each other.
// The order in which processes execute is implicitly defined by how the inputs and outputs of each process are described.
// In other words, if the output of process A is used as the input of process B, then process B will only execute once A has sent the output.
// Otherwise, processes are executed in parallel.

// Define the alignment process
process BWA_Align {

    // Define the inputs required for this process to run.
    // An input definition is formatted with an input qualifier, name, the key word 'from', and then the channel the inputs are received from.
    // The input qualifier can be 'val', 'env', 'file', 'path', 'stdin', 'tuple', and 'each'
    input:
    file ref_fasta from ref_fasta
    file read1_fastq from read1_fastq
    file read2_fastq from read2_fastq
    file ref_fasta_fai from ref_fasta_fai
    file ref_fasta_bwt from ref_fasta_bwt
    file ref_fasta_sa from ref_fasta_sa
    file ref_fasta_pac from ref_fasta_pac
    file ref_fasta_amb from ref_fasta_amb
    file ref_fasta_ann from ref_fasta_ann

    // Define channels to send out the results produced by the process.
    // An output definition starts with an output qualifier, name, the keyword 'into', and then one or more channels over which to send the outputs.
    // The qualifiers can be 'val', 'env', 'file', 'path', 'stdout', and 'tuple'.
    output:
    file "${params.bwa_output_name}" into bwa_result

    // Define the command to be run by process. Note the parameterization.
    """
    bwa mem ${params.bwa_opt} ${params.threads} ${ref_fasta} ${read1_fastq} ${read2_fastq} > ${params.bwa_output_name}
    """
}

// Define the Flagstat process
process Flagstat {

    // Grab the output file of the BWA_Align process from the bwa_result channel.
    input:
    file sam from bwa_result

    // Send out results to flagstat_output_channel.
    output:
    file "${params.flagstat_output_name}" into flagstat_output_channel

    // Define the command to be run by process. Note the parameterization.
    """
    samtools flagstat ${sam} > ${params.flagstat_output_name}
    """

}
