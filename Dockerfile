# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Install system dependencies
RUN apt update && apt install -y \
    git \
    cmake \
    build-essential \
    libeigen3-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    freeglut3-dev \
    mesa-common-dev \
    python3 \
    python3-dev \
    python3-venv \
    python3-pip \
    libboost-all-dev \
    libssl-dev \
    wget \
    unzip \
    libgtk2.0-dev \
    libgtk-3-dev \
    libgstreamer-plugins-base1.0-dev \
    libgstreamer1.0-dev \
    && apt clean && rm -rf /var/lib/apt/lists/*

# Clone and build OpenCV
WORKDIR /root
RUN git clone https://github.com/opencv/opencv.git && \
    cd opencv && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j$(nproc) && \
    make install && \
    ldconfig

# Clone and build Pangolin
WORKDIR /root
RUN git clone --recursive https://github.com/stevenlovegrove/Pangolin.git && \
    cd Pangolin && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j$(nproc) && \
    make install && \
    ldconfig

# Clone ORB-SLAM3
WORKDIR /root
RUN git clone https://github.com/UZ-SLAMLab/ORB_SLAM3.git ORB_SLAM3

# Replace CMakeLists.txt in ORB-SLAM3 with the updated version
COPY CMakeLists.txt /root/ORB_SLAM3/CMakeLists.txt

# Fix std::chrono::monotonic_clock issue
RUN cd /root/ORB_SLAM3 && \
    find . -type f -name '*.cc' -exec sed -i 's/std::chrono::monotonic_clock/std::chrono::steady_clock/g' {} +

# Build ORB-SLAM3
WORKDIR /root/ORB_SLAM3
RUN chmod +x build.sh && ./build.sh

# Set working directory
WORKDIR /root/ORB_SLAM3

# Default command
CMD ["bash"]

