# Knowledge Forge AI Homebrew tap

Homebrew formulas for Knowledge Forge AI command-line tools and the Nebular Fusion desktop application.

## Theme Forge family

```sh
brew install Knowledge-Forge-AI/tap/theme-forge-stellar-burst
brew install Knowledge-Forge-AI/tap/theme-forge-stellar-loom
brew install Knowledge-Forge-AI/tap/theme-forge-solar-sail
brew install Knowledge-Forge-AI/tap/theme-forge-nebular-fusion
```

Current formulas:

- **Theme Forge Stellar Burst 0.7.0** — `tfsb` plus the `tfsb-studio-service` helper.
- **Theme Forge Stellar Loom 0.5.0** — `tfsl` and `tfsl-batch`.
- **Theme Forge Solar Sail 0.3.0** — `tfss`.
- **Theme Forge Nebular Fusion 0.7.1** — `tfnf` on macOS Apple Silicon.

The Nebular **Formula** installs the exact ad-hoc-signed macOS Apple Silicon developer application
payload and exposes the `tfnf` launcher. This does not authorize a Cask: the Nebular Homebrew Cask
remains WITHHELD / NO-GO, and Developer ID signing, notarization and Gatekeeper qualification are
not claimed.

The Terminal Nova themes are npm project dependencies and have no formulas:

```sh
npm install @knowledge-forge-ai/starlight-theme-terminal-nova@0.4.0
npm install @knowledge-forge-ai/shadcn-theme-terminal-nova@0.1.0
```

The current formula source passed [qualification on Apple Silicon, Linux AMD64 and Linux ARM64](https://github.com/Knowledge-Forge-AI/homebrew-tap/actions/runs/41185962986). Nebular's app formula is qualified on Apple Silicon; the three command-line products are qualified on all three hosts.


## Agentic Praxis Grimoire

Homebrew formula for the provider-neutral coding-agent toolkit and canonical skill corpus (`apgr`).

```sh
brew install Knowledge-Forge-AI/tap/agentic-praxis-grimoire
```

Installs the native portable `apgr` executable for macOS Apple Silicon (`darwin/arm64`) and Linux (`linux/amd64`, `linux/arm64`). Native command installations do not require runtime Python, Node, or Go compilers, and exclude developer test suites (`apgr test`).

Coexists cleanly alongside existing pip, npm, and Nix installations without force-linking.
