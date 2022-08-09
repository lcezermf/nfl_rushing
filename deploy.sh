#!/bin/sh
echo "start deploy..."
git remote add gigalixir https://git.gigalixir.com/nflrushing.git/
BRANCH=$(if ["$TRAVIS_PULL_REQUEST == "false" ]; then echo $TRAVIS_BRANCH; else echo $TRAVIS_PULL_REQUEST_BRANCH; fi)
echo "TRAVIS_BRANCH=$TRAVIS_BRANCH, PR=$PR"
echo "---"
echo "BRANCh=$BRANCH"
if [ "$BRANCH" == "master ]; then
  echo "push head"
  git push gigalixir HEAD:master
  echo "deploy done"
fi
echo "bye"