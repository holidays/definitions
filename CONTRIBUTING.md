# How to contribute

There are multiple ways to help! In this repository we have all of the definitions that are used in holiday calcuations. We rely on users around the world to help keep our definitions accurate and up to date.

## Code of Conduct

Please read our [Code of Conduct](CODE_OF_CONDUCT.md) before contributing. Everyone interacting with this project (or associated projects) is expected to abide by its terms.

## For definition updates

Our definitions are written in YAML. You can find a complete guide to our format in the [README](README.md). We take the YAML definitions and generate final definition files in the various projects
that are loaded at runtime for fast calculations.

Here are the steps to take once you have a good idea on what you want to change:

* Fork this repository
* Edit desired definition YAML file(s). If you are adding a new region be sure to update `index.yaml` as well
* Run `make validate` to ensure that all updates match our definition format
* Open a PR with your changes

Including documentation with your updates is very much appreciated. A simple Wikipedia entry or government link in the comments alongside your changes would be perfect.

Lastly, note that there are many 'meta' regions. For example, there are regions for Europe, Scandinavia, and North America. If your new region(s) falls into these areas consider adding them. You can find these 'meta' regions in `definitions/index.yaml`.

Don't worry about versioning, we'll handle it on our end.

*Tests are required for new definitions*.
