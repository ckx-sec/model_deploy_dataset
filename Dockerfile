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
    software-properties-common \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Add all necessary PPAs first
RUN add-apt-repository ppa:deadsnakes/ppa && \
    add-apt-repository ppa:ubuntu-toolchain-r/test

# Update package lists and install all required versions in one go
RUN apt-get update && \
    apt-get install -y \
    python3.10 \
    python3.10-dev \
    python3-pip \
    gcc-11 \
    g++-11

# Set new default versions for python and gcc/g++
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1 && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 2 && \
    update-alternatives --set python3 /usr/bin/python3.10 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 90 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 90 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 110 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 110 && \
    update-alternatives --set gcc /usr/bin/gcc-11 && \
    update-alternatives --set g++ /usr/bin/g++-11

# Upgrade CMake to a newer version required by ONNX Runtime
ENV CMAKE_VERSION=3.28.3
ENV CMAKE_VERSION_FULL=${CMAKE_VERSION}-linux-aarch64
RUN wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION_FULL}.sh \
    && chmod +x cmake-${CMAKE_VERSION_FULL}.sh \
    && ./cmake-${CMAKE_VERSION_FULL}.sh --skip-license --prefix=/usr/local \
    && rm cmake-${CMAKE_VERSION_FULL}.sh

# We need a higher version of cmake than the one available in the default ubuntu 20.04 repos
# so we install it from the kitware apt repository. See https://apt.kitware.com/
# We need to install the dependencies of cmake first.

# Copy the entire project context to the working directory
COPY . .

# Download and install third-party libraries
RUN chmod +x scripts/prepare_dependencies.sh && ./scripts/prepare_dependencies.sh 