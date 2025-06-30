# Use the user-provided builder image for ARM64
FROM ubuntu-arm-builder:latest

# Set the working directory inside the container
WORKDIR /app

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