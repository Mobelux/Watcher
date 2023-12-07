# Configuring Watcher

Create a configuration file to control the behavior of Watcher.

## Overview

Watcher requires a configuration file that controls which directories are watched and the commands that are executed when they change.

### Configure watched directories and commands

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
