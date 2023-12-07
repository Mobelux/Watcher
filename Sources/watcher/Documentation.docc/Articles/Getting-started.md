# Getting started

Install Watcher.

## Overview

Watcher supports multiple installation methods.

### Makefile

You can use the `Makefile` to build and install:

```
make install
```

### Manual

Clone this repo and build the executable:

```
swift build -c release watcher
```

Copy the resulting binary at `.build/release/watcher` to a location where it can be executed like `/usr/local/bin`.
