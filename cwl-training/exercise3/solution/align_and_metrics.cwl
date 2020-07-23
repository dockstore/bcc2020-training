###############################################################################################
# Exercise3 Example Solution
# this workflow will align reads from a fastq file and print statistics for a SAM
# file to another file

# launch locally with Dockstore CLI:
#   dockstore workflow launch --local-entry align_and_metrics.cwl --json align_and_metrics.json
###############################################################################################
#
cwlVersion: v1.1

# See documentation here https://www.commonwl.org/user_guide/

# The cwlVersion field indicates the version of the CWL spec used by the document.
# The class field indicates this document describes a workflow.
class: Workflow

label: A workflow that aligns a fasta file and provides statistics on the SAM file
doc: A workflow that aligns a fasta file and provides statistics on the SAM file

# Metadata about the tool or workflow itself (for example, authorship for use in citations)
# may be provided as additional fields on any object
# Once you add the namespace prefix, you can access it anywhere in the document as shown
# below. Otherwise one must use full URLs.
$namespaces:
  dct: http://purl.org/dc/terms/
  foaf: http://xmlns.com/foaf/0.1/

dct:creator:
  '@id':  https://orcid.org/0000-0001-5173-4627
  foaf:name: Walter Shands
  foaf:mbox: jshands@ucsc.edu

# Top level inputs and outputs of the workflow are described in the inputs and outputs fields respectively.

# The inputs section describes the inputs of the workflow.
# This is a list of input parameters where each parameter consists of an identifier
# and a data type.
# These parameters can be used as sources for input to specific workflows steps.
inputs:
    sample_name: string
    bwa_opt: string
    ref_fasta: File
    ref_fasta_fai: File
    ref_fasta_amb: File
    ref_fasta_ann: File
    ref_fasta_bwt: File
    ref_fasta_pac: File
    ref_fasta_sa: File
    read1_fastq: File
    read2_fastq: File

# The outputs section describes the outputs of the workflow. This is a list of output
# parameters where each parameter consists of an identifier and a data type.
# There are two outputs from this workflow, both are files, and one output called
# 'output_sam' is a file that is produced byt he bwa_align step.
outputs:
  output_sam:
    type: File
    outputSource: bwa_align/output_sam
  output_metrics:
    type: File
    outputSource: flagstat/metrics

# The steps section describes the actual steps of the workflow.
# Each step in a workflow must have its own CWL description.
# Workflow steps are not necessarily run in the order they are listed, instead
# the order is determined by the dependencies between steps (using source). In
# addition, workflow steps which do not depend on one another may run in parallel.
# The first step runs a CWL tool described in align.cwl and produces an
# output called 'output_sam'
steps:
  bwa_align:
    run:
      class: CommandLineTool
      requirements:
        DockerRequirement:
          dockerPull: "quay.io/ldcabansay/bwa:latest"
        ResourceRequirement:
          coresMin: 1
          ramMin: 1024
          outdirMin: 100000
        ShellCommandRequirement: {}

        InitialWorkDirRequirement:
          listing:
            - $(inputs.ref_fasta)
            - $(inputs.ref_fasta_fai)
            - $(inputs.ref_fasta_amb)
            - $(inputs.ref_fasta_ann)
            - $(inputs.ref_fasta_bwt)
            - $(inputs.ref_fasta_pac)
            - $(inputs.ref_fasta_sa)

      inputs:
        sample_name:
          type: string
          doc: Sample name

        bwa_opt:
          type: string
          inputBinding:
            position: 2
            shellQuote: false
          doc: BWA options

        ref_fasta:
          type: File
          inputBinding:
            position: 4
          doc: Genome reference fasta file.

        ref_fasta_fai:
          type: File
          doc: Genome reference bwa index fai.

        ref_fasta_amb:
          type: File
          doc: Genome reference bwa index amb.

        ref_fasta_ann:
          type: File
          doc: Genome reference bwa index ann.

        ref_fasta_bwt:
          type: File
          doc: Genome reference bwa index bwt.

        ref_fasta_pac:
          type: File
          doc: Genome reference bwa index pac.

        ref_fasta_sa:
          type: File
          doc: Genome reference bwt index sa.

        read1_fastq:
          type: File
          inputBinding:
            position: 11
          doc: Input first fastq.

        read2_fastq:
          type: File
          inputBinding:
            position: 12
          doc: Input second fastq.

      stdout: $(inputs.sample_name).sam
      outputs:
        output_sam:
          type: stdout
          doc: Aligned SAM file.

      # The baseCommand provides the name of program that will actually run
      baseCommand: [bwa, mem]


    in:
      sample_name: sample_name
      bwa_opt: bwa_opt
      ref_fasta: ref_fasta
      ref_fasta_fai: ref_fasta_fai
      ref_fasta_amb: ref_fasta_amb
      ref_fasta_ann: ref_fasta_ann
      ref_fasta_bwt: ref_fasta_bwt
      ref_fasta_pac: ref_fasta_pac
      ref_fasta_sa: ref_fasta_sa
      read1_fastq: read1_fastq
      read2_fastq: read2_fastq

    out:
      [output_sam]

# The second step uses the output of the bwa_align step as its input and produces
# and output called metrics
  flagstat:
    run:
      class: CommandLineTool
      requirements:
        DockerRequirement:
          dockerPull: "quay.io/ldcabansay/samtools:latest"
        ResourceRequirement:
          coresMin: 1
          ramMin: 1024
          outdirMin: 100000

      inputs:
        input_sam:
          type: File
          inputBinding:
            position: 1
          doc: SAM file to analyze.

      stdout: $(inputs.input_sam.nameroot).metrics
      outputs:
        metrics:
          type: stdout
          doc: Metrics on the input SAM file.

      baseCommand: [samtools, flagstat]

    in:
      input_sam: bwa_align/output_sam
    out: [metrics]

