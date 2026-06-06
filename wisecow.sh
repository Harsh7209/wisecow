#!/usr/bin/env bash

SRVPORT=4499

export PATH="/usr/games:$PATH"

prerequisites() {
command -v cowsay >/dev/null 2>&1 || exit 1
command -v fortune >/dev/null 2>&1 || exit 1
command -v nc >/dev/null 2>&1 || exit 1
}

handle_request() {
local mod
mod=$(fortune)

```
cat <<EOF
```

HTTP/1.1 200 OK
Content-Type: text/html
Connection: close

<pre>$(cowsay "$mod")</pre>

EOF
}

main() {
prerequisites

```
echo "Wisdom served on port=$SRVPORT..."

rm -f /tmp/wisecow.pipe
mkfifo /tmp/wisecow.pipe

while true; do
    handle_request > /tmp/wisecow.pipe &
    nc -l -p "$SRVPORT" < /tmp/wisecow.pipe
    wait
done
```

}

main
