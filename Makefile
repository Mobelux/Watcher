build:
	swift build -c release

install: build
	install .build/release/watcher /usr/local/bin/watcher

clean:
	rm -rf .build

.PHONY: build install clean
