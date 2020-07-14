###############################################################################################
# Exercise3 Example Solution
# this workflow will...

#launch locally with DockstoreCLI:
#   dockstore workflow launch --local-entry align_and_metrics_imports.wdl --json align_and_metrics.json
###############################################################################################

version 1.0

import # add relative path to import aligner.wdl
import # add relative path to import metrics.wdl

workflow align_and_metrics {
    #call the bwa_align task from the imported aligner.wdl
    call # fill me in #

    #call the flagstat task from the imported metrics.wdl
    call # fill me in # {
        input:
            # use the output of bwa_align as input for this task
            input_sam = # fill me in #
    }

    # define output for overall workflow
    output{
        File output_sam = # fill me in #
        File output_metrics = # fill me in #
    }
}