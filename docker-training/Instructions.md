# Docker Training
This tutorial will provide you with an introduction to Docker. It is split into two parts. First, there is an introduction to the Docker command line. Next, we will have you create and run your very own Dockerfile.

Note: This training was originally completed on the Instruqt platform. This platform had all of the prerequisites installed.

## Exercise 1
The Docker CLI is a command-line tool with a whole library of commands for interacting with Docker. This exercise will get you familiar with some of the most common commands and have you running some simple Docker containers.

### Optional Background - Using Docker
During the training we go through this interactively, but for future reference here are some Docker CLI commands with some explanations.

#### View all available commands using the help option:
```shell
ubuntu$ docker help
```
There are a ton of available commands here, and we won't be able to go through all of them. For now, we will focus on those most important from running containers.

#### Display system-wide information about your installation of Docker:
```shell
ubuntu$ docker info
```
This command tells us some useful information, such as the memory assigned to the Docker daemon, the number of images we have, etc. It won't all make sense now, however as you gain experience with Docker you'll learn more about what is displayed here. 

#### Manage Docker images:
```shell
ubuntu$ docker image help
```
From this command you can see there are a lot of subcommands you can make regarding Docker images. This tutorial will look at **build** and **ls**.

#### Manage Docker containers:
```shell
ubuntu$ docker container help
```
From this command you can see there are a lot of subcommands you can make regarding Docker containers. This tutorial will look at **run** and **ls**.

#### Run the official hello-world Docker container from DockerHub:
```shell
ubuntu$ docker run hello-world
```
This is just a simple container that confirms that your Docker environment is properly setup. On your first time running this command, you'll notice the following message
```shell
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
```
This means that the Docker daemon cannot find the image locally, so it must do a pull from DockerHub. This only happens the first time the container is run, since once the image is downloaded it can be reused.

#### View our built Docker images
```shell
ubuntu$ docker image ls
```
This command lists all images that you have installed on your machine. You should see one entry here for the hello-world image. The latest tag is pulled by default, though we could have specified another tag in the previous command if we wanted to use a specific version of the image..

#### View our running Docker containers
```shell
ubuntu$ docker container ls
```
Even though we ran the hello-world docker container, you shouldn't see any output from the above command. This is because hello-world prints the welcome message and then immediately quits. If you had a longer running command (ex. sequence alignment to a reference genome) that may take hours, then you can use this command to view if it is still running.

### Part A - Running Containers
Running a container can be as simple as one command! In the previous section you used the Docker CLI to run a basic hello-world container. In this section you will try running a slightly more advanced container called whalesay. Whalesay is a program that given some text, will print out an ASCII whale that is saying the text. It is based on a program called cowsay.

The format for the run command is shown below
```shell
ubuntu$ docker run [-flag options] [registry name]/[path in image repository]:[tag] [arguments]
```

You can check out the [reference documentation](https://docs.docker.com/engine/reference/run/) for the run command to learn more.

Running whalesay is a bit more complex than hello-world, but not by much. Run whalesay with the following command:
```shell
ubuntu$ docker run docker/whalesay cowsay hello
```

This will result in an ASCII whale saying hello! Now try getting the whale to say "Hello [your name]!".

### Part B - Exploring Containers
The two previous Docker containers that we ran performed a function and then quit immediately. This is usually the flow that most bioinformatic tools follow, however sometimes you may want to enter a container and perform many commands.

The Docker run command has two useful flags that can be used.

_-i_ : keeps STDIN open for interactive use

_-t_ : allocated a terminal

Let us try entering the samtools container and verifying that samtools is installed. [Samtools](http://www.htslib.org/) is "a suite of programs for interacting with high-throughput sequencing data". For this exercise, we will use an image written by [biocontainers](https://biocontainers.pro/). run the following command to enter the container:
```shell
ubuntu$ docker run -it biocontainers/samtools:v1.9-4-deb_cv1 /bin/bash
```

The trick here is that the command we ran is **/bin/bash** and the -it. This allows us to enter the shell of the container.

To confirm you are in the container, you should see the bash prompt has changed to something like "biodocker@xyz". Now that we are inside the container, let's confirm that samtools is installed.

First determine where samtools is installed:
```shell
biodocker@xyz$ which samtools
```

Now try invoking samtools by displaying help:
```shell
biodocker@xyz$ samtools --help
```

Awesome! You have now installed samtools without having to worry about running make, updating the PATH, or anything like that.

Now exit the container by pressing ctrl-D.

You may be wondering, now that we have samtools running in a container, how do I actually get data to it? This will be covered in the next section.

### Part C - Exploring Containers (Take home exercise)
Sharing data with a container is quite straightforward. During the run command, we pass along an extra flag which maps a folder on the host machine to a folder on the container. Note that if the folder does not exist on the container, it will be created.

For simplicity, we will try sharing a simple text file with our whalesay container.

Create a folder called host-folder in your current directory and add a file called hello.txt. Let's put "Hello world" in the file.

```shell
ubuntu$ mkdir host-folder
ubuntu$ echo "Hello world" > host-folder/hello.txt
```

Now try running whalesay with this shared folder.
```shell
ubuntu$ docker run -v “$(pwd)”/host-folder:/tmp/container-folder -it docker/whalesay /bin/bash
```

Now list the contents of /tmp/container-folder on the container and you should see hello.txt.
```shell
root$ ls /tmp/container-folder
```

Try running whalesay (cowsay) and printing the output to a file in the shared folder.
```shell
root$ cowsay hello > /tmp/container-folder/whalesay.txt
```

Exit the container with ctrl-D and then list the contents of ./host-folder. You should see whalesay.txt! Let's print it out to see the result.
```shell
ubuntu$ cat host-folder/whalesay.txt
```

### Part D - Run samtools sort (Take home exercise)
As you can see, sharing data between host and container is very useful. Perhaps you have a folder with a BAM file (host-folder/my.bam), and you want to run **samtools sort** on the file. We would use the -v flag to map the host folder with the BAM file to a folder in the container.

You could run the following command to generate a sorted BAM file:
```shell
ubuntu$ docker run -v "$(pwd)"/host-folder:/data biocontainers/samtools:v1.9-4-deb_cv1 samtools sort my.bam -o /data/my.sorted.bam
```

Now it is your turn. Find a BAM file online and try running this command. See http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeUwRepliSeq/ for some smaller BAMS.

Check the shared folder on the host to ensure that the sorted BAM file has been saved.
```shell
ubuntu$ ls host-folder
```

## Exercise 2
This exercise will have you writing, building, and running your own Dockerfile.

### Part A - Writing your first Dockerfile
A [Dockerfile](https://docs.docker.com/engine/reference/builder/) is used to describe how to create images. Using the Dockerfile for BWA (bwa.Dockerfile) as a guideline, create a Dockerfile for tabix (Dockerfile).

Hints:
Both Dockerfiles use the same base image.
Tabix also uses apt for installation.

See the solutions folder for the answer to this exercise.

Once you've created the Dockerfile, it is time to build it.
```shell
ubuntu$ docker image build . -t tabix
```

Your Docker image has now been built! The next step is to try running the Docker image.

### Part B - Try out your new container
First we must determine the image ID of the image we just created. Run the following command and look for the image called tabix:
```shell
ubuntu$ docker image ls
```

Now that we know the ID of the image, we can create a running container. Let's print out the tabix help message to confirm that the container can be run.
```shell
ubuntu$ docker run [image id] tabix
```

You should see the help message from tabix. Congratulations! You have successfully created and ran your first Dockerfile.