#!/usr/bin/env bash

SRVPORT=4499

get_api() {
	read line
	echo $line
}

handleRequest() {
    get_api > /dev/null
    local mod=$(fortune)
    cat <<EOF
HTTP/1.1 200 OK
Content-Type: text/html
Connection: close

<pre>$(cowsay "$mod")</pre>
EOF
}

main() {
	echo "Wisdom served on port=$SRVPORT..."
	
	while true; do
		nc -lN -p $SRVPORT -q 1 | handleRequest
	done
}

main