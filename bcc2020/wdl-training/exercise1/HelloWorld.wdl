##############################################################################################
#launch locally with DockstoreCLI:
#   dockstore workflow launch --local-entry HelloWorld.wdl --json hello.json
#launch with cromwell:
#   java -jar <path to cromwell jar>/cromwell-44.jar run HelloWorld.wdl --inputs hello.json
###############################################################################################
#set wdl version
version 1.0

#add and name a workflow block
workflow hello_world {
   call hello
   output { File helloFile = hello.outFile }
}
#define a task
task hello {
    input {
    File myName
    }
    #define command to execute when this task runs
    command {
        echo Hello World! > Hello.txt
        cat ${myName} >> Hello.txt
    }
    #specify the output(s) of this task so cromwell will keep track of them
    output {
        File outFile = "Hello.txt"
    }
}