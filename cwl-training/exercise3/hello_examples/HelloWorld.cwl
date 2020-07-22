cwlVersion: v1.1

##############################################################################################
# launch locally with Dockstore CLI:
#   dockstore workflow launch --local-entry HelloWorld.cwl --json hello.json
###############################################################################################

class: Workflow

inputs:
  myName: File

# Define a step and define tool to execute when this step runs
steps:
  hello:
    run: hello.cwl
    in:
      myName: myName
    out: [outFile]

# Specify the output(s) of this workflow
outputs:
  helloFile:
    type: File
    outputSource: hello/outFile
