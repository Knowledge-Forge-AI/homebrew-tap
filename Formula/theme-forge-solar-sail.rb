class ThemeForgeSolarSail < Formula
  desc "Tailwind v4 and shadcn/ui application theme compiler, library, and tfss CLI"
  homepage "https://github.com/Knowledge-Forge-AI/theme-forge-solar-sail"
  url "https://registry.npmjs.org/@knowledge-forge-ai/theme-forge-solar-sail/-/theme-forge-solar-sail-0.2.0.tgz"
  sha256 "1a5e948d6970022f57ecde0ec1d9138650f2b78c7fafc0224f63e4ec8c223454"
  license "AGPL-3.0-or-later"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args(prefix: libexec)
    (bin/"tfss").write <<~EOS
      #!/bin/sh
      exec "#{formula_opt_bin("node")}/node" "#{libexec}/lib/node_modules/@knowledge-forge-ai/theme-forge-solar-sail/bin/tfss.js" "$@"
    EOS
  end

  test do
    (testpath/"probe.cjs").write <<~JS
      const assert = require("node:assert/strict");
      const fs = require("node:fs");
      const { spawnSync } = require("node:child_process");
      const cli = "#{bin}/tfss";
      const theme = "#{libexec}/lib/node_modules/@knowledge-forge-ai/theme-forge-solar-sail/examples/forge-console.theme.json";
      const run = (args, input) => spawnSync(cli, args, { input, encoding: "utf8", timeout: 10000 });
      assert.equal(run(["--version"]).status, 0);
      assert.equal(run(["validate", theme, "--json"]).status, 0);
      assert.equal(run(["compile", theme, "--out", "one.css", "--json"]).status, 0);
      assert.equal(run(["compile", theme, "--out", "two.css", "--json"]).status, 0);
      assert.equal(fs.readFileSync("one.css", "utf8"), fs.readFileSync("two.css", "utf8"));
      fs.writeFileSync("invalid.json", "{");
      assert.notEqual(run(["validate", "invalid.json", "--json"]).status, 0);
    JS
    system formula_opt_bin("node")/"node", testpath/"probe.cjs"
  end
end
