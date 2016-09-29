#!/bin/bash
set -ev

mvn clean install -DskipTests=true -Dmaven.javadoc.skip=true -B
mvn -q -pl ':katharsis-core' test jacoco:report coveralls:report
if [ "${TRAVIS_PULL_REQUEST}" != "true" ] && [ "$(git status | head -1)" != "HEAD detached at FETCH_HEAD" ] ; then

    if [[ $TRAVIS_BRANCH == 'master' ]]; then
      # deploy to staging repository
      echo "TODO: ADD DEPLOYMENT TO STAGING REPOSITORY"
    elif [[ $TRAVIS_BRANCH == 'develop' ]]; then
      mvn clean deploy -DskipTests=true --settings settings.xml
    else
      mvn clean install -DskipTests=true --settings settings.xml
    fi
fi