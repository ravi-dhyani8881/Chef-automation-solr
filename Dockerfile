# Use an official Ubuntu as a parent image
FROM ubuntu:22.04

# Set environment variables to avoid user interaction during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV CHEF_LICENSE=accept-silent
# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    curl \
    nano \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Chef-Solo
RUN curl -L https://www.chef.io/chef/install.sh | bash

# Create directories for cookbooks and configurations
RUN mkdir -p /var/chef/cookbooks /var/chef/config
RUN mkdir -p /var/chef/output

# Copy cookbooks to the image
COPY graphql /var/chef/cookbooks/graphql

# Copy configuration files to the image
COPY file.json /var/chef/cookbooks/graphql/file.json
COPY solo.rb /var/chef/config/solo.rb
COPY web.json /var/chef/config/web.json


# Define environment variables for the repository
ENV REPO_URL=https://github.com/ravi-dhyani8881/solr-docker.git
ENV REPO_DIR=/var/chef/output/gitRepo
ENV BRANCH_NAME=master


# Clone the repository and checkout the desired branch/commit
RUN git clone $REPO_URL $REPO_DIR \
    && cd $REPO_DIR \
    && git checkout $BRANCH_NAME 

# Set the directory as a safe directory
RUN git config --global --add safe.directory $REPO_DIR

# Set the working directory
WORKDIR /var/chef

# Add an entrypoint script to run chef-solo
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entry point
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Default command
#CMD ["chef-solo", "-c", "/var/chef/config/solo.rb", "-j", "/var/chef/config/web.json"]
