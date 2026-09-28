class ThemeForgeStellarBurst < Formula
  desc "Deterministic design token and theme generator"
  homepage "https://github.com/Knowledge-Forge-AI/theme-forge-stellar-burst"
  url "https://registry.npmjs.org/@knowledge-forge-ai/theme-forge-stellar-burst/-/theme-forge-stellar-burst-0.6.0.tgz"
  sha256 "e6437f520745d54e461c51afcc77b1a457363237d3e7f788ed14f0c26c66a4a4"
  license "AGPL-3.0-or-later"

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "theme-forge-stellar-burst", shell_output("#{bin}/tfsb --version")
    assert_match "theme-forge-stellar-burst-service", shell_output("#{bin}/theme-forge-stellar-burst-service --version")
  end
end
