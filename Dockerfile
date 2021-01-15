## Temporary image to build the libraries and only save the needed artifacts
FROM ubuntu:20.04

# LISFLOOD DIR
ARG lisflood_dir=/lisflood-fp-bmi-v5.9
ENV lisflood_dir=lisflood_dir

# set non-interactive Docker build
ENV DEBIAN_FRONTEND=noninteractive

## install dependencies from respositories
RUN apt-get --fix-missing update \
    && apt-get install -y \
    git=1:2.25.1-1ubuntu3 \
    python3-pip=20.0.2-5ubuntu1.1 \
    && rm -rf /var/lib/apt/lists/* 

# clone taudem 
RUN git clone https://github.com/fernando-aristizabal/lisflood-fp-bmi.git $lisflood_dir

# COMPILE
RUN cd $lisflood_dir/lisflood-fp-bmi-v5.9 && \
    make

## ADDING FIM GROUP ##
ARG GroupID=1370800235
ARG GroupName=fim
RUN addgroup --gid $GroupID $GroupName
RUN umask 002
RUN newgrp $GroupName 

# Add tests to Path
#ENV PATH=$taudem_tests_dirs:$PATH

# add environment setting for python
ENV PYTHONUNBUFFERED=TRUE


