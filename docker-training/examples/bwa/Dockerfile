####################################################################################################
# Example Dockerfile to build a container for bwa
# To build image :
# from absolute path:
#   docker image build -f /root/bcc2020-training/examples/bwa/Dockerfile
# from within the directory containing the dockerfile:
#   docker image build .
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
RUN apt install -y bwa