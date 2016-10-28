#!/bin/bash
set -e # Exit with nonzero exit code if anything fails
set -x

SOURCE_BRANCH="master"
TARGET_BRANCH="gh-pages"
COMMIT_AUTHOR_EMAIL=`git show --no-patch --format="%aN <%aE>"`

function doCompile {
  echo "test" > out/index.html
}

# Pull requests and commits to other branches shouldn't try to deploy, just build to verify
if [ "$TRAVIS_PULL_REQUEST" != "false" -o "$TRAVIS_BRANCH" != "$SOURCE_BRANCH" ]; then
  echo "Skipping deploy; just doing a build."
  doCompile
  exit 0
fi

# Save some useful information
REPO=`git config remote.origin.url`
SSH_REPO=${REPO/https:\/\/github.com\//git@github.com:}
SHA=`git rev-parse --verify HEAD`

#eval `ssh-agent`
touch ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa
echo -e "$DEPLOY_KEY" > ~/.ssh/id_rsa
ssh -vvv github.com

# Clone the existing gh-pages for this repo into out/
# Create a new empty branch if gh-pages doesn't exist yet (should only happen on first deply)
git clone $REPO out
cd out
git checkout $TARGET_BRANCH || git checkout --orphan $TARGET_BRANCH
cd ..

# Clean out existing contents
rm -rf out/**/* out/* out/.travis.yml || exit 0

# Run our compile script
doCompile

# Now let's go have some fun with the cloned repo
cd out
git config user.name "Travis CI"
git config user.email "$COMMIT_AUTHOR_EMAIL"

# If there are no changes to the compiled out (e.g. this is a README update) then just bail.
if [ -z "`git diff --exit-code`" ]; then
  echo "No changes to the output on this push; exiting."
  exit 0
fi

git add --all .
git commit -m "Deploy to GitHub Pages: ${SHA}"

ssh-agent -k
