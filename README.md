# Knowledge Forge AI Homebrew tap

The Homebrew tap for **all Knowledge Forge AI projects** as their formulas become
available. The current catalog includes Agentic Praxis Grimoire and the Theme
Forge engines and workbench. Hikari, RS9's admiral, represents this shared
distribution infrastructure.

**[Visit the tap website](https://brew.rs9.knowledge-forge.ai/)** ·
**[Knowledge Forge AI](https://www.knowledge-forge.ai/)** ·
**[Release Starport 9](https://rs9.knowledge-forge.ai/)**

## Install

```sh
brew tap Knowledge-Forge-AI/tap
brew install Knowledge-Forge-AI/tap/agentic-praxis-grimoire
```

Replace the final formula name with any entry in the catalog below. Fully
qualified installs also work without a separate tap command.

## Current formulas

This documentation reflects the committed formula catalog on 11 November 2026.
The linked formula defines its version, archive, hash and installation behavior.
Platform restrictions and completed qualification are distinguished below.

| Project | Version | Formula | Platform restrictions and qualification |
| --- | --- | --- | --- |
| Agentic Praxis Grimoire | 0.13.1 | [`agentic-praxis-grimoire`](Formula/agentic-praxis-grimoire.rb) | Declared: Apple Silicon macOS; Linux AMD64 / ARM64. Homebrew load, installation and coexistence qualification remain pending, as the formula caveat records. |
| Stellar Burst | 0.7.0 | [`theme-forge-stellar-burst`](Formula/theme-forge-stellar-burst.rb) | Qualified: Apple Silicon macOS; Linux AMD64 / ARM64. Formula requires Node, with no explicit platform restriction. |
| Stellar Loom | 0.5.0 | [`theme-forge-stellar-loom`](Formula/theme-forge-stellar-loom.rb) | Qualified: Apple Silicon macOS; Linux AMD64 / ARM64. Formula requires Node, with no explicit platform restriction. |
| Solar Sail | 0.3.0 | [`theme-forge-solar-sail`](Formula/theme-forge-solar-sail.rb) | Qualified: Apple Silicon macOS; Linux AMD64 / ARM64. Formula requires Node, with no explicit platform restriction. |
| Nebular Fusion | 0.8.0 | [`theme-forge-nebular-fusion`](Formula/theme-forge-nebular-fusion.rb) | Restricted to Apple Silicon macOS; app formula qualified on Apple Silicon. |

The three Theme Forge CLI formulas were [qualified on all three hosts](https://github.com/Knowledge-Forge-AI/homebrew-tap/actions/runs/42434991234); that campaign also qualified Nebular on Apple Silicon. It does not cover APGR.

```sh
brew install Knowledge-Forge-AI/tap/theme-forge-stellar-burst
brew install Knowledge-Forge-AI/tap/theme-forge-stellar-loom
brew install Knowledge-Forge-AI/tap/theme-forge-solar-sail
brew install Knowledge-Forge-AI/tap/theme-forge-nebular-fusion
```

The formulas expose `apgr`; `tfsb` and `tfsb-studio-service`; `tfsl` and
`tfsl-batch`; `tfss`; and the `tfnf` application launcher respectively. APGR's
native portable installation does not require runtime Python, Node or Go
compilers and does not include the developer test suite (`apgr test`).

Nebular's **Formula** installs the exact ad-hoc-signed Apple Silicon developer
application payload and exposes `tfnf`. Developer ID signing, notarization,
Gatekeeper qualification and a Homebrew Cask are not claimed. The Cask remains
withheld. Consult the application's release notes before installing.

## Other projects and routes

This tap's scope is organization-wide; the table is the complete current formula
catalog. New entries require their own formula and qualification. STTN and CTTN
are npm theme dependencies; use their project installation guides. RepoMap,
rebranding toward Common Lore Index (CLOE), DINAS and other organization projects
retain their own current distribution routes.

[Theme Forge Packages](https://tf.rs9.knowledge-forge.ai/) serves the signed APT,
DNF and pacman repositories, including both Linux architectures. Nix uses its
own channel references. Sharing RS9 infrastructure does not make these routes
interchangeable with a Homebrew formula.

## Website maintenance

The static Hikari page lives in `website/`. Its Pages workflow publishes only
the seven declared website files from main. It does not build or install formulas,
change product versions, sign packages or publish product releases. Theme Forge formula
qualification remains in the existing, separately triggered workflow. APGR is
not covered by that workflow; its Homebrew qualification remains pending.

## License and contributions

Original tap code, website software and documentation use **AGPL-3.0-or-later**;
see [LICENSE](LICENSE). Separate [commercial licenses](COMMERCIAL-LICENSE.md) are
available for proprietary terms. AGPL permits commercial use subject to its
terms. Upstream products retain their own licenses and notices. Earlier public
grants are not revoked. Hikari and brand artwork are excluded from the AGPL
grant; see [BRAND-ASSETS.md](BRAND-ASSETS.md) and [NOTICE](NOTICE).

Contributors retain copyright and grant the steward the sublicensing and
relicensing rights in [CLA.md](CLA.md). Read [CONTRIBUTING.md](CONTRIBUTING.md).
Each PR must explicitly acknowledge:

```text
I agree to the Knowledge Forge AI Homebrew Tap contribution terms in CLA.md.
```

A Signed-off-by line does not replace that acknowledgment.

Steward: Samuel Leighton Lair. Contact: sam.lair@knowledge-forge.ai.
