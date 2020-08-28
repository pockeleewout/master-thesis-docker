FROM ubuntu:bionic
LABEL Description="Image that runs the CapsNet network, and starts tensorboard once a model is trained" Vendor="Ewout Pockelé <ewout.pockele@student.uantwerpen.be>" Version="0.1a"

# Update the container
RUN apt update && apt upgrade -y --no-install-recommends

# Install Python, pip and Git
RUN apt install -y --no-install-recommends python3 python3-pip git

# Copy my requirements file
COPY requirements.txt /root/requirements.txt

# Install everything from the requirements file
RUN pip3 install --quiet --no-cache-dir -r /root/requirements.txt

# Copy the run script
COPY run.sh /usr/local/bin/

CMD ["bash", "/usr/local/bin/run.sh"]

