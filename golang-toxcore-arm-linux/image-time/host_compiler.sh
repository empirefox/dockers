function host_compiler() {
	case $1 in
	arm) echo arm-linux-gnueabihf ;;
	arm64) echo aarch64-linux-gnu ;;
	esac
}