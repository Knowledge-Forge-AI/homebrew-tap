class AgenticPraxisGrimoire < Formula
  desc "Provider-neutral coding-agent toolkit and canonical skill corpus"
  homepage "https://github.com/Knowledge-Forge-AI/agentic-praxis-grimoire"
  version "0.12.0"
  license "AGPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Knowledge-Forge-AI/agentic-praxis-grimoire/releases/download/v0.12.0/knowledge-forge-ai-apgr-darwin-arm64-0.12.0.tgz"
      sha256 "7f9a2ea9c1cdde01326f004afb48048a5eaa28c4b699739683cb5f2e0c8fb125"
    end
    if Hardware::CPU.intel?
      odie "Intel macOS (darwin/amd64) is not distributed or supported by Agentic Praxis Grimoire."
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/Knowledge-Forge-AI/agentic-praxis-grimoire/releases/download/v0.12.0/knowledge-forge-ai-apgr-linux-x64-0.12.0.tgz"
      sha256 "48a71db07484ab4ad57d9c9930c88b2fda823ffaa5a257e81a7f1c6f883a5332"
    end
    if Hardware::CPU.arm?
      url "https://github.com/Knowledge-Forge-AI/agentic-praxis-grimoire/releases/download/v0.12.0/knowledge-forge-ai-apgr-linux-arm64-0.12.0.tgz"
      sha256 "ee97302dc9611d47e4e4916d724a6e3a94b2f19d0b0157c8b98bdafa37ca002d"
    end
  end

  def install
    bin.install "bin/apgr"
    pkgshare.install "bin/apgr.binary-manifest.json"
    ["LICENSE", "NOTICE", "COMMERCIAL-LICENSE.md"].each do |file|
      pkgshare.install file
    end
  end

  def caveats
    <<~EOS
      macOS Apple Silicon (darwin/arm64) native binary execution is qualified.
      Homebrew formula load, installation, and coexistence testing are pending
      initial tap release in Knowledge-Forge-AI/homebrew-tap.
      Linux (x86_64 and arm64) native binaries are runtime-supported, with
      developer/CI qualification recorded as hosted-pending.
      Intel macOS (darwin/amd64) is not distributed or supported.
    EOS
  end

  test do
    assert_match "apgr", shell_output("#{bin}/apgr --help")
    assert_match version.to_s, shell_output("#{bin}/apgr --version")
    assert_match "skills", shell_output("#{bin}/apgr --help")
    assert_match "build-info", shell_output("#{bin}/apgr build-info")
    assert_predicate pkgshare/"apgr.binary-manifest.json", :exist?
    assert_predicate pkgshare/"LICENSE", :exist?
    assert_predicate pkgshare/"NOTICE", :exist?
    assert_predicate pkgshare/"COMMERCIAL-LICENSE.md", :exist?
  end
end
