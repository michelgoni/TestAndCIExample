xcodebuild -project 'Dragons.xcodeproj' -scheme 'Dragons' -destination 'platform=iOS Simulator,name=iPhone 8' test
xcodebuild -project 'Dragons.xcodeproj' -scheme 'Dragons' -destination generic/platform=iOS -configuration Release build CODE_SIGNING_ALLOWED=NO
