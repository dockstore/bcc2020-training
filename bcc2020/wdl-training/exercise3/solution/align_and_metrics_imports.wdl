###############################################################################################
# Exercise3 Example Solution
# this workflow will...

#launch locally with DockstoreCLI:
#   dockstore workflow launch --local-entry align_and_metrics_imports.wdl --json align_and_metrics.json
###############################################################################################

version 1.0

import "../aligner.wdl"
import "../metrics.wdl"

workflow align_and_metrics {
    call aligner.bwa_align

    call metrics.flagstat {
        input:
            input_sam = bwa_align.output_sam
    }

    # define output for overall workflow
    output{
        File output_sam = bwa_align.output_sam
        File output_metrics = flagstat.metrics
    }
}