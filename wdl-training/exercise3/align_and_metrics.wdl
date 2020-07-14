###############################################################################################
# Exercise3 Example Solution
# this workflow will...

#launch locally with DockstoreCLI:
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
task flagstat {

## insert flagstat task

}