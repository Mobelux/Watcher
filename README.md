# Watcher

Swift CLI tool to execute commands when watched directories are modified

## 🖥 Installation

### 📄 Makefile

You can use the [`Makefile`](Makefile) to build and install:

```
make install
```

### 🛠️ Manual

Clone this repo and build the executable:

```
swift build -c release watcher
```

Copy the resulting binary at `.build/release/watcher` to a location where it can be executed like `/usr/local/bin`

## 🎛️ Configuration

Watcher uses a `.watcher.yml` file at the root of the watched directory to define commands to execute when files matching a given glob -- and optionally, not matching an `exclude` glob -- are modified:

```yml
- pattern: "/Sources/**/*.swift"
  command: swift run
  exclude: "/**/ignore.swift"
  name: Regenerate site
- pattern: "/src/scss/**/*.scss"
  command: echo "compile Sass"
```

The optional `name` value is used for terminal output.

## ⚙️ Usage

```
USAGE: watcher [--config <config>] [--throttle <throttle>]

OPTIONS:
  -c, --config <config>   The path to a configuration file.
  -t, --throttle <throttle>
                          The minimum interval, in seconds, between command execution in response to file changes.
  -h, --help              Show help information.
```

## 🔄 Alternatives

- [watchman](https://github.com/facebook/watchman)
