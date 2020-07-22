#!/usr/bin/env cwl-runner

###############################################################################################
# Exercise3 Example Solution
# this tool will...

# launch locally with Dockstore CLI:
#   dockstore tool launch --local-entry align.cwl --json align.cwl.json
###############################################################################################
#
# CWL documents are written in YAML and/or JSON.
# The cwlVersion field indicates the version of the CWL spec used by the document.
# The class field indicates this document describes a command line tool.
class: CommandLineTool
id: align_tool
label: align tool
cwlVersion: v1.1
doc: A workflow that aligns a pair of fasta files

$namespaces:
  dct: http://purl.org/dc/terms/
  foaf: http://xmlns.com/foaf/0.1/

dct:creator:
  '@id':  https://orcid.org/0000-0001-5173-4627
  foaf:name: Walter Shands
  foaf:mbox: jshands@ucsc.edu

# We list our requirements for the docker container in DockerRequirements. The
# dockerPull: parameter takes the same value that you would pass to a docker pull
# command. That is, the name of the container image (you can even specify the tag,
# which is good idea for best practises when using containers for reproducible research).
requirements:
  DockerRequirement:
    dockerPull: "quay.io/ldcabansay/bwa:latest"
  ResourceRequirement:
    coresMin: 1
    ramMin: 1024
    outdirMin: 100000
  ShellCommandRequirement: {}

# Normally, input files are located in a read-only directory separate from the output directory.
# This causes problems if the underlying tool expects to write its output files alongside the input
# file in the same directory. You use InitialWorkDirRequirement to stage input files
# into the output directory. In this example, we use a JavaScript expression to
  # Make sure the index files are in the same place
  # so BWA can find them
  InitialWorkDirRequirement:
    listing:
      - $(inputs.ref_fasta)
      - $(inputs.ref_fasta_fai)
      - $(inputs.ref_fasta_amb)
      - $(inputs.ref_fasta_ann)
      - $(inputs.ref_fasta_bwt)
      - $(inputs.ref_fasta_pac)
      - $(inputs.ref_fasta_sa)

# The inputs of a tool is a list of input parameters that control how to run the
# tool. Each parameter has an id for the name of parameter, and type describing
# what types of values are valid for that parameter.

# Available primitive types are string, int, long, float, double, and null; complex
# types are array and record; in addition there are special types File, Directory and Any.

# The inputs section describes the inputs of the tool. This is a mapped list of
# input parameters (see the YAML Guide https://www.commonwl.org/user_guide/yaml/#maps
# for more about the format) and each parameter
# includes an identifier, a data type, and optionally an inputBinding. The inputBinding
# describes how this input parameter should appear on the command line. In this example,
# the position field indicates where it should appear on the command line.
inputs:
  sample_name:
    type: string
    doc: Sample name

# The field inputBinding is optional and indicates whether and how the input parameter
# should be appear on the tool’s command line. If inputBinding is missing, the parameter
# does not appear on the command line.
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

# To capture a tool’s standard output stream, add the stdout field with the name
# of the file where the output stream should go. Then add type: stdout on the
# corresponding output parameter.
stdout: $(inputs.sample_name).sam
outputs:
  output_sam:
    type: stdout
    doc: Aligned SAM file.

# The baseCommand provides the name of program that will actually run
baseCommand: [bwa, mem]

