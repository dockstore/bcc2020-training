##############################################################################################
#launch locally with DockstoreCLI:
#   dockstore workflow launch --local-entry HelloGoodbye-imports.wdl --json HelloGoodbye.json
###############################################################################################

version 1.0
# add import statements to bring in sub-workflows

# if alias is not given, it defaults to filename minus ‘.wdl’
# therefore the implicit alias here is 'HelloWorld'
import "HelloWorld.wdl"

# otherwise, namespace = <alias>
# therefore explicit alias here is 'bye'
import "GoodbyeWorld.wdl" as bye

workflow HelloGoodbye {
   #call the hello task, syntax: <alias>.taskname
   call HelloWorld.hello

   #call the goodbye task, syntax: <alias>.taskname
   call bye.goodbye {
     input: greeting = hello.outFile
   }
   #define workflow outputs, same as in non-imported version
   output { File hello_goodbye = goodbye.outFile }
}
