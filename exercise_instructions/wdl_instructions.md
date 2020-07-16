# WDL Training
This tutorial will provide you with an introduction to [WDL](https://openwdl.org/). WDL stands for Workflow Description Language. It is a language for creating complex workflows that can be run locally or in a cloud environment.

## Exercise 1
The Dockstore CLI can be used to run WDL workflows, among other things. Here we will use it to run a Hello World workflow.

Now lets launch the workflow using the Dockstore CLI.

First we will change to the correct directory:
```shell
cd /root/bcc2020-training/wdl-training/exercise1/
```

Now run the hello world workflow:
```shell
dockstore workflow launch --local-entry /root/bcc2020-training/HelloWorld.wdl --json hello.json
```

This will create a file in the current directory called Hello.txt. The contents will be based on the hello.json file.

## Exercise 2
Now we are going to parameterize a simple workflow. The workflow calls the flagstat command of the samtools software. It takes a sam file as input and produces alignment statistics.

The file we will be editing is **/root/bcc2020-training/wdl-training/exercise2/metrics.wdl**.

There are three things you must do to complete this exercise.
1. Set the runtime to use the samtools Docker container: quay.io/ldcabansay/samtools:latest
2. Parameterize the samtools command in the flagstat task
3. (Optional) If you make any new inputs, be sure to update the metrics.json file in the same directory

There are multiple solutions for this exercise. One can be found at **/root/bcc2020-training/wdl-training/exercise2/solution/** folder.

## Exercise 3
For the final exercise we are going to make a workflow that calls two tasks.
The first task is bwa, an aligner used to align sequence files to a reference. It produces a SAM alignment file.

The second task uses the samtools flagstat (metrics) command to evaulauate an alignment file (sam or bam) and produce a report of statistics about the alignment.

We walked through the two individual workflows for bwa and metrics, but now will combine them into one workflow. There are two ways we can approach this, either by with or without imports. We will use either the file /**root/bcc2020-training/wdl-training/exercise3/align_and_metrics.wdl** or **/root/bcc2020-training/wdl-training/exercise3/align_and_metrics_imports.wdl**, depending on which approach you choose.

The solutions to these exercises  can be found in **/root/bcc2020-training/wdl-training/exercise3/solution/** folder. There are solutions for with and without imports.