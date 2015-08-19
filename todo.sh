#!/bin/sh
# 
# todo.sh
# - list all todos
# - add a todo
# - delete a todo
#
# Copyright (C) 2015 Kenju - All Rights Reserved
# https://github.com/KENJU/git_shellscript 

if [ $# -eq 0 ]
	then
		echo "list command"
fi

case $1 in
	"-a")
		echo "add command"
		echo $2
		;;
	"--add")
		echo "add command"
		echo $2
		;;
	"-d")
		echo "delete command"
		echo $2
		;;
	"--delete")
		echo "delete command"
		echo $2
		;;
	"-h")
		echo "help command"
		;;
	"--help")
		echo "help command"
		;;
	*)
		echo "run todo -h for help"
		echo $2
		;;
esac