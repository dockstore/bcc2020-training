cwlVersion: v1.1

##############################################################################################
# launch locally with Dockstore CLI:
#   dockstore workflow launch --local-entry GoodbyeWorld.cwl --json goodbye.json
###############################################################################################

class: Workflow

inputs:
  greeting: File

# Define a step and define tool to execute when this step runs
steps:
  goodbye:
    run: goodbye.cwl
    in:
      greeting: greeting
    out: [outFile]

# Specify the output(s) of this workflow
outputs:
  byeFile:
    type: File
    outputSource: goodbye/outFile
