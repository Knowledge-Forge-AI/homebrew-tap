class ThemeForgeStellarBurst < Formula
  desc "Deterministic design token and theme generator"
  homepage "https://github.com/Knowledge-Forge-AI/theme-forge-stellar-burst"
  url "https://registry.npmjs.org/@knowledge-forge-ai/theme-forge-stellar-burst/-/theme-forge-stellar-burst-0.6.1.tgz"
  sha256 "53ef41a3de3335e042f2c4b1d299b1155b64bfc6556a84baf6a62cb28bcca209"
  license "AGPL-3.0-or-later"

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/tfsb --version").strip
    assert_empty pipe_output(bin/"tfsb-studio-service", "", 0)
  end
end
