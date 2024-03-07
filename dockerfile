# Start with the Excalibur base image
FROM ghcr.io/williamjacksn/excalibur

# Install patch utility and clean up in a single RUN to reduce image size
USER root
RUN apt-get update && \
    apt-get install -y patch && \
    rm -rf /var/lib/apt/lists/*

# Apply the modification directly
RUN sed -i 's/from camelot.ext.ghostscript import Ghostscript/from ghostscript import Ghostscript/g' /home/python/venv/lib/python3.9/site-packages/excalibur/tasks.py

# Install missing Python package
RUN /home/python/venv/bin/pip install --upgrade PyPDF2==2.12.1

# Optionally, verify the change was made
RUN grep "from ghostscript import Ghostscript" /home/python/venv/lib/python3.9/site-packages/excalibur/tasks.py

# Continue with any other setup...