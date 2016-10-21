#!/bin/sh
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
