#dockstore workflow launch --local-entry metrics.wdl --json metrics.json
version 1.0
# this workflow will evaluate SAM file and generate statics about the alignment

# define workflow and specify what tasks the workflow will call
workflow metrics {
    call Flagstat

    output{
        File flagstat_metrics = Flagstat.flagstat_metrics
    }
}
# define the Flagstat task
task Flagstat {
    # define the inputs required for task to run
    # inputs are typed (string, int, file, etc)
    # the actual input values will be mapped from input json
    input {
        String docker_image
        File input_sam
    }

    # define task variables or methods (optional)
    String sample_name = basename(input_sam, ".sam") + ".flagstat.metrics"

    # define the flagstat command to generate alignment statisics for a given samfile
    command {
        samtools flagstat ${input_sam} > ${sample_name}
    }
    # define task output, this is to save the files from alignment command
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