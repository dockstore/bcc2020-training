###############################################################################################
# Exercise3 Example Solution
# this workflow will...

#launch locally with DockstoreCLI:
#   dockstore workflow launch --local-entry aligner.wdl --json aligner.json
###############################################################################################

version 1.0

# define the align_reads workflow
workflow align_reads {
    call bwa_align

    output{
        File output_sam = bwa_align.output_sam
    }
}
# define the alignment task
task bwa_align {
    # define the inputs parameters, actual values will be mapped from JSON
    input {
        String sample_name
        String docker_image
        String bwa_opts
        File ref_fasta
        File ref_fasta_fai
        File ref_fasta_amb
        File ref_fasta_ann
        File ref_fasta_bwt
        File ref_fasta_pac
        File ref_fasta_sa
        File read1_fastq
        File read2_fastq
    }

    #task variable used to make a filename (optional)
    String output_sam = "${sample_name}" + ".sam"

    # define the parameterized bwa mem command to run alignment
    command {
        bwa mem ${bwa_opts} ${ref_fasta} ${read1_fastq} ${read2_fastq} > ${output_sam}
    }

    # define output, maps the sam file generated from alignment command
    output{
        File output_sam = "${output_sam}"
    }

    # define a parameterized runtime environment for this task
    # setting 'docker_image' here means the parameter needs to be defined in the JSON
    runtime {
        docker: docker_image
    }
}
