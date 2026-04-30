# Holidays Definitions [![Build Status](https://github.com/holidays/definitions/actions/workflows/ruby.yml/badge.svg?branch=master)](https://github.com/holidays/definitions/actions/workflows/ruby.yml)

This repository contains the 'raw' definitions for the various holidays projects. It should be added a submodule to
any project that wants to use them.

Currently it is only used by the [existing Holidays gem](https://github.com/holidays/holidays), which takes these
definitions and generates ruby classes for use in that gem. In the future it will be used by other languages in
a similar manner.

By default the definitions in this repository represent **statutory holidays** (formally government-defined observances). Holidays that are culturally recognized but not enshrined in law (such as Valentine's Day) are marked `type: informal` and are only returned when the consumer explicitly requests them. See the [Syntax Guide](doc/SYNTAX.md#formalinformal) for details.

**Please note** that this is _not_ a gem. The validation process is written in ruby simply for convenience. The real
stars of this show are the YAML files.

### Documentation

 1. [Syntax Guide](doc/SYNTAX.md)
 2. [Contribution Guidelines](doc/CONTRIBUTING.md)
 3. [Maintainer Guidelines](doc/MAINTAINERS.md)
 4. [Architecture Decision Records](doc/architecture/README.md)

### Credits

Thank you to all of these [wonderful contributors!](https://github.com/holidays/definitions/contributors)
