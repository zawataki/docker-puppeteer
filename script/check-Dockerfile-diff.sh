#!/bin/bash

set -eu

echo "Check differences of Dockerfile between official and this repo"
wget https://raw.githubusercontent.com/GoogleChrome/puppeteer/master/docs/troubleshooting.md

function getLineNum() {
  grep -nF "$1" troubleshooting.md | cut -d':' -f1;
}

lineNumAtSectionTitle=$(getLineNum '## Running Puppeteer in Docker')

lineNumFrom=$(
  for lineNum in $(getLineNum '```Dockerfile'); do
    if [ $lineNum -gt $lineNumAtSectionTitle ]; then
      echo $(($lineNum + 1))
      break
    fi
  done
)

lineNumTo=$(
  for lineNum in $(getLineNum '```'); do
    if [ $lineNum -gt $lineNumFrom ]; then
      echo $(($lineNum - 1))
      break
    fi
  done
)

diff <(sed -n ${lineNumFrom},${lineNumTo}p troubleshooting.md) "$(dirname "$0")/../Dockerfile"

rm troubleshooting.md
