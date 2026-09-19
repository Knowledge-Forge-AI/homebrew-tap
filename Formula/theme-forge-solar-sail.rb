class ThemeForgeSolarSail < Formula
  desc "Tailwind v4 and shadcn/ui deterministic theme compiler"
  homepage "https://github.com/Knowledge-Forge-AI/theme-forge-solar-sail"
  url "https://github.com/Knowledge-Forge-AI/theme-forge-solar-sail/releases/download/v0.1.0/knowledge-forge-ai-theme-forge-solar-sail-0.1.0.tgz"
  sha256 "13bd26710f3bed95555e040a6ad2e13efd91424402ed86be2934c8aeed18e684"
  license "AGPL-3.0-or-later"

  depends_on "node@22"

  def install
    ENV.prepend_path "PATH", formula_opt_bin("node@22")
    system formula_opt_bin("node@22")/"npm", "install", "--global", "--prefix", libexec,
           "--ignore-scripts", "--no-audit", "--no-fund", cached_download
    (bin/"tfss").write_env_script libexec/"bin/tfss", PATH: "#{formula_opt_bin("node@22")}:$PATH"
  end

  test do
    assert_match "0.1.0", shell_output("#{bin}/tfss --version")
    assert_match "Theme Forge Solar Sail CLI", shell_output("#{bin}/tfss --help")
  end
end
