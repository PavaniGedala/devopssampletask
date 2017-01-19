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
 

  echo "Configuring OpenWhisk"
 wsk property set --apihost openwhisk.ng.bluemix.net --auth 6fee80b2-558a-4c03-b84d-82493af04646:Rq9c2NQcLsyENY6YUIlipVf2tLnRGr9cZAJnRSB7kwweLho4AZJfIm0beuxLVGGN --namespace "openwhisk3218_openwhisk"

  echo "creating action in openwhisk"
  wsk action create devopstask123 hello.js
  
}

function uninstall() {
  echo "Removing actions..."
  wsk action delete vision/analysis
  wsk action delete vision/extractor

  echo "Removing rule..."
  wsk rule disable vision-rule
  wsk rule delete vision-rule

  echo "Removing change listener..."
  wsk action delete vision-cloudant-changelistener

  echo "Removing trigger..."
  wsk trigger delete vision-cloudant-trigger

  echo "Removing packages..."
  wsk package delete vision-cloudant
  wsk package delete vision

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