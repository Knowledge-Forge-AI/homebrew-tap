class ThemeForgeStellarLoom < Formula
  desc "Starlight Theme v1 and v2 compiler and package generator"
  homepage "https://github.com/Knowledge-Forge-AI/theme-forge-stellar-loom"
  url "https://github.com/Knowledge-Forge-AI/theme-forge-stellar-loom/releases/download/v0.3.0/knowledge-forge-ai-theme-forge-stellar-loom-0.3.0.tgz"
  sha256 "bf00ee759573fa17b3c8191b73150a7b8c787491fb23aac825f4116e2dd52474"
  license "AGPL-3.0-or-later"

  depends_on "node@22"

  def install
    ENV.prepend_path "PATH", formula_opt_bin("node@22")
    system formula_opt_bin("node@22")/"npm", "install", "--global", "--prefix", libexec,
           "--ignore-scripts", "--no-audit", "--no-fund", cached_download
    (bin/"tfsl").write_env_script libexec/"bin/tfsl", PATH: "#{formula_opt_bin("node@22")}:$PATH"
    (bin/"tfsl-batch").write_env_script libexec/"bin/tfsl-batch", PATH: "#{formula_opt_bin("node@22")}:$PATH"
  end

  test do
    assert_match "0.3.0", shell_output("#{bin}/tfsl --version")
    assert_equal ["tfsl", "tfsl-batch"], bin.children.map { |x| x.basename.to_s }.sort
    package = libexec/"lib/node_modules/@knowledge-forge-ai/theme-forge-stellar-loom"
    cp package/"examples/amber-forge.theme.json", testpath/"theme.json"
    system bin/"tfsl", "validate", "theme.json"
    system bin/"tfsl", "compile", "theme.json", "--out", "first"
    system bin/"tfsl", "compile", "theme.json", "--out", "second"
    %w[theme.css theme.descriptor.json].each do |file|
      assert_equal (testpath/"first"/file).read, (testpath/"second"/file).read
    end
    (testpath/"metadata.json").write('{"name":"starlight-theme-brew-probe","version":"1.0.0"}')
    system bin/"tfsl", "generate", "theme.json", "--package", "metadata.json", "--out", "generated"
    assert_path_exists testpath/"generated/index.js"
    invalid = "#{bin}/tfsl generate theme.json --package metadata.json --out rejected --template not-a-template"
    assert_match "Unknown", shell_output("#{invalid} 2>&1", 1)
  end
end
