#!/bin/bash

setup_git() {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
}

commit_website_files() {
  git checkout -b travis
  git add . release/*
  git commit --message "Travis build: $PACKAGE_VERSION"
}

upload_files() {
  git remote add origin-upload https://${nctrb}@github.com/nerdCopter/travisBuilds.git > /dev/null 2>&1
  git push --quiet --set-upstream origin-upload travis
  git remote add origin-upload https://${PAT}@github.com/nerdCopter/travisBuilds.git > /dev/null 2>&1
  git push --quiet --set-upstream origin-upload travis
}

setup_git

ls -lhrt release/*
echo "commit"
commit_website_files

echo "upload"
upload_files
