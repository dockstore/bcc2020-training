###############################################################################################
# Exercise3: Multi-task workflow, non-imports version
# Create a workflow that does two tasks WITHOUT using imports:
# first aligns FASTQ sequences to a reference and produces a sam file,
# then generates statistics about the alignment

#Run locally with DockstoreCLI:
# first move to directory:
#   cd /root/bcc2020-training/wdl-training/exercise3
# run workflow:
#   dockstore workflow launch --local-entry align_and_metrics.wdl --json align_and_metrics.json
###############################################################################################

version 1.0

workflow align_and_metrics {
    call # task name here #

    call # task name here # {
        input:
            # use the output of bwa_align as input for this task
            input_sam = # fill me in #
    }

    # define output for overall workflow
    output{
        File output_sam = bwa_align.output_sam
        File output_metrics = flagstat.metrics
    }
}

# define the alignment task
task bwa_align {

## insert bwa task

}
#define the flagstat task
task flagstat {

## insert flagstat task

}