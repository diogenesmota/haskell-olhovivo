#!/bin/bash
# Heavily inspired by http://git.io/bY1_jw

if [ "$TRAVIS_REPO_SLUG" == "yamadapc/haskell-olhovivo" ] && [ "$TRAVIS_PULL_REQUEST" == "false" ] && [ "$TRAVIS_BRANCH" == "master" ]; then
  echo -e "Generating documentation...\n"
  cabal haddock
  cp -Rf dist/doc/html/olhovivo/ $HOME/olhovivo-doc/
  echo -e "Publishing documentation...\n"
  cd $HOME
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "travis-ci"
  git clone --quiet --branch=gh-pages https://${GH_TOKEN}@github.com/yamadapc/haskell-olhovivo
  cd haskell-olhovivo
  cp -Rf $HOME/olhovivo-doc/* .
  git add -f .
  git commit -m "Latest documentation auto-deployed on $TRAVIS_BUILD_NUMBER"
  git push -fq origin gh-pages

  echo -e "Published documentation! Hack away!\n"
fi
