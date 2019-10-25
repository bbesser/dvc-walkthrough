#!/bin/bash

SRC_FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# create clean working folder
cd /tmp
rm -rf dummy_repo
mkdir dummy_repo
cd dummy_repo

# configure git repository
git init
git config user.name 'alice'
git config user.email 'alice@dvc.livedemo'
git remote add origin git@github.com:bbesser/dvc-livedemo.git

# add code
mkdir code
cp $SRC_FOLDER/../code/load.py code
cp $SRC_FOLDER/../code/prepare_train.py code
cp $SRC_FOLDER/../code/train.py code
cp $SRC_FOLDER/../code/evaluate.py code
git add code
git commit -m 'add code'

cp $SRC_FOLDER/../run_pipeline.sh .
git add run_pipeline.sh
git commit -m 'add pipeline script'

echo "
Unsure how to __version the pipeline config__ and where to __store artifacts__.

I'm afraid this will turn out to be a big mess ...

Actually, I think about abandoning the entire thing ... 🙈 🗑

– Alice
" >> README.md
git add README.md
git commit -m 'add cry for help'

# overwrite remote with new code and remove all tags
git push -f -u origin master
git fetch --tags
tags="$(git tag -l)"
if [ -n "$tags" ]
then
  git push origin --delete $tags
  git tag -d $tags
fi
