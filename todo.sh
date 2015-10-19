#!/bin/sh
#
# ████████╗ ██████╗ ██████╗  ██████╗
# ╚══██╔══╝██╔═══██╗██╔══██╗██╔═══██╗
#    ██║   ██║   ██║██║  ██║██║   ██║
#    ██║   ██║   ██║██║  ██║██║   ██║
#    ██║   ╚██████╔╝██████╔╝╚██████╔╝
#    ╚═╝    ╚═════╝ ╚═════╝  ╚═════╝
#
#
# todo.sh
# - list all todos
# - add a todo
# - delete a todo
# - reset all todos
#
# Copyright (C) 2015 Kenju - All Rights Reserved
# https://github.com/KENJU/shellscript_todo

#############################################################################
# Consts
#############################################################################
# version
VERSION="1.3.0"
# root directory
ROOT_DIR=~/.todo
# root file for storing todo data
ROOT_FILE=~/.todo/.todolist

#############################################################################
# Utils
#############################################################################

#######################################
# Update todo.sh
#
# Globals:
# 	None
# Arguments:
# 	None
# Returns:
# 	None
#
#######################################
update () {
	# Create /usr/loca/bin
	if [ ! -d /usr/local/bin/ ]
		then
			mkdir /usr/local/bin/
	fi

	# Create bin file for todo.sh
	if [ -f /usr/local/bin/todo ]
		then
			rm /usr/local/bin/todo
	fi

	# Download
	echo "downloading..."
	curl -s https://raw.githubusercontent.com/KENJU/shellscript_todo/master/todo.sh > /usr/local/bin/todo;
	chmod u+x /usr/local/bin/todo;
	echo "Done updating!"
}

#######################################
# Show help
#
# Globals:
# 	None
# Arguments:
# 	None
# Returns:
# 	None
#
#######################################
show_help () {
	curl https://raw.githubusercontent.com/KENJU/shellscript_todo/master/MANUAL | less
}

#############################################################################
# todos
#############################################################################

#######################################
# Add a new todo
#
# Globals:
# 	ROOT_DIR
# 	ROOT_FILE
# Arguments:
# 	Titles
# Returns:
# 	None
#
#######################################
add_todo () {
	max_count=`tail -1 $ROOT_FILE | cut -d':' -f 1`
	max_count=$(($max_count+1))

	# if parameter is empty
	if [ $# = 0 ]
		then
			echo "run 'todo -h' for help"
	fi

	# if parameter is only one
	if [ $# = 1 ]
		then
			echo "$max_count : $1" >> $ROOT_FILE
			echo "New Todo Added!"
			echo "run 'todo -l' for listing all todos."
	fi

	# if parameter is multiple
	if [ $# -gt 1 ]
		then
			count=$#
			for param in $@
			do
				var=$var" "$param
			done
			echo "$max_count : $var" >> $ROOT_FILE
			echo "New Todo Added!"
			echo "run 'todo -l' for listing all todos."
	fi
}

#######################################
# Delete a todo with specific id
#
# Globals:
# 	ROOT_DIR
# 	ROOT_FILE
# Arguments:
# 	id
# Returns:
# 	None
#
#######################################
delete_todo () {

	list_todos
	echo ""
	read -p "> Type todo id to delete : " id_to_delete

	max_count=`tail -1 $ROOT_FILE | cut -d':' -f 1`
	echo $max_count
	if [ $id_to_delete -le $max_count ]
		then
			grep -v "^$id_to_delete " $ROOT_FILE > $ROOT_DIR/tmp && mv $ROOT_DIR/tmp $ROOT_FILE
			echo "Successfully deleted the todo."
		else
			echo "The ID's todo does not exists."
	fi
}

#######################################
# List all todos
#
# Globals:
# 	ROOT_FILE
# Arguments:
# 	None
# Returns:
# 	None
#
#######################################
list_todos () {
	total=`wc -l < $ROOT_FILE`
	echo "========================================================================"
	echo "ID : Title                                                    Total: "$total
	echo "------------------------------------------------------------------------"
	cat $ROOT_FILE | sort
	echo "========================================================================"
}

#######################################
# Reset all todos from the list
#
# Globals:
# 	ROOT_FILE
# Arguments:
# 	None
# Returns:
# 	None
#
#######################################
reset_todos () {
	cp /dev/null $ROOT_FILE
	echo "Delete All Todos"
}

#######################################
# Search a todo from list
#
# Globals:
# 	ROOT_FILE
# Arguments:
# 	None
# Returns:
# 	None
#
#######################################
search_todo () {
	if [ -z $@ ]
		then
			read -p "Type any number or text for search: " search_original
			search_todo $search_original
		else
		result=`grep "$@" $ROOT_FILE`
		search_total=`grep "$@" $ROOT_FILE | wc -l`
	    [ -z $search_total ] && search_total="0" || search_total=$search_total

		echo "========================================================================"
		echo "ID : Title                                                    Total: "$search_total
		echo "------------------------------------------------------------------------"
		echo "${result}"
		echo "========================================================================"
	fi
}

#######################################
# Create a dir and files for storing
#
# Globals:
# 	ROOT_DIR
# 	ROOT_FILE
# Arguments:
# 	None
# Returns:
# 	None
#
#######################################
initialize () {

	# Create dir if it does not exist yet
	if [ ! -d $ROOT_DIR ]
		then
			mkdir $ROOT_DIR
	fi

	# Create a file if it does not exist yet
	if [ ! -f $ROOT_FILE ]
		then
			touch $ROOT_FILE
	fi

}

#############################################################################
# Base
#############################################################################

# initialize
initialize

# execute commands depending on options
case $1 in
	# add
	"-a"|"--add"|"add")
		add_todo ${*:2}
		;;
	# delete
	"-d"|"--delete"|"delete")
		delete_todo
		;;
	# show help
	"-h"|"--help"|"help")
		show_help
		;;
	# list todos
	"-l"|"--list"|"list")
		list_todos
		;;
	# reset all todos
	"-r"|"--reset"|"reset")
		reset_todos
		;;
	# search a todo
	"-s"|"--search"|"search")
		search_todo ${*:2}
		;;
	# update todo
	"-u"|"--update"|"update")
		update
		;;
	# default
	*)
		echo "run 'todo -h' for help"
		;;
esac
