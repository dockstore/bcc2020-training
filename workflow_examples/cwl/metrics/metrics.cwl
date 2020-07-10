#!/usr/bin/env cwl-runner

class: CommandLineTool
id: metrics_tool
label: metrics tool
cwlVersion: v1.1
doc: A tool that provides statistics for a SAM file

$namespaces:
  dct: http://purl.org/dc/terms/
  foaf: http://xmlns.com/foaf/0.1/

dct:creator:
  '@id':  https://orcid.org/0000-0001-5173-4627
  foaf:name: Walter Shands
  foaf:mbox: jshands@ucsc.edu

requirements:
  DockerRequirement:
    dockerPull: "quay.io/ldcabansay/samtools:latest"
  ResourceRequirement:
    coresMin: 1
    ramMin: 1024
    outdirMin: 100000

inputs:
  analysis_sam:
    type: File
    inputBinding:
      position: 1
    doc: SAM file to analyze.

stdout: $(inputs.analysis_sam.nameroot).flagstat.metrics
outputs:
  flagstat_metrics:
    type: stdout
    doc: Metrics on the input SAM file.

baseCommand: [samtools, flagstat]

