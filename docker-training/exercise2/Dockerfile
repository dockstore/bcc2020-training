#######################################################################################################
# Exercise #2a: Writing your first Dockerfile: tabix
# To build image :
# from absolute path:
#   docker build -t tabix:v10 -f /root/bcc2020-training/docker-training/exercise2/Dockerfile .

# Alternatively, to build within the directory containing the dockerfile:
  # first move to directory:
#    cd /root/bcc2020-training/docker-training/exercise2/
  # then build image:
#    docker build -t tabix:v1.0
#######################################################################################################
# Start with a base image
FROM { base_image_name }

# Add file author/maintainer and contact info (optional)
MAINTAINER {your_name} <youremail@research.edu>

#set user you want to install packages as
USER root

#update package manager & install dependencies (if any)
RUN apt update

# install analysis software from package manager
RUN apt install -y { software_package_name }