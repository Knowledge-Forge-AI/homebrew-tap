class ThemeForgeStellarBurst < Formula
  desc "Deterministic design token and theme generator"
  homepage "https://github.com/Knowledge-Forge-AI/theme-forge-stellar-burst"
  url "https://registry.npmjs.org/@knowledge-forge-ai/theme-forge-stellar-burst/-/theme-forge-stellar-burst-0.7.0.tgz"
  sha256 "c4b609a0b4705b17483577d5bde5deea518a83af08ce4d93c4662fa7cacc7d88"
  license "AGPL-3.0-or-later"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args(prefix: libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/tfsb --version").strip
    assert_empty pipe_output(bin/"tfsb-studio-service", "", 0)
  end
end
