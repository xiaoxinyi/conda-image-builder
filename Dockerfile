FROM condaforge/mambaforge:latest AS builder0


FROM ubuntu:20.04 AS builder

#RUN sed -i 's#archive.ubuntu.com#mirrors.aliyun.com#g' /etc/apt/sources.list  \
#    && sed -i 's#security.ubuntu.com#mirrors.aliyun.com#g' /etc/apt/sources.list

ENV LANG=zh_CN.UTF-8 LANGUAGE=zh_CN:zh LC_ALL=zh_CN.UTF-8 DEBIAN_FRONTEND=noninteractive

RUN rm -rf  /etc/apt/sources.list.d/  && apt update

RUN apt-get update && apt-get install -y --no-install-recommends \
    supervisor \
    iputils-ping \
    wget \
    zsh \
    build-essential \FROM condaforge/mambaforge:latest AS builder0


FROM ubuntu:20.04 AS builder

#RUN sed -i 's#archive.ubuntu.com#mirrors.aliyun.com#g' /etc/apt/sources.list  \
#    && sed -i 's#security.ubuntu.com#mirrors.aliyun.com#g' /etc/apt/sources.list

ENV LANG=zh_CN.UTF-8 LANGUAGE=zh_CN:zh LC_ALL=zh_CN.UTF-8 DEBIAN_FRONTEND=noninteractive

RUN rm -rf  /etc/apt/sources.list.d/  && apt update

RUN apt-get update && apt-get install -y --no-install-recommends \
    supervisor \
    iputils-ping \
    wget \
    zsh \
    build-essential \
    cmake \
    git \
    curl \
    vim \
    tmux \
    ca-certificates \
    libjpeg-dev \
    zip \
    unzip \
    libpng-dev \
    openssh-server \
    autojump \
    language-pack-zh-hans \
    ttf-wqy-zenhei \
    libgl1-mesa-glx  \
    libglib2.0-0 \
    telnet \
    locales &&\
    rm -rf /var/lib/apt/lists/*


RUN locale-gen zh_CN.UTF-8
RUN dpkg-reconfigure locales


CMD ["supervisord", "-n"]

FROM builder as builder1

COPY --from=builder0 /opt/conda /opt/conda
ENV PATH /opt/conda/bin:$PATH
RUN mamba init zsh


FROM builder1 as builder2

WORKDIR /workspace
ADD environment.yml /environment.yml
RUN mamba env create -f /environment.yml && rm -rf /root/.cache
ENV PATH /opt/conda/envs/py38/bin:$PATH


    cmake \
    git \
    curl \
    vim \
    tmux \
    ca-certificates \
    libjpeg-dev \
    zip \
    unzip \
    libpng-dev \
    openssh-server \
    autojump \
    language-pack-zh-hans \
    ttf-wqy-zenhei \
    libgl1-mesa-glx  \
    libglib2.0-0 \
    telnet \
    locales &&\
    rm -rf /var/lib/apt/lists/*


RUN locale-gen zh_CN.UTF-8
RUN dpkg-reconfigure locales


CMD ["supervisord", "-n"]

FROM builder as builder1

COPY --from=builder0 /opt/conda /opt/conda
ENV PATH /opt/conda/bin:$PATH
RUN mamba init zsh


FROM builder1 as builder2

WORKDIR /workspace
ADD environment.yml /environment.yml
RUN mamba env create -f /environment.yml && rm -rf /root/.cache
ENV PATH /opt/conda/envs/py38/bin:$PATH

