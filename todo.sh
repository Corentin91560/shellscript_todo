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
# Consts
###################################################
version="1.0.0"
root_dir=~/.todo
root_file=~/.todo/.todolist

###################################################
# Utils
###################################################

##
# show help
# 
show_help () {

	# cat <<- EOF | less
	echo "
	---------------------------Commands Manual---------------------------

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
			todo -l
			todo --list
			todo -r
			todo --reset

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

			-r or --reset
				delete all todos.

	VERSION
			Currently the version of todo is $version.
			Please visits Github releases page for changelogs.
				https://github.com/KENJU/shellscript_todo/releases


	BUGS
			Please reports bugs by adding issues on Github repo.
			The url is here:
				https://github.com/KENJU/shellscript_todo/issues

	---------------------------August 19, 2015---------------------------
	" | less
}

##
# add a new todo
# 
add_todo () {
	max_count=`wc -l < $root_file`
	max_count=$(($max_count+1))

	# if parameter is empty
	if [ $# = 0 ]
		then
			echo "run 'todo -h' for help"
	fi

	# if parameter is only one
	if [ $# = 1 ]
		then
			echo "$max_count : $1" >> $root_file
			echo "New Todo Added!"			
	fi

	# if parameter is multiple
	if [ $# -gt 1 ]
		then
			count=$#
			for param in $@
			do
				var=$var" "$param
			done
			echo "$max_count : $var" >> $root_file
			echo "New Todo Added!"						
	fi
}

##
# deletes todos with id
# 
delete_todo () {
	list_todos
	echo ""
	read -p "> Type todo id to delete : " id_to_delete
	echo $id_to_delete
	sed /^$id_to_delete/d $root_file > $root_file
}

##
# list all todos
# 
list_todos () {
	max_count=`wc -l < $root_file`
	echo "------------------------------------"
	echo "Total: "$max_count
	echo "------------------------------------"

	cat $root_file
}

##
# reset all todos
# 
reset_todos () {
	cp /dev/null $root_file
	echo "Delete All Todos."
}

##
# initialize and create a dir and filesfor todo list
# 
initialize () {

	if [ ! -d $root_dir ]
		then
			mkdir $root_dir
	fi

	if [ ! -f $root_file ]
		then
			touch $root_file
	fi

}

###################################################
# Base
###################################################

##
# initialize
# 
initialize

##
# execute commands depending on options
# 
case $1 in
	# add
	"-a")
		add_todo ${*:2}
		;;
	"--add")
		add_todo ${*:2}
		;;
	# delete
	"-d")
		delete_todo
		;;
	"--delete")
		delete_todo
		;;
	# show help
	"-h")
		show_help
		;;
	"--help")
		show_help
		;;
	# list todos
	"-l")
		list_todos
		;;
	"--list")
		list_todos
		;;
	# reset all todos
	"-r")
		reset_todos
		;;
	"--reset")
		reset_todos
		;;
	*)
		echo "run 'todo -h' for help"
		;;
esac