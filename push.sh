#!/bin/sh
# 
# add.sh
#
# Copyright (C) 2015 Kenju - All Rights Reserved
# https://github.com/KENJU/git_shellscript 

# add
git add -A

# commit
read -p "Commit message: " commitMessage
git commit -m "$commitMessage"

# add tag
read -p "Do you want to add tag? (y/n)" answer

case $answer in
  y)
    # show all tags
    git tag
    # add a new tag
    read -p "Tag Version: " tagVersion
    read -p "Tagging Message: " taggingMessage
    git tag -a $tagVersion -m "$taggingMessage"
    git push --tags
    ;;
  n)
    ;;
  *)
    ;;
esac

# push
git push
