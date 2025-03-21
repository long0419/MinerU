# Use the full Python 3.10 image
FROM python:3.10.16-bookworm

# Set the working directory inside the container
WORKDIR /app

# 更新源：创建新的 sources.list
RUN echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware" > /etc/apt/sources.list && \
    echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware" >> /etc/apt/sources.list && \
    echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian-security bookworm-security main contrib non-free non-free-firmware" >> /etc/apt/sources.list

# Install system dependencies and clean up cache in one layer
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libglib2.0-dev \
    libsm6 \
    libxext6 \
    libxrender1 \
    libcairo2 \
    libjpeg62-turbo \
    libopenjp2-7 \
    libpng-dev \
    zlib1g-dev \
    libtiff-dev \
    libharfbuzz0b \
    libpango1.0-0 \
    libmagic1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 升级 pip
RUN pip install --upgrade pip -i https://pypi.tuna.tsinghua.edu.cn/simple

# 安装 magic-pdf
RUN pip install -U magic-pdf[full] --extra-index-url https://wheels.myhloli.com -i https://mirrors.aliyun.com/pypi/simple && \
    rm -rf /root/.cache/pip

CMD ["/bin/bash"]