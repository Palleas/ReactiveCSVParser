PROJECT=ReactiveCSVParser.xcodeproj
SCHEME=ReactiveCSVParser

test:
	xcodebuild test -project $(PROJECT) -scheme $(SCHEME)