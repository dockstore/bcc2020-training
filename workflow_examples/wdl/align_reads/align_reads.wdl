version 1.0

# define workflow and specify what tasks the workflow will call
workflow align_reads {
    call BWA_Align

    output{
        File output_sam = BWA_Align.output_sam
    }
}
# define the alignment task
task BWA_Align {
    # define the inputs required for task to run
    # inputs are typed (string, int, file, etc)
    # the actual input values will be mapped from input json
    input {
        String sample_name
        String docker_image
        String bwa_opt
        Int threads
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

    # define task variables or methods (optional)
    String output_sam = "${sample_name}" + ".sam"

    # define the bwa mem command to run alignment
    # note the parameterization of arguments
    command {
        bwa mem ${bwa_opt} ${threads} ${ref_fasta} ${read1_fastq} ${read2_fastq} > ${output_sam}
    }
    # define task output, this is to save the files from alignment command
    output{
        File output_sam = "${output_sam}"
    }
    # define the runtime environment for this task
    # you can specify a container and also runtime parameters to set up environment
    # TODO: make an example that includes compute parameters for GCP instance (Terra)
    runtime {
        docker: docker_image
    }
}
