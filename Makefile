.PHONY: build
build:
	@xcodebuild -alltargets

.PHONY: server
serve:
	@./build/Release/Server

MESSAGE?=test
.PHONY: client
client:
	@./build/Release/Client $(MESSAGE)
