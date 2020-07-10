###############################################################################################
# Exercise2 Example Solution
# this workflow will evaluate SAM file and generate statics about the alignment

#launch locally with DockstoreCLI:
#   dockstore workflow launch --local-entry metrics.wdl --json metrics.json
###############################################################################################

version 1.0

workflow metrics {
    call flagstat
    output{
        File alignment_metrics = flagstat.metrics
    }
}
# define the flagstat task
task flagstat {
    # added parameter 'docker_image'
    input {
        File input_sam
        String docker_image
    }
    # create a string variable 'stats', basename function from WDL standard library
    String stats = basename(input_sam) + ".metrics"
    # parameterize the samtools flagstat command
    command {
        samtools flagstat ${input_sam} > ${stats}
    }
    output{
        File metrics =  "${stats}"
    }
    # specify a container and any other runtime parameters to set up environment
    runtime {
        docker: docker_image
    }
}