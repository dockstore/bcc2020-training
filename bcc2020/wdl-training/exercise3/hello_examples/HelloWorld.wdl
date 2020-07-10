##############################################################################################
#launch locally with DockstoreCLI:
#   dockstore workflow launch --local-entry HelloWorld.wdl --json hello.json
###############################################################################################

version 1.0
#define 'hello_world' workflow
workflow hello_world {
   call hello
   # tell cromwell to put this in output directory
   output { File helloFile = hello.outFile }
}
#define hello task
task hello {
    input {
    File myName
    }
    # define command to execute when hello task runs
    command {
        echo Hello World! > Hello.txt
        cat ${myName} >> Hello.txt
    }
    # specify the output(s) of hello task so cromwell will keep track of them
    output {
        File outFile = "Hello.txt"
    }
}