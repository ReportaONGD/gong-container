#!/bin/bash

render() {
sedStr="
  s!%%GONG_VERSION%%!$version!g;
"

sed -r "$sedStr" $1
}

versions=(2.54 2.55)
for version in ${versions[*]}; do
  mkdir $version
  render Dockerfile.template > $version/Dockerfile
  cp docker-entrypoint.sh gong-env.conf init.rb $version/
done
