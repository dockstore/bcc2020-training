#!/usr/bin/env nextflow

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