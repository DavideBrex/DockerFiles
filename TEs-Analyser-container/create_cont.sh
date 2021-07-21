#!/bin/bash

## Run this script locally - you need root acces (sudo) ##
# you need both Docker (Docker version 20.10.6, build 370c289) 
# and Singularity (singularity-ce version 3.8.0) installed locally.

#go in the folder where the Dockefile is. CHANGE THE FOLDER NAME ACCORDINGLY
cd te-quant-cont

#build the container with docker
docker build -t bressandavide/tes-analyser-cont .  #-t you can give whatever name you want

# to convert from docker to singularity do:
sudo singularity build tes-analyser-cont.sif docker-daemon://tes-analyser-singcont:latest

