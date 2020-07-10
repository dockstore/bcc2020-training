#######################################################
# Dockerfile to build a sample container for bwa
#######################################################

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
RUN apt install bwa