#!/usr/bin/env bash

SRVPORT=4499

prerequisites() {
    command -v cowsay >/dev/null 2>&1 || exit 1
    command -v fortune >/dev/null 2>&1 || exit 1
    command -v nc >/dev/null 2>&1 || exit 1
}

handleRequest() {
    # Read and discard HTTP request headers
    while read -r line; do
        [ "$line" = $'\r' ] && break
    done

    mod=$(fortune)

    cat <<EOF
HTTP/1.1 200 OK
Content-Type: text/html
Connection: close

<pre>$(cowsay "$mod")</pre>
EOF
}

main() {
    prerequisites
    echo "Wisdom served on port=$SRVPORT..."

    while true; do
        handleRequest | nc -l -p "$SRVPORT" -q 1
    done
}

main