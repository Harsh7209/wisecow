#!/usr/bin/env bash

SRVPORT=4499

get_api() {
	read line
	echo $line
}

handleRequest() {
    get_api > /dev/null
	mod=`fortune`

cat <<EOF
HTTP/1.1 200 OK
Content-Type: text/html
Connection: close

<pre>`cowsay $mod`</pre>
EOF
}

main() {
	echo "Wisdom served on http://localhost:$SRVPORT"
	echo "Press Ctrl+C to stop"
	
	while true; do
		socat TCP-LISTEN:$SRVPORT,reuseaddr,fork EXEC:'handleRequest'
	done
}

main