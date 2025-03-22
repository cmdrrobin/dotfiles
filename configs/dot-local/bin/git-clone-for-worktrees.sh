#!/usr/bin/env bash

set -e

# Example
# git cw git@github.com:name/repo.git
# => Clones to a ./repo directory
#
# git cw git@github.com:name/repo.git foo
# => Clones to a ./foo directory

url=$1
basename=${url##*/}
name=${2:-${basename%.*}}

mkdir "$name" || exit 1
cd "$name"

# Moves all the administrative git file (a.k.a. $GIT_DIR) under .git directory
git clone --bare "$url" .git

# Explicity sets the remote origin fetch so we can fetch remote branches
git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"

# Get all branches from origin
git fetch origin
