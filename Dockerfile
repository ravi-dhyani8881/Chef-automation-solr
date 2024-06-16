# Use an official Ubuntu as a parent image
FROM ubuntu:22.04

# Set environment variables to avoid user interaction during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV CHEF_LICENSE=accept-silent
# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Chef-Solo
RUN curl -L https://www.chef.io/chef/install.sh | bash

# Create directories for cookbooks and configurations
RUN mkdir -p /var/chef/cookbooks /var/chef/config

# Copy cookbooks to the image
COPY graphql /var/chef/cookbooks

# Copy configuration files to the image
COPY solo.rb /var/chef/config/solo.rb
COPY web.json /var/chef/config/node.json

# Run Chef-Solo to apply the cookbook
CMD ["chef-solo", "-c", "/var/chef/config/solo.rb", "-j", "/var/chef/config/node.json"]
