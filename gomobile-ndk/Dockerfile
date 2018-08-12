FROM runmymind/docker-android-sdk:ubuntu-standalone

# platforms according to gomobile
RUN $ANDROID_HOME/tools/bin/sdkmanager "build-tools;27.0.3" "platforms;android-15"

# Golang --------
# Copied from official golang:1.10, added tools
# gcc for cgo
RUN apt-get update && apt-get install -y --no-install-recommends \
		autoconf \
		automake \
		bsdtar \
        clang \
		g++ \
		gcc \
		libc6-dev \
		libtool \
		make \
		pkg-config \
		python \
		zipmerge \
	&& rm -rf /var/lib/apt/lists/*

ENV GOLANG_VERSION 1.10.3

RUN set -eux; \
	\
# this "case" statement is generated via "update.sh"
	dpkgArch="$(dpkg --print-architecture)"; \
	case "${dpkgArch##*-}" in \
		amd64) goRelArch='linux-amd64'; goRelSha256='fa1b0e45d3b647c252f51f5e1204aba049cde4af177ef9f2181f43004f901035' ;; \
		armhf) goRelArch='linux-armv6l'; goRelSha256='d3df3fa3d153e81041af24f31a82f86a21cb7b92c1b5552fb621bad0320f06b6' ;; \
		arm64) goRelArch='linux-arm64'; goRelSha256='355128a05b456c9e68792143801ad18e0431510a53857f640f7b30ba92624ed2' ;; \
		i386) goRelArch='linux-386'; goRelSha256='3d5fe1932c904a01acb13dae07a5835bffafef38bef9e5a05450c52948ebdeb4' ;; \
		ppc64el) goRelArch='linux-ppc64le'; goRelSha256='f3640b2f0990a9617c937775f669ee18f10a82e424e5f87a8ce794a6407b8347' ;; \
		s390x) goRelArch='linux-s390x'; goRelSha256='34385f64651f82fbc11dc43bdc410c2abda237bdef87f3a430d35a508ec3ce0d' ;; \
		*) goRelArch='src'; goRelSha256='567b1cc66c9704d1c019c50bef946272e911ec6baf244310f87f4e678be155f2'; \
			echo >&2; echo >&2 "warning: current architecture ($dpkgArch) does not have a corresponding Go binary release; will be building from source"; echo >&2 ;; \
	esac; \
	\
	url="https://dl.google.com/go/go${GOLANG_VERSION}.${goRelArch}.tar.gz"; \
	wget -q -O go.tgz "$url"; \
	echo "${goRelSha256} *go.tgz" | sha256sum -c -; \
	tar -C /usr/local -xzf go.tgz; \
	rm go.tgz; \
	\
	if [ "$goRelArch" = 'src' ]; then \
		echo >&2; \
		echo >&2 'error: UNIMPLEMENTED'; \
		echo >&2 'TODO install golang-any from jessie-backports for GOROOT_BOOTSTRAP (and uninstall after build)'; \
		echo >&2; \
		exit 1; \
	fi; \
	\
	export PATH="/usr/local/go/bin:$PATH"; \
	go version

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/bin" && chmod -R 777 "$GOPATH"



# Android NDK --------
ENV ANDROID_NDK_HOME /opt/android-ndk
ENV ANDROID_NDK_VERSION r17b
# download
RUN mkdir /opt/android-ndk-tmp && \
    cd /opt/android-ndk-tmp && \
    wget -q -O android-ndk.zip https://dl.google.com/android/repository/android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip && \
# uncompress
    unzip -q android-ndk.zip && \
# move to its final location
    mv ./android-ndk-${ANDROID_NDK_VERSION} ${ANDROID_NDK_HOME} && \
# remove temp dir
    cd ${ANDROID_NDK_HOME} && \
    rm -rf /opt/android-ndk-tmp

# add to PATH
ENV PATH ${PATH}:${ANDROID_NDK_HOME}



# Gomobile --------
# COPY gomobile-patch.go /
RUN go get golang.org/x/mobile/cmd/gomobile && \
	# # start hack gomobile
	# cd ${GOPATH}/src/golang.org/x/mobile/cmd/gomobile && \
	# # hack PKG_CONFIG https://autotools.io/pkgconfig/cross-compiling.html
	# mv /gomobile-patch.go ./ && \
	# sed -i '/\"GOOS=android\",/a toolchain.PatchEnv1(), toolchain.PatchEnv2(),' ./env.go && \
	# # hack install the first time with cgo to generate java sources
	# sed -i '/if bindBootClasspath/i cmd.Env = androidEnv["arm"]' ./bind_androidapp.go && \
	# go install -ldflags "-s -w" . && \
	# # hack end
	gomobile init -ndk ${ANDROID_NDK_HOME} && \
	rm -rf $GOPATH/src

ENV TOOLCHAINS_DIR $GOPATH/pkg/gomobile/ndk-toolchains
ENV NDK_BUILD_UTILS_DIR /opt/ndk-build
COPY ndk-build $NDK_BUILD_UTILS_DIR
# docker build --build-arg https_proxy=http://172.17.0.1:7777 -t empirefoxit/gomobile-ndk .