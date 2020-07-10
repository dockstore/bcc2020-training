version 1.0
#This will be multi-task workflow example used in the training workshop.
#Workflow consists of two tasks, one using bwa for alignment, the other using samtools flagstat.
#Each task has also been separated out into individual workflows, see bwa and samtools directories.

# define workflow and specify what tasks the workflow will call
workflow align_and_metrics {
    # *note: at workflow call level, specify inputs shared by multiple files or those that are outputs from other tasks
    call BWA_Align

    call Flagstat {
        input:
            input_sam = BWA_Align.output_sam
    }

    # define output for overall workflow (not intermediate files, unless you want those too)
    output{
        File output_sam = BWA_Align.output_sam
        File output_metrics = Flagstat.flagstat_metrics
    }
}

# define the alignment task
task BWA_Align {
    # define the inputs required for task, will be needed in parameter json
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

    # define the command to be run by this task, note the parameterization of arguments
    command {
        bwa mem ${bwa_opt} ${threads} ${ref_fasta} ${read1_fastq} ${read2_fastq} > ${output_sam}
    }

    # define the output of this task
    output{
        File output_sam = "${output_sam}"
    }

    # define the runtime environment for this task
    runtime {
        docker: docker_image
    }
}

task Flagstat {

    # define the inputs required for task, will be needed in parameter json
    input {
        String docker_image
        File input_sam
    }

    # declare task variables, here we're using the 'basename' function from the wdl standard library
    String sample_name = basename(input_sam, ".sam") + ".flagstat.metrics"

    # define the command to be run by task, note the parameterization and usage of task variables
    command {
        samtools flagstat ${input_sam} > ${sample_name}
    }

    # define the output of this task
    output{
        File flagstat_metrics = "${sample_name}"
    }

    # define the runtime environment for this task
    # you can specify a container and also runtime parameters to set up environment
    # TODO: make an example that includes compute parameters for GCP instance (Terra)
    runtime {
        docker: docker_image
    }
}
