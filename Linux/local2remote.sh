#!/bin/sh

if [ $1 = "help" ]; then

	echo "\n\t======= local2remote use manual =======\n"
	echo "  Usage:"
	echo "    sh local2remote.sh [Option] [Local file/folder] [Remote username] [Remote IP addr] [Remote port]\n"
	echo "  Option:"
        echo "    help  show usage manual"
        echo "    -e    execute"

	echo ""

elif [ $1 = "-e" ]; then

	echo "\nCopy local file $2 to remote machine $3@$4 port $5:~/remote folder\n"

	rsync -avzh -e "ssh -p ${5}" --progress $2 $3@$4:~/remote/
fi
