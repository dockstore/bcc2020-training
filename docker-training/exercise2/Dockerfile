######################################################################################
# Exercise #2a: Writing your first Dockerfile: tabix
# To build image :
# from absolute path:
#   docker image build -f /root/bcc2020-training/docker-training/exercise2/Dockerfile
# from within the directory containing the dockerfile:
#   docker image build .
#######################################################################################
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