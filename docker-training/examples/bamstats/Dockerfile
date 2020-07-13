#############################################################
# Dockerfile to build a sample container for samtools
# To build:
#
#############################################################

# Start with a base image
FROM ubuntu:14.04

# Add file author/maintainer and contact info (optional)
MAINTAINER Brian OConnor <briandoconnor@gmail.com>

# install software dependencies
USER root
RUN apt-get -m update && apt-get install -y wget unzip \
    openjdk-7-jre zip

# manual software installation from source
# get the tool and install it in /usr/local/bin
RUN wget -q http://downloads.sourceforge.net/project
/bamstats/BAMStats-1.25.zip

# commands/scripts to finish software setup
RUN unzip BAMStats-1.25.zip && \
    rm BAMStats-1.25.zip && \
    mv BAMStats-1.25 /opt/

COPY bin/bamstats /usr/local/bin/
RUN chmod a+x /usr/local/bin/bamstats

# switch back to the ubuntu user so this tool (and the files written) are not owned by root
RUN groupadd -r -g 1000 ubuntu && useradd -r -g ubuntu -u 1000 -m ubuntu
USER ubuntu

# by default /bin/bash is executed
CMD ["/bin/bash"]
