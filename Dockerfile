FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# =========================
# System Dependencies
# =========================
RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip \
    openjdk-17-jdk \
    wget \
    curl \
    build-essential \
    ccache \
    automake \
    autoconf \
    libtool \
    pkg-config \
    zlib1g-dev \
    libncurses5-dev \
    libffi-dev \
    libssl-dev \
    python3-pip \
    python3-venv \
    python3-dev \
    cmake \
    ant \
    lld \
    && rm -rf /var/lib/apt/lists/*

# =========================
# Python 3.10 (via deadsnakes)
# =========================
RUN apt-get update && apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && apt-get install -y \
    python3.10 \
    python3.10-dev \
    python3.10-venv \
    && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.10 1

# pip for python 3.10
RUN python3.10 -m ensurepip && \
    python3.10 -m pip install --upgrade pip

# =========================
# Python tools
# =========================
RUN pip install --no-cache-dir \
    wheel \
    setuptools \
    "cython<3"  \
    buildozer \
    python-for-android

# =========================
# Android SDK
# =========================
ENV ANDROID_SDK_ROOT=/opt/android-sdk
ENV ANDROID_HOME=/opt/android-sdk

RUN mkdir -p $ANDROID_SDK_ROOT

RUN wget -q https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O cmdline-tools.zip && \
    mkdir -p $ANDROID_SDK_ROOT/cmdline-tools && \
    unzip cmdline-tools.zip -d $ANDROID_SDK_ROOT/cmdline-tools && \
    mv $ANDROID_SDK_ROOT/cmdline-tools/cmdline-tools $ANDROID_SDK_ROOT/cmdline-tools/latest && \
    rm cmdline-tools.zip

ENV PATH="$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$PATH"

# =========================
# Install SDK components
# =========================
RUN yes | sdkmanager --licenses

RUN sdkmanager --sdk_root=$ANDROID_SDK_ROOT \
    "platform-tools" \
    "platforms;android-31" \
    "build-tools;31.0.0" \
    "ndk;25.2.9519653"

# =========================
# Environment for p4a/buildozer
# =========================
ENV ANDROIDNDK=$ANDROID_SDK_ROOT/ndk/25.2.9519653
ENV ANDROIDAPI=31
ENV NDKAPI=21

# =========================
# Workdir
# =========================
WORKDIR /app

CMD ["/bin/bash"]
