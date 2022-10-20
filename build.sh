#!/bin/bash

export GO111MODULE="on"
go mod tidy

PROJECT="backup dabase for docker"
VERSION="v1.0.0"
BUILD=`date +%FT%T%z`

function build() {
    os=$1
    arch=$2
    alias_name=$3
    package="${alias_name}-${arch}"

    echo "build ${package} ..."
    mkdir -p "./releases/${package}"
    CGO_ENABLED=0 GOOS=${os} GOARCH=${arch} go build -o "./releases/mysql-back-${package}" -ldflags "-X main.Version=${VERSION} -X main.Build=${BUILD}" ./main.go
#    cp ./config.example.json "./releases/${package}/config.json"
#    chmod +x ./install
#    cp ./install "./releases/${package}/install"
#    cd ./releases/
#    zip -r "./${package}.zip" "./${package}"
#    echo "clean ${package}"
#    rm -rf "./${package}"
#    cd ../
}

# OS X Mac
build darwin amd64 macOS
build darwin arm64 macOs
# Linux
build linux amd64 linux
build linux 386 linux
build linux arm linux
