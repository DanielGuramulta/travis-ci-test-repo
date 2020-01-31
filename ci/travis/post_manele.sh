#!/bin/bash

if [ "$TRAVIS_PULL_REQUEST" != "false" ] ; then

    message=($(curl -G https://www.googleapis.com/youtube/v3/search -d part="snippet" \
      -d q="manelevesele" -d key="${YOUTUBE_DATA_TOKEN}" \
      -d maxResults="50" -d type="video" | grep videoId | rev | cut -d: -f1 | rev | tr -d '"'))

    message=${message[RANDOM%${#message[@]}]}
    message="https://www.youtube.com/watch?v=${message}"

    curl -H "Authorization: token ${GITHUB_TOKEN}" -X POST \
                        -d "{\"body\": \"Travis build ran successfully, celebrate by listening to: ${message} \"}" \
                        "https://api.github.com/repos/${TRAVIS_REPO_SLUG}/issues/${TRAVIS_PULL_REQUEST}/comments" &>/dev/null
fi
