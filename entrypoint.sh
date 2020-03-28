#!/bin/bash

set -e

SRC_FOLDER=$1
DEST_REPO=$2

BASE=$(pwd)

git config --global user.email "bricktownseo@gmail.com"
git config --global user.name "bricktownseo" #"$GITHUB_USERNAME"

# echo "Cloning folders in $SRC_FOLDER and pushing to $DEST_REPO"

echo "Creating clone directory"
cd $BASE

mkdir "CLONE_REPO"
cd "CLONE_REPO"

echo "Cloning destination repo $DEST_REPO"
echo "Clone URL https://$API_TOKEN_GITHUB@github.com/$DEST_REPO.git"
git clone https://$API_TOKEN_GITHUB@github.com/$DEST_REPO.git

echo "Copying $SRC_FOLDER"
cp -r $BASE/$SRC_FOLDER .

if [ -n "$(git status --porcelain)" ]; then
  echo  "  Committing $DEST_REPO"
  git add .
  git commit --message "Updated $DEST_REPO"
  git push origin master
  echo  "  Completed $DEST_REPO update."
else
  echo "  No changes, skipping."
fi
