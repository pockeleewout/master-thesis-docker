FROM ubuntu
LABEL Description="Image that runs the CapsNet network, and starts tensorboard once a model is trained" Vendor="Ewout Pockelé <ewout.pockele@student.uantwerpen.be>" Version="0.1a"

# Update the container
RUN apt update && apt upgrade -y --no-install-recommends

# Install Python, pip and Git
RUN apt install -y --no-install-recommends python3 python3-pip git

# Install PyTorch
RUN pip install pytorch=="1.0.1" torchvision=="0.2.1"

# Set the current working directory to the mounted project directory
RUN mkdir -p /project/ewout/CapsNet

CMD ["sh", "run.sh"]

