#!/bin/sh
# 
# todo.sh
# - list all todos
# - add a todo
# - delete a todo
#
# Copyright (C) 2015 Kenju - All Rights Reserved
# https://github.com/KENJU/shellscript_todo

###################################################
# Utils
###################################################

show_help () {

	# cat <<- EOF | less
	echo "
	COPYRIGHT
			Copyright (C) 2015 Kenju - All Rights Reserved
			https://github.com/KENJU/shellscript_todo

	NAME
	    	todo - adds, lists, and deletes todo list with bash

	SYNOPSIS
			todo 
			todo -h
			todo --help
			todo [-a (title)]
			todo [--add (title)]
			todo [-d (title)]
			todo [--delete (title)]

	DESCRIPTION
			todo command is a program for adding, listing and deleting
			todo lists easily with bash.

	OPTIONS
			-a or --add
				add a new todo.

			-d or --delete
				delete an exsiting todo.

			-h or --help
				show a help page.

			-l or --list
				list all todos.

	BUGS
			Please reports bugs by adding issues on Github repo.
			The url is here:
				https://github.com/KENJU/shellscript_todo/issues

	----------------------August 19, 2015----------------------
	" | less
}

###################################################
# Base
###################################################

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
		show_help
		;;
	"-l")
		echo "list command"
		;;
	"--list")
		echo "list command"
		;;
	*)
		echo "run 'todo -h' for help"
		;;
esac