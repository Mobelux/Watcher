build:
	swift build -c release

install: build
	install .build/release/directory-watcher /usr/local/bin/directory-watcher

clean:
	rm -rf .build

.PHONY: build install clean
