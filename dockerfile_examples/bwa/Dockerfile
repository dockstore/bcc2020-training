#############################################################
# Dockerfile to build a sample container for BWA
#############################################################

# Set the base image to Ubuntu
FROM ubuntu:18.04

# Add file author/maintainer and contact info (optional)
MAINTAINER Louise Cabansay <lcabansa@ucsc.edu>

#set user you want to install packages as
USER root

# install packages you want available in container
# https://www.howtoinstall.me/ubuntu/18-04/bwa/
RUN apt update
RUN apt install bwa
