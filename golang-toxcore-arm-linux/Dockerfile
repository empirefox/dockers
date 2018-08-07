FROM golang:1.10

RUN apt-get update && apt-get install -y --no-install-recommends \
		autoconf \
		automake \
		bsdtar \
		g++ \
		gcc \
		libc6-dev \
		libtool \
		make \
		pkg-config \
	&& rm -rf /var/lib/apt/lists/*

ENV ARM_BUILD_UTILS_DIR /opt/image-time
COPY image-time $ARM_BUILD_UTILS_DIR

ENV TOOLCHAINS_VERSION="6.4.1-2018.05-x86_64"
ENV TOOLCHAINS_DIR /opt/toolchains
RUN $ARM_BUILD_UTILS_DIR/get-toolchains.sh

ENV OPUS_VERSION 1.2.1
ENV OPUS_HASH cfafd339ccd9c5ef8d6ab15d7e1a412c054bf4cb4ecbbbcc78c12ef2def70732

ENV VPX_VERSION v1.7.0
ENV VPX_HASH 1fec931eb5c94279ad219a5b6e0202358e94a93a90cfb1603578c326abfc1238

ENV SODIUM_VERSION 1.0.16
ENV SODIUM_HASH eeadc7e1e1bcef09680fb4837d448fbdf57224978f865ac1c16745868fbd0533

ENV TOXCORE_VERSION 0.2.1
ENV TOXCORE_HASH 1496164954941b175493fba02bf3115118c0d29feb46cd1ff458a1a11eab1597

WORKDIR /opt/toxcore-arm-linux
RUN $ARM_BUILD_UTILS_DIR/install.sh

COPY build /usr/bin
CMD ["bash"]

# docker build --build-arg https_proxy=http://172.17.0.1:7777 -t empirefoxit/gomobile-ndk .