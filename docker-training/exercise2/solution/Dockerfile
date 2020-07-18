####################################################################################################
# Solution Exercise #2a: Writing your first Dockerfile: tabix
# To build image :
  # from absolute path:
#    docker build -t tabix:v1.0 -f /root/bcc2020-training/docker-training/exercise2/solution/Dockerfile .

# Alternatively, to build within the directory containing the dockerfile:
  # first move to directory:
#    cd /root/bcc2020-training/docker-training/exercise2/solution/
  # then build image:
#    docker build -t tabix:v1.0 .
###################################################################################################

# Start with a base image
FROM ubuntu:18.04

# Add file author/maintainer and contact info (optional)
MAINTAINER Louise Cabansay <lcabansa@ucsc.edu>

#set user you want to install packages as
USER root

#update package manager & install dependencies (if any)
RUN apt update

# install analysis software from package manager
# instructions from: https://www.howtoinstall.me/ubuntu/18-04/bwa/
RUN apt install -y tabix