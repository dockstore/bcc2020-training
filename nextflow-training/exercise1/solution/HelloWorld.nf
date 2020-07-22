#!/usr/bin/env nextflow

////////////////////////////////////////////////////////////////////////////////////////////////
// Exercise 1: Run HelloWorld.nf locally with Dockstore CLI:
// first move to directory:
//   cd /root/bcc2020-training/nextflow-training/exercise1

// run workflow:
//   nextflow run HelloWorld.nf

////////////////////////////////////////////////////////////////////////////////////////////////

myName = file(params.myName)

process hello_world {
    input:
    file myName from myName

    output:
    file "Hello.txt" into hello_ch

    """
    echo Hello World! > Hello.txt
    cat ${myName} >> Hello.txt
    """
}