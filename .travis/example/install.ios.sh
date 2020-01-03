#!/bin/bash -e

$(dirname "$0")/install.sh

cd Example

export CODE_SIGNING_REQUIRED=NO
HOMEBREW_NO_INSTALL_CLEANUP=1 HOMEBREW_NO_AUTO_UPDATE=1 brew tap wix/brew
HOMEBREW_NO_INSTALL_CLEANUP=1 HOMEBREW_NO_AUTO_UPDATE=1 brew install applesimutils
sudo ulimit -n 10000
sudo launchctl limit maxfiles 2048 unlimited

yarn
cd ios && pod install && cd ..
xcodebuild -workspace ./ios/ReanimatedExample.xcworkspace -scheme ReanimatedExample -configuration Debug -sdk iphonesimulator -derivedDataPath ./ios/build -UseModernBuildSystem=NO
