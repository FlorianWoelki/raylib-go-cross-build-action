#!/bin/bash

set -e

if [[ -z "$GITHUB_WORKSPACE" ]]; then
  echo "Set the GITHUB_WORKSPACE env variable."
  exit 1
fi

if [[ -z "$GITHUB_REPOSITORY" ]]; then
  echo "Set the GITHUB_REPOSITORY env variable."
  exit 1
fi

root_path="/go/src/github.com/$GITHUB_REPOSITORY"
release_path="$GITHUB_WORKSPACE/.release"
repo_name="$(echo $GITHUB_REPOSITORY | cut -d '/' -f2)"
targets=("windows/amd64" "windows/386")
ccs=("x86_64-w64-mingw32-gcc" "i686-w64-mingw32-gcc")

echo "----> Setting up Go repository"
mkdir -p $release_path
mkdir -p $root_path
cp -a $GITHUB_WORKSPACE/* $root_path/
cd $root_path

for ((i = 0; i < ${#targets[@]}; ++i)); do
  target=${targets[$i]}
  os="$(echo $target | cut -d '/' -f1)"
  arch="$(echo $target | cut -d '/' -f2)"
  cc=${ccs[$i]}
  output="${release_path}/${repo_name}_${os}_${arch}"

  echo "----> Building project for: $os/$arch ($output, $cc)"
  GOOS=$os GOARCH=$arch CC=$cc CGO_ENABLED=1 go build -o $output
  zip -j $output.zip $output > /dev/null
done

echo "----> Build is complete. List of files at $release_path:"
cd $release_path
ls -al
