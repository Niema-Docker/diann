# Minimal Docker image for DIA-NN using NVIDIA CUDA Ubuntu 24.04 base
FROM nvidia/cuda:13.1.0-base-ubuntu24.04

# install DIA-NN
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y python3 python3-matplotlib python3-numpy python3-pip unzip wget && \
    cd /tmp && \
    pip install --no-cache-dir --break-system-packages polars && \
    wget "https://github.com/vdemichev/DiaNN/releases/download/2.0/DIA-NN-2.7.0-Academia-Linux.zip" && \
    unzip DIA-NN-*.zip && \
    sed -i '1i #!/usr/bin/env python3' diann-*/*.py && \
    chmod a+x diann-*/diann-* && \
    mv diann-* /usr/local/bin/diann && \
    cd /usr/local/bin/diann && \
    for f in diann-* ; do ln -s "/usr/local/bin/diann/$f" "/usr/local/bin/$f" ; done && \
    rm -rf /tmp/*
