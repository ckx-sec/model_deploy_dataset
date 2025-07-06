# Use official Ubuntu 20.04 as a base image for ARM64
FROM --platform=linux/arm64 ubuntu:20.04

# Set DEBIAN_FRONTEND to noninteractive to avoid prompts during apt-get install
ENV DEBIAN_FRONTEND=noninteractive

# Set the working directory inside the container
WORKDIR /app

# Replace sources.list with Tsinghua University mirrors (http first)
RUN echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ focal main restricted universe multiverse" > /etc/apt/sources.list && \
    echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ focal-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ focal-backports main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ focal-security main restricted universe multiverse" >> /etc/apt/sources.list

# Install ca-certificates to enable https, then switch sources to https
RUN apt-get update && \
    apt-get install -y ca-certificates && \
    sed -i 's/http/https/g' /etc/apt/sources.list

# Install essential packages
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    curl \
    git \
    wget \
    unzip \
    vim \
    clang \
    lld \
    libopencv-dev \
    && rm -rf /var/lib/apt/lists/*

# We need a higher version of cmake than the one available in the default ubuntu 20.04 repos
# so we install it from the kitware apt repository. See https://apt.kitware.com/
# We need to install the dependencies of cmake first.

# Copy the entire project context to the working directory
COPY . .

# Download and install third-party libraries
RUN chmod +x scripts/prepare_dependencies.sh && ./scripts/prepare_dependencies.sh 