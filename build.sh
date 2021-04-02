#!/bin/bash

BUILD_DIR=$(pwd)
export GOPATH=$BUILD_DIR

#
# Clean my build
#
if [[ -f gocd-golang-agent ]]; then
  echo "Remove binary : gocd-golang-agent"
  rm -rf gocd-golang-agent
fi

#
# Pull dependencies
#
echo "Get dependencies"
go get golang.org/x/net/websocket
go get github.com/satori/go.uuid
go get github.com/xli/assert
go get github.com/bmatcuk/doublestar
go get github.com/jstemmer/go-junit-report

#
# Create my source directory
#
mkdir -p src/github.com/gocd-contrib/gocd-golang-agent/
if ! [[ -L $BUILD_DIR/src/github.com/gocd-contrib/gocd-golang-agent/agent ]]; then
  ln -s $BUILD_DIR/agent $BUILD_DIR/src/github.com/gocd-contrib/gocd-golang-agent/agent
fi
if ! [[ -L $BUILD_DIR/src/github.com/gocd-contrib/gocd-golang-agent/junit ]]; then
  ln -s $BUILD_DIR/junit $BUILD_DIR/src/github.com/gocd-contrib/gocd-golang-agent/junit
fi
if ! [[ -L $BUILD_DIR/src/github.com/gocd-contrib/gocd-golang-agent/protocol ]]; then
  ln -s $BUILD_DIR/protocol $BUILD_DIR/src/github.com/gocd-contrib/gocd-golang-agent/protocol
fi
if ! [[ -L $BUILD_DIR/src/github.com/gocd-contrib/gocd-golang-agent/stream ]]; then
  ln -s $BUILD_DIR/stream $BUILD_DIR/src/github.com/gocd-contrib/gocd-golang-agent/stream
fi

#
# Go Build !!
#
echo "Starting building..."
go build .