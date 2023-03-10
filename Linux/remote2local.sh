#!/bin/sh

if [ $1 = "help" ]; then

        echo "\n\t======= remote2local use manual =======\n"
        echo "  Usage:"
        echo "    sh remote2local.sh [Option] [Remote file/folder] [Remote username] [Remote IP addr]\n"
        echo "  Option:"
        echo "    help  show usage manual"  
        echo "    -e    execute"

        echo ""

elif [ $1 = "-e" ]; then

        echo "\nCopy remote machine $3@$4:$2 to local ~/remote/\n"

        rsync -avzh -e 'ssh -p 8022' --progress --protect-args "$3@$4:$2" ~/remote/

fi
