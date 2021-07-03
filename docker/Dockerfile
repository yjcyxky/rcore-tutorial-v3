FROM ubuntu:18.04

LABEL Author Jingcheng Yang
LABEL Email yjcyxky@163.com

WORKDIR /app
USER root
ENV PATH "/opt/local/bin:/root/.cargo/bin:/code/built/qemu-5.0.0:/code/built/qemu-5.0.0/riscv64-softmmu:/code/built/qemu-5.0.0/riscv64-linux-user:${PATH}"

ADD sources.list /etc/apt/sources.list
RUN apt-get update && apt-get install -y curl wget gcc g++
RUN echo 'source $HOME/.cargo/env' >> $HOME/.bashrc

# 设置用户及密码，用于VSCode远程连接Docker容器
RUN echo "root:root" | chpasswd

ENV RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
ENV RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup
RUN curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain=nightly -y

COPY config ~/.cargo/config

RUN rustup target add riscv64gc-unknown-none-elf && \
    cargo install cargo-binutils --vers ~0.2 && \
    rustup component add llvm-tools-preview && \
    rustup component add rust-src

# 安装Qemu依赖
RUN apt-get update && apt-get install -y autoconf automake autotools-dev libmpc-dev libmpfr-dev libgmp-dev \
    gawk build-essential bison flex texinfo gperf libtool patchutils bc \
    zlib1g-dev libexpat-dev pkg-config libglib2.0-dev libpixman-1-dev git tmux python3
COPY qemu-5.0.0.tar.xz /tmp
RUN cd /tmp && tar xvJf qemu-5.0.0.tar.xz && \
    cd /tmp/qemu-5.0.0 && \
    ./configure --target-list=riscv64-softmmu,riscv64-linux-user && \
    make -j$(nproc) && \
    make install

# GDB
RUN wget https://static.dev.sifive.com/dev-tools/riscv64-unknown-elf-gcc-8.3.0-2020.04.1-x86_64-linux-ubuntu14.tar.gz
RUN mkdir -p /opt/local && tar -xzvf riscv64-unknown-elf-gcc-8.3.0-2020.04.1-x86_64-linux-ubuntu14.tar.gz -C /opt/local && \
    mv /opt/local/riscv64-unknown-elf-gcc-8.3.0-2020.04.1-x86_64-linux-ubuntu14/* /opt/local && rmdir /opt/local/riscv64-unknown-elf-gcc-8.3.0-2020.04.1-x86_64-linux-ubuntu14 && \
    rm -f riscv64-unknown-elf-gcc-8.3.0-2020.04.1-x86_64-linux-ubuntu14.tar.gz

# SSH Server
# Fix Bug: Missing privilege separation directory: /run/sshd
RUN apt-get install -y ssh vim nano && mkdir /run/sshd
# Fix Bug: 无法远程登录
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

EXPOSE 22

CMD [ "/usr/sbin/sshd", "-D" ]