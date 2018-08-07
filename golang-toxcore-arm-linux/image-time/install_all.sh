set -o errexit
set -o nounset
set -o pipefail

archs=(arm arm64)

function check_sha256() {
	if ! (echo "$1  $2" | sha256sum -c --status -); then
		echo "Error: sha256 of $2 doesn't match the known one."
		echo "Expected: $1  $2"
		echo -n "Got: "
		sha256sum "$2"
		exit 1
	else
		echo "sha256 matches the expected one: $1"
	fi
}

function install_all() {
	local name="$1"
	local version="$2"
	local hash="$3"
	local autogen="$4"

	check_sha256 $hash "${name}-$version.tar.gz"
	bsdtar --no-same-owner --no-same-permissions -xf ${name}*.tar.gz
	rm ${name}*.tar.gz
	cd ${name}*
	if [ "x$autogen" = 'xautogen' ]; then
		./autogen.sh
	fi
	for arch in ${archs[@]}; do
		LIB_BUILD_NAME=${name} ARCH=$arch $ARM_BUILD_UTILS_DIR/arch-build.sh
	done
	cd ..
	rm -rf ./${name}*
}
