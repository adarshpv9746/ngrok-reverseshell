if [ -n "$1" ]; then
	echo "starting ngrok on port $1"
	ngrok http --url=moccasin-summary-ape.ngrok-free.app $1
else 
	echo "usage: ./ngrok portNum"
fi
