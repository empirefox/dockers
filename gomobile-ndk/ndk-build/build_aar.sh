set -e

export ANDROID_SDK_VERSION=$(${ANDROID_SDK}/tools/bin/sdkmanager --version)

function ndkArch() {
	case $1 in
	arm | arm64) echo $1 ;;
	386) echo x86 ;;
	amd64) echo x86_64 ;;
	esac
}

go_archs=(arm arm64 386 amd64)

function build_aar() {
	pkg=${@: -1}
	name=$(basename $pkg)

	cd $GOPATH/src/$pkg
	rm -f *.aar *.jar
	for arch in ${go_archs[@]}; do
		toolchain_dir=$TOOLCHAINS_DIR/$(ndkArch $arch)
		CC=$toolchain_dir/bin/clang CXX=$toolchain_dir/bin/clang++ \
			CGO_ENABLED=1 GOOS=android GOARCH=$arch \
			gomobile bind -target android/$arch -o ./$name-$arch.aar "$@"
	done

	zipmerge -S $name-arm.aar $name-arm64.aar $name-386.aar $name-amd64.aar
	mv $name-arm.aar $name.aar
	mv $name-arm-sources.jar $name-sources.jar
	rm -f $name-arm64.aar $name-386.aar $name-amd64.aar \
		$name-arm64-sources.jar $name-386-sources.jar $name-amd64-sources.jar
}
