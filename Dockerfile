# Build a docker container for running python with rpy2 and pkern using the
# images at: https://hub.docker.com/_/python. This is a simplified version of
# the "base" docker set-up at the rpy2/rpy2-docker github repo
#
# I use `add-apt-repository` from 'software-properties-common' to make the CRAN
# repository known to apt-get, so that it finds a newer r-base release (4.13+)
# instead of the one bundled with Debian bullseye (4.0). Then it installs
# required python and R packages via pip and an Rscript call
# =============================================================================

# select a base image with python3 installed already (tested in host OS Debian)
FROM python:3

# set the working directory in the container
WORKDIR /code

# environmental variable to make dpkg behave without interactive dialogue
ENV DEBIAN_FRONTEND=noninteractive

# copy R and python requirements files to working directory in container
COPY requirements.txt .
COPY get_pkern_deps.R .

# the OpenPGP key for the third party (CRAN) repo needs to be added manually*
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key '95C0FAF38DB3CCAD0C080A7BDC78B2DDEABC47B7'

# install `add-apt-repository` function, use to add the CRAN repository for R
RUN apt-get update
RUN apt-get install -y --no-install-recommends software-properties-common
RUN add-apt-repository --yes "deb http://cloud.r-project.org/bin/linux/debian bullseye-cran40/"

# install r base and development libraries
RUN apt-get update
RUN apt-get install -y r-base
RUN apt-get install -y r-base-dev

# run an installer script to get required libraries for R
RUN Rscript get_pkern_deps.R

# install required python libraries
RUN pip install -r requirements.txt

# command to run on container start
CMD [ "python" ] 


# =============================================================================
# references
#
# *should I be using apt-key?
# https://www.linuxuprising.com/2021/01/apt-key-is-deprecated-how-to-add.html
#
# Docker for python
# https://www.docker.com/blog/containerized-python-development-part-1/
#
# R for Debian
# https://cran.r-project.org/bin/linux/debian/
# https://wiki.debian.org/DebianRepository/UseThirdParty#Sources.list_entry
#
# rpy2 and Docker
# https://rpy2.github.io/doc.html
# https://rpy2.github.io/doc/v3.4.x/html/index.html
# https://github.com/rpy2/rpy2-docker