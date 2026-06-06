# Updated implementation to use a named pipe (FIFO) between the response generator and netcat. This allows the HTTP response produced by handle_request to be forwarded correctly to the client socket instead of being written to stdout, resolving the empty-response issue.

#!/usr/bin/env bash

SRVPORT=4499

export PATH="/usr/games:$PATH"

prerequisites() {
command -v cowsay >/dev/null 2>&1 || exit 1
command -v fortune >/dev/null 2>&1 || exit 1
command -v nc >/dev/null 2>&1 || exit 1
}

handle_request() {
mod=$(fortune)

echo "HTTP/1.1 200 OK"
echo "Content-Type: text/html"
echo "Connection: close"
echo
echo "<pre>"
cowsay "$mod"
echo "</pre>"

}

main() {
prerequisites

echo "Wisdom served on port=$SRVPORT..."

rm -f /tmp/wisecow.pipe
mkfifo /tmp/wisecow.pipe

while true; do
    handle_request > /tmp/wisecow.pipe &
    nc -l -p "$SRVPORT" < /tmp/wisecow.pipe
    wait
done

}

main