#!/bin/sh

pod spec lint SYAdSDK.podspec --allow-warnings --verbose |tee log.txt
