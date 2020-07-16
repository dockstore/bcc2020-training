####################################################################################################
# Solution Exercise #2a: Writing your first Dockerfile: tabix
# To build image :
# from absolute path:
#   docker image build -t tabix:v10 -f /root/bcc2020-training/docker-training/exercise2/solution/Dockerfile .
# from within the directory containing the dockerfile:
#   docker image build -t tabix:v10 .
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