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

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    curl \
    git \
    libopencv-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy the entire project context to the working directory
COPY . .

# Make the dependency script executable and run it
RUN chmod +x scripts/prepare_dependencies.sh && ./scripts/prepare_dependencies.sh

# Create a build directory and compile the project
RUN cmake -B build -S . && cmake --build build

# The final executable will be at /app/build/bin/example
CMD ["echo", "Build complete. You can run the executable via 'docker run' or extract it with 'docker cp'."] 