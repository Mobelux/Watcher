# DirectoryWatcher

Swift CLI tool to execute commands when watched directories are modified

## Installation

### Makefile

You can use the [`Makefile`](Makefile) to build and install:

```
make install
```

### Manual

Clone this repo and build the executable:

```
swift build -c release directory-watcher
```

Copy the resulting binary at `.build/release/directory-watcher` to a location where it can be executed like `/usr/local/bin` 

## Configuration

DirectoryWatcher uses a `.watcher.yml` file at the root of the watched directory to define commands to execute when files matching a given glob are modified:

```yml
- pattern: "Sources/**.swift"
  command: swift run
  name: Regenerate site
- pattern: "src/scss/**.scss"
  command: echo "compile Sass"
```

The optional `name` value is used for terminal output.

## Usage

```
USAGE: directory-watcher

OPTIONS:
  -h, --help              Show help information.
```
