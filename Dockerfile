# Use Debian as base
FROM debian:latest

# Install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    frr \
    wireguard \
    python3 python3-pip \
    procps \
    && rm -rf /var/lib/apt/lists/*

# Create magic-wan directory
RUN mkdir -p /magic-wan

# Copy necessary files to magic-wan directory
COPY scripts/* /magic-wan/
# Install python script requirements
RUN ls -lah /usr/bin/python3
RUN /usr/bin/pip install --no-cache-dir pyyaml

# Set the entrypoint script
RUN chmod +x /magic-wan/*.sh

# Set working directory to /magic-wan
WORKDIR /magic-wan

# Define entrypoint
ENTRYPOINT ["/magic-wan/entrypoint.sh"]
