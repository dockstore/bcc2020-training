#!/usr/bin/env nextflow

////////////////////////////////////////////////////////////////////////////////////////////////
// launch locally:
//   first move to directory:
//      cd /root/bcc2020-training/nextflow-training/exercise3/hello_examples/GoodbyeWorld/
// run workflow:
//   nextflow run GoodbyeWorld.nf
////////////////////////////////////////////////////////////////////////////////////////////////

 greeting = file(params.greeting)

 process goodbye_world {
     input:
     file greeting from greeting

     output:
     file "Goodbye.txt" into goodbye_ch

     """
     cat ${greeting} > Goodbye.txt
     echo See you later! >> Goodbye.txt
     """
 }