###################################################
#Exercise #2a: Writing your first Dockerfile: tabix
###################################################
# Start with a base image
FROM { base_image_name }

# Add file author/maintainer and contact info (optional)
MAINTAINER {your_name} <youremail@research.edu>

#set user you want to install packages as
USER root

#update package manager & install dependencies (if any)
RUN apt update

# install analysis software from package manager
RUN apt install { software_package_name }