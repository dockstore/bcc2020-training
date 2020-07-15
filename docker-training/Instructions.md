# Docker Training
This tutorial will provide you with an introduction to Docker. It is split into two parts. First, there is an introduction to using the Docker command line to run a workflow. Next, we will have you create and run your very own Dockerfile.

## Exercise 1
The Docker CLI is a command-line tool with a whole library of commands for interacting with Docker. This exercise will get you familiar with the docker run command, which is used for running containers.


### Part A - Running Containers
In this section you will try running a basic container called whalesay. Whalesay is a program that given some text, will print out an ASCII whale that is saying the text. It is based on a program called cowsay.

The format for the run command is shown below
```shell
docker run [-flag options] [registry name]/[path in image repository]:[tag] [arguments]
```

You can check out the [reference documentation](https://docs.docker.com/engine/reference/run/) for the run command to learn more.

Running whalesay is a bit more complex than hello-world, but not by much. Run whalesay with the following command:
```shell
docker run docker/whalesay cowsay hello
```

This will result in an ASCII whale saying hello! Now try getting the whale to say "Hello [your name]!".
```shell
docker run docker/whalesay cowsay hello
 _______ 
< hello >
 ------- 
    \
     \
      \     
                    ##        .            
              ## ## ##       ==            
           ## ## ## ##      ===            
       /""""""""""""""""___/ ===        
  ~~~ {~~ ~~~~ ~~~ ~~~~ ~~ ~ /  ===- ~~~   
       \______ o          __/            
        \    \        __/             
          \____\______/   

```

### Part B - Exploring Containers
The two previous Docker containers that we ran performed a function and then quit immediately. This is usually the flow that most bioinformatic tools follow, however sometimes you may want to enter a container and perform many commands. Or perhaps you are developing an image and want to test it out.

The Docker run command has two useful flags that can be used.

_-i_ : keeps STDIN open for interactive use

_-t_ : allocated a terminal

Let us try entering the samtools container and verifying that samtools is installed. [Samtools](http://www.htslib.org/) is "a suite of programs for interacting with high-throughput sequencing data". For this exercise, we will use an image written by [biocontainers](https://biocontainers.pro/).

Run the following command to enter the container:
```shell
docker run -it biocontainers/samtools:v1.9-4-deb_cv1 /bin/bash
```

The trick here is that the command we ran is **/bin/bash** and the -it. This allows us to enter the shell of the container.

**To confirm you are in the container, you should see the bash prompt has changed to something like "biodocker@xyz".**

Now that we are inside the container, let's confirm that samtools is installed. First determine where samtools is installed:
```shell
which samtools
```

Now try invoking samtools by displaying help:
```shell
samtools --help
```

Awesome! You have now installed samtools without having to worry about running make, updating the PATH, or anything like that.

Now exit the container by pressing ctrl-D.

You may be wondering, now that we have samtools running in a container, how do I actually get data to it? This will be covered in the next section.

### Part C - Exploring Containers (Take home exercise)
Sharing data with a container is quite straightforward. During the run command, we pass along an extra flag which maps a folder on the host machine to a folder on the container.

Let's use the samtools Docker container to convert a SAM file to a BAM file. We will use the /data/mini.sam file.
The mapping that we want is /data on the host machine to the /data in the container. Note these paths do not need match, they just happen to in this example.

First we will confirm that the SAM file is accessible in the docker container.
```shell
docker run -v /data:/data -it biocontainers/samtools:v1.9-4-deb_cv1 /bin/bash
```

Now that we are inside the samtools container, list the contents of the /data directory.
```shell
ls /data
```

You should see the contents of the host folder /data now available within the container at /data.

We don't need to enter the container to run commands. We can run from our host machine directly.
The following command will convert our SAM file into a BAM file and display it to STDOUT:
```shell
docker run -v /data:/data biocontainers/samtools:v1.9-4-deb_cv1 samtools view -S -b /data/mini.sam -o /data/mini.bam
```

## Exercise 2
This exercise will have you writing, building, and running your own Dockerfile.

### Part A - Writing your first Dockerfile
A [Dockerfile](https://docs.docker.com/engine/reference/builder/) is used to describe how to create images. Using the Dockerfile for BWA as a guideline, create a Dockerfile for tabix by updating the existing Dockerfile.

BWA Dockerfile - /docker-training/exercise2/bwa-example/Dockerfile
Tabix Dockerfile - /docker-training/exercise2/Dockerfile

Hints:
Both Dockerfiles use the same base image.
Tabix also uses apt for installation.

See the solutions folder for the answer to this exercise.

Once you've created the Dockerfile, it is time to build it. Change into the /docker-training/exercise2 directory and then run the following command.
```shell
docker image build -t tabix .
```

The period means to build the Dockerfile in the current directory.

Your Docker image has now been built! The next step is to try running the Docker image.

### Part B - Try out your new container
First we must determine the image ID of the image we just created. Run the following command and look for the image called tabix. Copy the content from the Image ID column.
```shell
docker image ls
```

Now that we know the ID of the image, we can create a running container. Let's print out the tabix help message to confirm that the container can be run.
```shell
docker run [image id] tabix
```

You can also run the container by referencing the image name and tag.
```shell
docker run tabix:latest tabix
```

You should see the help message from tabix. Congratulations! You have successfully created and ran your first Dockerfile.