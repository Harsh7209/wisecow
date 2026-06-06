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

prerequisites() {
	command -v cowsay >/dev/null 2>&1 &&
	command -v fortune >/dev/null 2>&1 || 
		{ 
			echo "Install prerequisites."
			exit 1
		}
}

main() {
	prerequisites
	echo "Wisdom served on port=$SRVPORT..."
	while true; do
		socat TCP-LISTEN:$SRVPORT,reuseaddr,fork EXEC:'handleRequest'
	done
}

main