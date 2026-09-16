# Knowledge Forge AI Homebrew tap

Homebrew Formulae for the Stellar Burst and Stellar Loom command-line tools.

```sh
brew install Knowledge-Forge-AI/tap/theme-forge-stellar-burst
brew install Knowledge-Forge-AI/tap/theme-forge-stellar-loom
```

Stellar Burst 0.5.0 is SVG-only; PNG/raster distribution is not claimed. Stellar Loom 0.2.0 provides the qualified Theme v1/v2 compiler and tfsl/tfsl-batch interfaces. Both Formulae depend on node@22; qualification used Node 22.23.2.

Terminal Nova is an npm project dependency and has no Formula:

```sh
npm install @knowledge-forge-ai/starlight-theme-terminal-nova@0.2.0
```

Use the documented compatible Astro/Starlight consumer setup. The TypeScript 7.0.2 native compiler build-tool risk remains open; it is absent from the Nova npm/static runtime.

Nebular Fusion is available separately as an ad-hoc macOS arm64 developer artifact. Its Homebrew cask is WITHHELD / NO-GO. Developer ID, notarization and Gatekeeper qualification are not claimed.
## Agentic Praxis Grimoire

Homebrew formula for the provider-neutral coding-agent toolkit and canonical skill corpus (`apgr`).

```sh
brew install Knowledge-Forge-AI/tap/agentic-praxis-grimoire
```

Installs the native portable `apgr` executable for macOS Apple Silicon (`darwin/arm64`) and Linux (`linux/amd64`, `linux/arm64`). Native command installations do not require runtime Python, Node, or Go compilers, and exclude developer test suites (`apgr test`).

Coexists cleanly alongside existing pip, npm, and Nix installations without force-linking.
