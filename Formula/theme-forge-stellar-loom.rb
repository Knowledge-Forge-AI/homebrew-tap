class ThemeForgeStellarLoom < Formula
  desc "Theme builder and token compiler for the Theme Forge family"
  homepage "https://github.com/Knowledge-Forge-AI/theme-forge-stellar-loom"
  url "https://registry.npmjs.org/@knowledge-forge-ai/theme-forge-stellar-loom/-/theme-forge-stellar-loom-0.5.0.tgz"
  sha256 "4e7a7d436c09ba111f5dca8101876c6e085ad15859d96bab8f728c5669880b5f"
  license "AGPL-3.0-or-later"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args(prefix: libexec)
    (bin/"tfsl").write <<~EOS
      #!/bin/sh
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/lib/node_modules/@knowledge-forge-ai/theme-forge-stellar-loom/bin/tfsl.js" "$@"
    EOS
    (bin/"tfsl-batch").write <<~EOS
      #!/bin/sh
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/lib/node_modules/@knowledge-forge-ai/theme-forge-stellar-loom/bin/tfsl-batch.js" "$@"
    EOS
  end

  test do
    (testpath/"probe.cjs").write <<~JS
      const assert = require("node:assert/strict");
      const fs = require("node:fs");
      const { spawnSync } = require("node:child_process");
      const cli = "#{bin}/tfsl";
      const theme = "#{libexec}/lib/node_modules/@knowledge-forge-ai/theme-forge-stellar-loom/examples/stellar-cyan.theme.json";
      const run = (args, input) => spawnSync(cli, args, { input, encoding: "utf8", timeout: 10000 });
      assert.equal(run(["--version"]).status, 0);
      assert.equal(run(["validate", theme, "--json"]).status, 0);
      assert.equal(run(["compile", theme, "--out", "one", "--json"]).status, 0);
      assert.equal(run(["compile", theme, "--out", "two", "--json"]).status, 0);
      assert.equal(fs.readFileSync("one/theme.css", "utf8"), fs.readFileSync("two/theme.css", "utf8"));
      const batch = spawnSync("#{bin}/tfsl-batch", [], {
        input: JSON.stringify({ action: "example", exampleName: "stellar-cyan", uiRevision: 42 }),
        encoding: "utf8", timeout: 10000
      });
      assert.equal(batch.status, 0);
      assert.equal(JSON.parse(batch.stdout).uiRevision, 42);
      assert.equal(JSON.parse(batch.stdout).valid, true);
      fs.writeFileSync("invalid.json", "{");
      assert.notEqual(run(["validate", "invalid.json", "--json"]).status, 0);
    JS
    system Formula["node"].opt_bin/"node", testpath/"probe.cjs"
  end
end
