##############################################################################################
#launch locally with DockstoreCLI:
#   dockstore workflow launch --local-entry HelloGoodbye.wdl --json HelloGoodbye.json
###############################################################################################

version 1.0
#define 'HelloGoodbye' workflow
workflow HelloGoodbye {
   call hello
   call goodbye {
        #use output of hello task as input for goodbye task
        input: greeting = hello.outFile
   }
   # tell cromwell to put this in output directory
   output { File hello_byeFile = goodbye.outFile }
}
#define hello task, same as in HelloWorld
task hello {
    input {
    File myName
    }
    command {
        echo Hello World!
        cat ${myName}
    }
    output {
        File outFile = stdout()
    }
}
#define goodbye task, same as in GoodbyeWorld
task goodbye {
    input {
    File greeting
    }
    command {
        cat ${greeting}
        echo See you later!
    }
    output {
        File outFile = stdout()
    }
}