#!/bin/bash

ANSI_CLEAR="\033[0K"
travis_fold() {
  local action=$1
  local name=$2
  echo -en "travis_fold:${action}:${name}\r${ANSI_CLEAR}"
}

travis_fold start test1
echo "some output"
echo "more output"
travis_fold start test2
echo "some output"
echo "more output"
travis_fold end test2
echo "more output"
echo "some output"
travis_fold end test1

echo "some output"
echo "more output"

travis_fold start test3
travis_fold start test4
echo "some output"
echo "more output"
travis_fold end test4
travis_fold end test3

echo "some output"

travis_fold start test5
echo "some output"
echo "more output"
travis_fold start test6
travis_fold end test6
echo "some output"
echo "more output"
travis_fold end test5
