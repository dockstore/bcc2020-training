#############################################################
# Dockerfile to build a sample container for samtools
#############################################################

# Set the base image to Ubuntu
FROM ubuntu:18.04

# add file author/maintainer and contact info (optional)
MAINTAINER Louise Cabansay <lcabansa@ucsc.edu>

# install package dependencies you want available in container
RUN apt-get update && apt-get -y upgrade && \
	apt-get install -y \
	wget build-essential libncurses5-dev zlib1g-dev libbz2-dev liblzma-dev libcurl3-dev

# set a working directory where you want to download and install software
WORKDIR /usr/src

# get software files from an external source and download to working directory
RUN wget https://github.com/samtools/samtools/releases/download/1.10/samtools-1.10.tar.bz2 && \
	# decompress files
	tar xjf samtools-1.10.tar.bz2 && \
	# clean up compressed files, don't need them and reduces container size
	rm samtools-1.10.tar.bz2 && \
	# set up and installation commands for software
	cd samtools-1.10 && \
	./configure --prefix $(pwd) && \
	make

# add the path to the samtools directory to environment PATH
# needed so the executables can be found when running 'samtools' at command prompt
ENV PATH="/usr/src/samtools-1.10:${PATH}"
