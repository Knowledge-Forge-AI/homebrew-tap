# Static project website

This directory contains an independent presentation site with local HTML, CSS,
JavaScript and the optimized established Hikari mascot asset. It has no application or
build dependencies and requests no external fonts, analytics or model service.
Only the declared seven static files are uploaded by the main-only Pages workflow;
this directory's maintenance and brand documents stay in GitHub source.

The workflow preserves the existing github-pages environment and uses no
signing keys. It does not execute the project, install a package, alter a
formula, create a tag or publish a product release. Existing project CI and
release workflows remain unchanged. Revert the website commit and redeploy to
roll back presentation changes. Product installation links remain authoritative
in their own source and distribution documentation.
