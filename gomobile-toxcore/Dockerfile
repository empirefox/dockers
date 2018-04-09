FROM empirefoxit/gomobile-ndk

# platforms
RUN $ANDROID_HOME/tools/bin/sdkmanager "build-tools;27.0.3" "platforms;android-15" "platforms;android-21"

COPY android-build android-build

ENV SODIUM_VERSION 1.0.16
ENV SODIUM_HASH eeadc7e1e1bcef09680fb4837d448fbdf57224978f865ac1c16745868fbd0533
ENV TOXCORE_VERSION 0.2.1
ENV TOXCORE_HASH 1496164954941b175493fba02bf3115118c0d29feb46cd1ff458a1a11eab1597

ENV TOOLCHAINS_DIR ${GOPATH}/pkg/gomobile/ndk-toolchains
RUN android-build/install.sh

COPY aar /usr/bin
CMD ["bash"]