###############################################################################################
# Exercise2 Example Solution
# this workflow will evaluate SAM file and generate statistics about the alignment

#launch locally with Dockstore CLI:
# first move to directory:
#   cd /root/bcc2020-training/wdl-training/exercise2/solution
# run workflow:
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

    input {
        File input_sam
    }

    # parameterize the samtools flagstat command
    command {
        samtools flagstat ${input_sam} > mini.sam.metrics
    }

    output{
        File metrics =  "mini.sam.metrics"
    }

    # specify a container and any other runtime parameters to set up environment
    runtime {
        docker: "quay.io/ldcabansay/samtools:latest"
    }
}