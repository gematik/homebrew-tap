# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

`gematik/homebrew-tap`: the Homebrew tap for gematik tools, with formulas for CLIs in
`Formula/` and casks for GUI apps in `Casks/`. Users run `brew tap gematik/tap`, then
`brew install gematik/tap/<name>`. The tap only carries Ruby definitions. Binaries and
source tarballs stay on the GitHub releases of the app's own repository, and each
definition points at those with a `url` and `sha256`.

## How formulas get here (read before editing one)

Formulas are **generated upstream and pushed here by the app's release recipe**. They are
not maintained by hand in this repo:

| Formula | Source of truth | Publisher |
|---|---|---|
| `ti` | `gematik/zero-lab` → `rust/ti-cli/Formula/ti.rb` (template with `@VERSION@`, `@URL_<target>@`, `@SHA256_<target>@`) | `just publish-brew <owner> <version>` in `zero-lab/rust` |
| `zeta` | `gematik/zeta-cli` → `Formula/zeta.rb` (`url`/`sha256` lines rewritten by sed) | `just publish-brew <owner>` in `zeta-cli` |

Each publisher shallow-clones `<owner>/homebrew-tap`, overwrites `Formula/<name>.rb`,
commits `<name> <version>`, and pushes straight to `main`. As a result:

- A hand edit to a published formula gets overwritten by the next release. Fix the
  template in the producer repo, and change it here only as a stop-gap that is also
  ported upstream.
- `sha256` always comes from the release asset (or its `SHA256SUMS`). Never compute it
  from a local build.
- Publish with owner `gematik`. `zero-lab/rust/Justfile` still defaults `TAP_OWNER` to
  `spilikin`, and `zeta-cli` takes the owner as an argument. Publishing to `spilikin`
  makes the two taps diverge.
- Keep the `<name> <version>` commit subject so publisher commits and manual commits
  read the same.

A new app follows the same pattern: the formula or cask template lives in the app's repo
next to its release recipe, and this repo only receives the rendered file.

## Commands

Brew can't install a loose `.rb` file. It has to come from a tap, so point the
`gematik/tap` tap at this checkout first:

```sh
brew tap gematik/tap "$PWD"           # or symlink $(brew --repository)/Library/Taps/gematik/homebrew-tap here
brew style gematik/tap                # rubocop rules for all formulas/casks
brew style Formula/ti.rb              # single file
brew audit --strict --online --formula gematik/tap/ti
brew audit --strict --online --cask gematik/tap/<cask>
brew install --verbose gematik/tap/ti && brew test gematik/tap/ti
brew uninstall ti && brew untap gematik/tap
```

`brew tap` clones from a path, so local edits stop being visible after tapping. The
symlink keeps the working tree live.

The two formulas are packaged differently:

- `ti` installs bare per-platform binaries (arm64 macOS, x86_64 Linux). It uses
  `bin.install` with a rename and a `chmod`, because release assets download without
  the executable bit. Homebrew only accepts `url`/`sha256` nested as `on_<os>` →
  `on_<arch>`; it rejects them directly under `on_macos` or a top-level `on_arm`. The
  unsupported architecture of each OS repeats that OS's binary only so the formula still
  loads there and `depends_on arch` refuses it; without a `url` the formula fails to load
  ("requires at least a URL"). There is no `version` line: `brew audit --strict` flags it
  as redundant with the URL.
- `zeta` installs a JVM distribution tarball into `libexec`, depends on `openjdk@21`, and
  wraps `bin/zeta` with `write_env_script`.

Each formula has a `test do` block that runs its `version` command.

History before this tap existed (`ti` 0.1.0–0.5.0, `zeta` 0.5.1–0.15.0) was imported
from `spilikin/homebrew-tap` with a merge commit. Some early `zeta` versions in that
history point at release assets on `spilikin/homebrew-tap`.

## gematik OSPO rules

This is a public gematik repository under **Apache-2.0**, so the gematik Open Source
Program Office boilerplate applies. The scaffold was copied from public gematik repos:
`LICENSE`, `SECURITY.md` and `CODE_OF_CONDUCT.md` byte for byte from
`gematik/lib-bbriccs` (Apache variant), and the README disclaimer and contact sections
from `gematik/zero-lab` (newer wording). When updating this boilerplate, copy it again
from those repos. Never paraphrase it or write it from memory:

- `README.md` must end with these sections, in this order: **License** (`Copyright <years>
  gematik GmbH`, license name, link to `LICENSE`), **Additional Notes and Disclaimer from
  gematik GmbH** (the four numbered points, including point 4 on AI-assisted content),
  and **Contact** (the license-compliance paragraph plus a GitHub Issues link for this repo).
  Above those come About, Getting Started/Installation (`brew tap gematik/tap`), Usage and
  Contributing.
- `LICENSE` holds the full license text. Each formula's `license` stanza names **the app's**
  license (`ti` is `EUPL-1.2`). That stanza is independent of this repo's license.
- `SECURITY.md` is the standard gematik text, which points responsible disclosure to
  https://www.gematik.de/datensicherheit#c1227.
- `CONTRIBUTING.md` follows the gematik contributing-guide structure. Contributions are
  licensed under the repo license.
- Source files carry the license header used by sibling gematik repos, beginning
  `Copyright (Change Date see Readme), gematik GmbH`. Generated formulas get their header
  from the upstream template, so add it there. Paths exempt from the header check go in
  `.licenseignore`.
- Changes to the license, headers or copyright years go in a commit of their own.
- Commits: imperative subject without a type prefix, and no tool or assistant
  attribution in commits, PRs or files.
