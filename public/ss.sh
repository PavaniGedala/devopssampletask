#!/bin/bash
#
# Copyright 2016 IBM Corp. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the “License”);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#  https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an “AS IS” BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# load configuration variables
source local.env

function usage() {
  echo "Usage: $0 [--install,--uninstall,--update,--env]"
}

function install() {
  echo "creating action in openwhisk"
  wsk action create devopstask123 hello.js
  
    echo "creating  triggerin openwhisk"
  wsk trigger create sampletrigger
}

function uninstall() {
  echo "Removing actions..."
  wsk action create devopstask123
  wsk action delete vision/extractor

  echo "Removing rule..."
  wsk rule disable vision-rule
  wsk rule delete vision-rule

  echo "Removing trigger..."
  wsk trigger delete sampletrigger

  echo "Done"
  wsk list
}



function disable() {
  wsk rule disable vision-rule
}

function enable() {
  wsk rule enable vision-rule
}


case "$1" in
"--install" )
install
;;
"--uninstall" )
uninstall
;;
"--update" )
update
;;
"--env" )
showenv
;;
"--disable" )
disable
;;
"--enable" )
enable
;;
"--recycle" )
uninstall
install
;;
* )
usage
;;
esac
