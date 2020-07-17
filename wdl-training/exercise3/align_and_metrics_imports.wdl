###############################################################################################
# Exercise3: Multi-task workflow, imports version
# Create a workflow that does two tasks using IMPORTS:
  # first aligns FASTQ sequences to a reference and produces a sam file,
  # then generates statistics about the alignment
  # for help, see the hello_examples directory for the files used in the slides

#Run locally with DockstoreCLI:
# first move to directory:
#   cd /root/bcc2020-training/wdl-training/exercise3
# run workflow:
#   dockstore workflow launch --local-entry align_and_metrics_imports.wdl --json align_and_metrics.json
###############################################################################################

version 1.0

import # add relative path to import aligner.wdl (hint: its in 'parts' directory)
import # add relative path to import metrics.wdl (hint: its in 'parts' directory)

workflow align_and_metrics {
    #call the bwa_align task from the imported aligner.wdl
    call # fill me in, hint: did you use an alias? #

    #call the flagstat task from the imported metrics.wdl
    call # fill me in, hint: did you use an alias? # {
        input:
            # use the output of bwa_align as input for this task
            input_sam = # fill me in #
    }

    # define output for overall workflow
    # hint refer to these only by <task name>.<param name> since imports should now be localized.
    output{
        File output_sam = # fill me in #
        File output_metrics = # fill me in #
    }
}