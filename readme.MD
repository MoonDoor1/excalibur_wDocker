# Excalibur Docker Setup Guide

Getting Excalibur set up can be a major hassle. Hopefully, this repository will provide a working solution across different devices.

This repository builds upon the base installation provided by [williamjacksn/docker-excalibur](https://github.com/williamjacksn/docker-excalibur), correcting some errors encountered during setup:

The `camelot.ext` module doesn't exist for downloading Ghostscript.
`PyPDF2` isn't downloaded by default. We've remedied these issues with our Dockerfile.


## Building and Running the Docker Image

Initialize the Docker image with the following command:

```bash
docker build -t custom-excalibur .
```


Then, run the Docker image on port 8080 with this command:

```bash
docker run -v ~/excalibur-data:/home/python/excalibur -p 8080:8080 custom-excalibur
```


Now, Excalibur should be up and running, accessible via <http://localhost:8080>.

## Fixes Applied

### Correcting the Ghostscript Import

To make the change to import Ghostscript correctly, add the following line to your Dockerfile:

```dockerfile
RUN sed -i 's/from camelot.ext.ghostscript import Ghostscript/from ghostscript import Ghostscript/g' /home/python/venv/lib/python3.9/site-packages/excalibur/tasks.py
```

### Installing Missing Python Package PyPDF2

To install the missing Python package `PyPDF2`, add this line to your Dockerfile:

```dockerfile
RUN /home/python/venv/bin/pip install --upgrade PyPDF2==2.12.1
```


### Verifying the Changes

Optionally, to verify that the change was made, include this line in your Dockerfile:

```dockerfile
RUN grep \"from ghostscript import Ghostscript\" /home/python/venv/lib/python3.9/site-packages/excalibur/tasks.py
```


