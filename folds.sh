#!/bin/sh

ANSI_CLEAR="\033[0K"
travis_fold() {
  local action=$1
  local name=$2
  echo -en "travis_fold:${action}:${name}\r${ANSI_CLEAR}"
}

travis_fold open test1
echo "some output"
travis_fold open test2
echo "some output"
travis_fold close test2
echo "some output"
travis_fold close test1

echo "some output"

travis_fold open test3
travis_fold open test4
echo "some output"
travis_fold close test4
travis_fold close test3

echo "some output"

travis_fold open test5
echo "some output"
travis_fold open test6
travis_fold close test6
echo "some output"
travis_fold close test5
