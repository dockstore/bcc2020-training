#!/usr/bin/env nextflow

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