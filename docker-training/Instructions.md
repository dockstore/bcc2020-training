# Docker Training
This tutorial will provide you with an introduction to Docker. It is split into two parts. First, there is an introduction to using the Docker command line to run a workflow. Next, we will have you create and run your very own Dockerfile.

## Exercise 1
The Docker CLI is a command-line tool with a whole library of commands for interacting with Docker. This exercise will get you familiar with the docker run command, which is used for running containers.


### Part A - Running Containers
In this section you will try running a basic container called whalesay. Whalesay is a program that given some text, will print out an ASCII whale that is saying the text. It is based on a program called cowsay.

Run whalesay with the following command:
```shell
docker run docker/whalesay cowsay hello
```

This will result in an ASCII whale saying hello! Now try getting the whale to say "Hello [your name]!".
```shell
docker run docker/whalesay cowsay "fill me in"
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
We will now try running a [Samtools](http://www.htslib.org/) container to convert SAM to BAM. We will be using our own Docker container found at quay.io/ldcabansay/samtools. First we will look at some concepts.
* Running containers interactively
* Sharing data between host and container

#### Running containers interactively
To run the container interactively, use the flags -i -t.

_-i_ : keeps STDIN open for interactive use

_-t_ : allocated a terminal


Run the following command to enter the container:
```shell
docker run -it quay.io/ldcabansay/samtools
```

Now that we are inside the container, let's confirm that samtools is installed. Try invoking samtools by displaying help:
```shell
samtools --help
```

Now exit the container by pressing ctrl-D.

#### Sharing data between host and container
With the run command, we can pass along an extra flag which maps a folder on the host machine to a folder on the container. In this case we will map the /root/data on the host machine to /data on the container.

Lets confirm that the files in /root/data are available on the container.
```shell
docker run -v /root/data:/data -it quay.io/ldcabansay/samtools
```

Now that we are inside the samtools container, list the contents of the /data directory.
```shell
ls /data
```
You should see many files, including mini.bam. We will be using this file in the next section.

Now exit the container by pressing ctrl-D.

#### Convert SAM file to BAM with the samtools container
Now we will  use the samtools Docker container to convert a SAM file to a BAM file. We will use the /data/mini.sam file on the host machine. The mapping that we want is /root/data on the host machine to the /data in the container.

We don't need to enter the container to run commands. We can run from our host machine directly.
The following command will convert our SAM file into a BAM file and store it to /data/mini.bam:
```shell
docker run -v /root/data:/data quay.io/ldcabansay/samtools samtools view -S -b /data/mini.sam -o /data/mini.bam
```

You can confirm that the file is now on the host machine at /root/data by calling ls on the directory or opening the /root/data/mini.bam file. Note that the file will look like gibberish since it is a binary.

## Exercise 2
This exercise will have you writing, building, and running your own Dockerfile.

### Part A - Writing your first Dockerfile
A [Dockerfile](https://docs.docker.com/engine/reference/builder/) is used to describe how to create images. Using the Dockerfile for BWA as a guideline, create a Dockerfile for tabix by updating the existing Dockerfile.

**BWA Dockerfile (Example)** - /docker-training/exercise2/bwa-example/Dockerfile

**Tabix Dockerfile (Edit this)** - /docker-training/exercise2/Dockerfile

Hints:
* Both Dockerfiles use the same base image.
* Tabix also uses apt for installation.

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