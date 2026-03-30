# Maintainers guide

This document outlines the process of releasing an update of the definitions in this repository. Please note
that this document does NOT try to explain how to create packages for various languages. It is *just*
for creating version snapshots of definition files.

To be as clear as possible: this repository is *just* for definition updates. We 'release' updates as tags in Github
but do not push any code updates. Downstream projects (like ruby) will consume this and make their own appropriate releases.
The 'releases' in this project are mainly for organizational purposes.

### Who this document is for

This document is for maintainers that have merge access to this repository. Generally these people will also have access to any
language-specific libraries and so this will be a part of the entire release process. Usually other libraries (like the ruby library)
will reference this document as part of its own release process.

Please note that a core contributor must provide the relevant Github access so that you can perform merges. If you have any issues
please contact the [core members](https://github.com/orgs/holidays/teams/core/members) for assistance.

### Setup

This guide assumes that you have forked the repository in Github. If you require assistance in this please contact the core members listed above.

### Merging new definition changes

When new PRs are submitted you can navigate the following steps:

* Make sure that all CI builds are green. If there are errors you will need to investigate further (contact a core member for assistance).
* If the builds are green and the changes look reasonable to you then go ahead and merge!

### Releasing a new version

Releases are created automatically by CI when a PR is merged to `master`, provided the following conditions are met:

* `VERSION.txt` contains a version string higher than the most recent GitHub release tag
* `CHANGELOG.md` has a matching `## X.Y.Z` section for the version in `VERSION.txt`

If either condition is not met, the pipeline will fail and the release will not be created.

To prepare a release:

1. Update `VERSION.txt` with the new version number, following [semver rules](https://semver.org/):
   * **PATCH** bump for fixes and minor updates to existing definitions
   * **MINOR** bump for new regions or significant additions
   * **MAJOR** bump for breaking changes (e.g. dropping support for old downstream runtime versions)
2. Add a matching `## X.Y.Z` section to the top of [CHANGELOG.md](https://github.com/holidays/definitions/blob/master/CHANGELOG.md) with a summary of the changes included in this release. Use past entries as a guide.
3. Open a PR with both files updated. Once the PR is merged to `master`, CI will automatically create the GitHub release and tag using the CHANGELOG entry as the release description.

You do not need to manually create tags or releases in GitHub.
