#!/usr/bin/env cwl-runner

###############################################################################################
# Exercise1 Example Solution
# this tool will output two strings to a file named Hello.txt

# launch locally with Dockstore CLI:
#   dockstore tool launch --local-entry hello.cwl --json hello.json
###############################################################################################


cwlVersion: v1.1
class: CommandLineTool

baseCommand: ["bash", "hello.sh"]

# Construct a shell script on the fly
requirements:
  InitialWorkDirRequirement:
    listing:
      - entryname: hello.sh
        entry: |-
          #!/bin/bash
          myName="$(inputs.myName.path)"
          echo Hello World! > Hello.txt
          cat \${myName} >> Hello.txt

inputs:
  myName:
    type: File
    inputBinding:
      position: 1

outputs:
  outFile:
    type: File
    outputBinding:
      glob: Hello.txt
    doc: Output from echo and cat commands

