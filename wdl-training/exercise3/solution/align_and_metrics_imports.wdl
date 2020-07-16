###############################################################################################
# Exercise3 Example Solution
# # A workflow that does two tasks using IMPORTS:
  # first aligns FASTQ sequences to a reference and produces a sam file,
  # then generates statistics about the alignment

#launch locally with DockstoreCLI:
# first move to directory:
#   cd /root/bcc2020-training/wdl-training/exercise3/solution
# run workflow:
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