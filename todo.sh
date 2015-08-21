#
# ████████╗ ██████╗ ██████╗  ██████╗ 
# ╚══██╔══╝██╔═══██╗██╔══██╗██╔═══██╗
#    ██║   ██║   ██║██║  ██║██║   ██║
#    ██║   ██║   ██║██║  ██║██║   ██║
#    ██║   ╚██████╔╝██████╔╝╚██████╔╝
#    ╚═╝    ╚═════╝ ╚═════╝  ╚═════╝ 
#                                   
#!/bin/sh
# 
# todo.sh
# - list all todos
# - add a todo
# - delete a todo
# - reset all todos
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
# update
# 
update () {
	if [ ! -d /usr/local/bin/ ]
		then
			mkdir /usr/local/bin/
	fi

	if [ -f /usr/local/bin/todo ]
		then
			rm /usr/local/bin/todo
	fi

	curl https://raw.githubusercontent.com/KENJU/shellscript_todo/master/todo.sh > /usr/local/bin/todo;
	chmod u+x /usr/local/bin/todo;	
}


##
# show help
# 
show_help () {
		
	# cat <<- EOF | less
	echo "

████████╗ ██████╗ ██████╗  ██████╗ 
╚══██╔══╝██╔═══██╗██╔══██╗██╔═══██╗
   ██║   ██║   ██║██║  ██║██║   ██║
   ██║   ██║   ██║██║  ██║██║   ██║
   ██║   ╚██████╔╝██████╔╝╚██████╔╝
   ╚═╝    ╚═════╝ ╚═════╝  ╚═════╝ 


created by Kenju 
> GitHub  : https://github.com/KENJU
> Twitter : https://twitter.com/kenju_wagatsuma
		                                  
---------------------------Commands Manual---------------------------

COPYRIGHT
		Copyright (C) 2015 Kenju - All Rights Reserved
		https://github.com/KENJU/shellscript_todo

NAME
    	todo - adds, lists, and deletes todo list with bash

DESCRIPTION
		todo command is a program for adding, listing and deleting
		todo lists easily with bash.

OPTIONS
		-a or --add or add
			add a new todo.

		-d or --delete or delete
			delete an exsiting todo.

		-h or --help or help
			show a help page.

		-l or --list or list
			list all todos.

		-r or --reset or reset
			delete all todos.

		-s or --search or search
			search todo with a query.

		-u or --update or update
			update todo.

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

###################################################
# todos
###################################################

##
# add a new todo
# 
add_todo () {
	max_count=`tail -1 $root_file | cut -d':' -f 1`
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
			echo "$max_count : $var" >> $root_file
			echo "New Todo Added!"						
			echo "run 'todo -l' for listing all todos."		
	fi
}

##
# deletes todos with id
# 
delete_todo () {

	list_todos
	echo ""
	read -p "> Type todo id to delete : " id_to_delete

	max_count=`tail -1 $root_file | cut -d':' -f 1`
	echo $max_count
	if [ $id_to_delete -le $max_count ]
		then
			grep -v "^$id_to_delete " $root_file > $root_dir/tmp && mv $root_dir/tmp $root_file
			echo "Successfully deleted the todo."
		else
			echo "The ID's todo does not exists."
	fi
}

##
# list all todos
# 
list_todos () {
	total=`wc -l < $root_file`
	echo "========================================================================"
	echo "ID : Title                                                    Total: "$total
	echo "------------------------------------------------------------------------"
	cat $root_file | sort
	echo "========================================================================"
}

##
# reset all todos
# 
reset_todos () {
	cp /dev/null $root_file
	echo "Delete All Todos."
}

##
# search a todo
# 
search_todo () {
	if [ -z $@ ]
		then
			read -p "Type any number or text for search: " search_original
			search_todo $search_original
		else
		result=`grep "$@" $root_file`
		search_total=`grep "$@" $root_file | wc -l`
	    [ -z $search_total ] && search_total="0" || search_total=$search_total

		echo "========================================================================"
		echo "ID : Title                                                    Total: "$search_total
		echo "------------------------------------------------------------------------"
		echo "${result}"
		echo "========================================================================"
	fi
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
	*)
		echo "run 'todo -h' for help"
		;;
esac