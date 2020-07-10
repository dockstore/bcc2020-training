##############################################################################################
#launch locally with DockstoreCLI:
#   dockstore workflow launch --local-entry HelloWorld.wdl --json hello.json
###############################################################################################

version 1.0
#define 'goodbye_world' workflow
workflow goodbye_world {
   call goodbye
   # tell cromwell to put this in output directory
   output { File byeFile = goodbye.outFile }
}
#define goodbye task
task goodbye {
    input {
    File greeting
    }
    # define command to execute when hello task runs
    command {
        cat ${greeting}
        echo See you later!
    }
    #save output from stdout as file
    output {
        File outFile = stdout()
    }
}