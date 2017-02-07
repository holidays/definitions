# Holidays Definitions [![Build Status](https://travis-ci.org/holidays/definitions.svg?branch=master)](https://travis-ci.org/holidays/definitions)

This repository contains the 'raw' definitions for the various holidays projects. It should be added a submodule to
any project that wants to use them.

Currently it is only used by the [existing Holidays gem](https://github.com/holidays/holidays), which takes these
definitions and generates ruby classes for use in that gem. In the future it will be used by other languages in
a similar manner.

*Please note* that this is *not* a gem. The validation process is written in ruby simply for convenience. The real
stars of this show are the YAML files.

### Syntax

The definition syntax is a custom format developed over the life of this project. Please see
[our syntax doc](SYNTAX.md) for more information on how to format definitions.

### How to contribute

See our [contribution guidelines](CONTRIBUTING.md) for information on how to help out!

### Credits

Thank you to all of these [wonderful contributors!](https://github.com/holidays/definitions/contributors)
