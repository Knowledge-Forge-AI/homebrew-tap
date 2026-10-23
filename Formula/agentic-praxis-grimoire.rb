class AgenticPraxisGrimoire < Formula
  desc "Provider-neutral coding-agent toolkit and canonical skill corpus"
  homepage "https://github.com/Knowledge-Forge-AI/agentic-praxis-grimoire"
  version "0.13.1"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on macos: :monterey
    if Hardware::CPU.arm?
      url "https://github.com/Knowledge-Forge-AI/agentic-praxis-grimoire/releases/download/v0.13.1/knowledge-forge-ai-apgr-darwin-arm64-0.13.1.tgz"
      sha256 "03d346b41b7e9c1378d02ebaadba45f11f0c1acd7ffd599f6cc0ea97cdc6545d"
    end
    if Hardware::CPU.intel?
      odie "Intel macOS (darwin/amd64) is not distributed or supported by Agentic Praxis Grimoire."
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/Knowledge-Forge-AI/agentic-praxis-grimoire/releases/download/v0.13.1/knowledge-forge-ai-apgr-linux-x64-0.13.1.tgz"
      sha256 "ae177d6ae4ec2d4512465153d6f647a6dd035109b62a34b54acd57c05bee566b"
    end
    if Hardware::CPU.arm?
      url "https://github.com/Knowledge-Forge-AI/agentic-praxis-grimoire/releases/download/v0.13.1/knowledge-forge-ai-apgr-linux-arm64-0.13.1.tgz"
      sha256 "6ca5c5f4a3856a263c23e66ff7ad97181c84de1f78a3710abe6fd8dd3a49a9d0"
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
      macOS Apple Silicon (darwin/arm64) native binary execution is qualified
      and requires macOS Monterey (12) or later.
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
