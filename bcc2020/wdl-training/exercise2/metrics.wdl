###############################################################################################
# This workflow will take in a SAM file and generate statics about the alignment
# In this exercise you must complete this workflow by:
#   -Setting runtime to use docker image quay.io/ldcabansay/samtools:latest
#   -Parameterizing variables in the workflow, particularly the command
#   -Be sure to update the metrics.json file if applicable to your parameterization

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
    #add any input parameters if applicable to your solution
    input {
        File input_sam
    }

    # parameterize the samtools flagstat command
    command {
        samtools flagstat NA1278.sam > NA1278.sam.metrics
    }
    output{
        File metrics =  "NA1278.sam.metrics"
    }
    # specify a container and any other runtime parameters to set up environment
    runtime {
        docker: # set me
    }
}