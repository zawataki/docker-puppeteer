#!/bin/bash

set -eu

echo 'Trigger build of Docker Hub'
curl -X POST https://cloud.docker.com/api/build/v1/source/77579ec2-1de2-42f5-88a6-d2225ae85175/trigger/b55a9eea-69d4-4bec-9a21-f3fd446b2aa3/call/
