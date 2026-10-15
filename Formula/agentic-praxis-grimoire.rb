class AgenticPraxisGrimoire < Formula
  desc "Provider-neutral coding-agent toolkit and canonical skill corpus"
  homepage "https://github.com/Knowledge-Forge-AI/agentic-praxis-grimoire"
  version "0.13.0"
  license "AGPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Knowledge-Forge-AI/agentic-praxis-grimoire/releases/download/v0.13.0/knowledge-forge-ai-apgr-darwin-arm64-0.13.0.tgz"
      sha256 "4dde4d0212bc73e32fcbbecb347844b53430f0a4c751db292a654aa46dfe21d6"
    end
    if Hardware::CPU.intel?
      odie "Intel macOS (darwin/amd64) is not distributed or supported by Agentic Praxis Grimoire."
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/Knowledge-Forge-AI/agentic-praxis-grimoire/releases/download/v0.13.0/knowledge-forge-ai-apgr-linux-x64-0.13.0.tgz"
      sha256 "58cb285e23bdeb4c2db70dee2f1e1a49fa203cd4fb8216ad48d767e9ecbf1059"
    end
    if Hardware::CPU.arm?
      url "https://github.com/Knowledge-Forge-AI/agentic-praxis-grimoire/releases/download/v0.13.0/knowledge-forge-ai-apgr-linux-arm64-0.13.0.tgz"
      sha256 "951eb2c1e04bc0544d194d159fc92124dcc65f30ec8f90d8988ef41682f54753"
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
