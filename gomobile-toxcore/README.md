# gomobile-toxcore

```go
// cat $GOPATH/src/test.com/empirefox/cgo-android/hello.go
package hello

/*
#cgo LDFLAGS: -ltoxencryptsave -ltoxcore -lsodium -lm
#include "tox/tox.h"
*/
import "C"
import (
	"fmt"
)

func Greetings() string {
	return fmt.Sprintf("C.tox_max_name_length() = %d", C.tox_max_name_length())
}
```

```bash
docker build -t empirefoxit/gomobile-ndk gomobile-ndk
docker build -t empirefoxit/gomobile-toxcore gomobile-toxcore

docker run --rm -it \
  -v $GOPATH/src:/go/src \
  empirefoxit/gomobile-toxcore \
  aar \
  test.com/empirefox/cgo-android
```

then cgo-android.aar(arm,arm64,386,amd64 in one) file will be there
```bash
$ ls $GOPATH/src/test.com/empirefox/cgo-android/
cgo-android.aar  cgo-android-sources.jar  hello.go
```