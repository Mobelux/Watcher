install:
	swift build -c release
	install .build/release/directory-watcher /usr/local/bin/directory-watcher
