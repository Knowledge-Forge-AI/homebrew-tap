# Knowledge Forge AI Homebrew tap

Homebrew Formulae for Knowledge Forge AI command-line tools.

## Theme Forge CLI family

```sh
brew install Knowledge-Forge-AI/tap/theme-forge-stellar-burst
brew install Knowledge-Forge-AI/tap/theme-forge-stellar-loom
brew install Knowledge-Forge-AI/tap/theme-forge-solar-sail
brew install Knowledge-Forge-AI/tap/theme-forge-nebular-fusion
```

CLI coverage:

- **Theme Forge Stellar Burst 0.5.0** — `tfsb` plus the `tfsb-studio-service` helper.
- **Theme Forge Stellar Loom 0.3.0** — `tfsl` and `tfsl-batch`.
- **Theme Forge Solar Sail 0.1.0** — `tfss`.
- **Theme Forge Nebular Fusion 0.4.0** — `tfnf` on macOS Apple Silicon.

The Nebular **Formula** installs the exact ad-hoc-signed macOS Apple Silicon developer application
payload and exposes the `tfnf` launcher. This does not authorize a Cask: the Nebular Homebrew Cask
remains WITHHELD / NO-GO, and Developer ID signing, notarization and Gatekeeper qualification are
not claimed.

Terminal Nova is an npm project dependency rather than a CLI product and therefore has no Formula:

```sh
npm install @knowledge-forge-ai/starlight-theme-terminal-nova@0.3.0
```


## Agentic Praxis Grimoire

Homebrew formula for the provider-neutral coding-agent toolkit and canonical skill corpus (`apgr`).

```sh
brew install Knowledge-Forge-AI/tap/agentic-praxis-grimoire
```

Installs the native portable `apgr` executable for macOS Apple Silicon (`darwin/arm64`) and Linux (`linux/amd64`, `linux/arm64`). Native command installations do not require runtime Python, Node, or Go compilers, and exclude developer test suites (`apgr test`).

Coexists cleanly alongside existing pip, npm, and Nix installations without force-linking.
