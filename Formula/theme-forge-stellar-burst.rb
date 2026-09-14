class ThemeForgeStellarBurst < Formula
  desc "Deterministic SVG scene compiler and asset installation tools"
  homepage "https://github.com/Knowledge-Forge-AI/theme-forge-stellar-burst"
  url "https://github.com/Knowledge-Forge-AI/theme-forge-stellar-burst/releases/download/v0.5.0/knowledge-forge-ai-theme-forge-stellar-burst-0.5.0.tgz"
  sha256 "1222b613b119f785061ac61e25eccf3af9810f2b118a4669481c23cd390c661e"
  license "AGPL-3.0-or-later"

  depends_on :macos
  depends_on "node@22"

  def install
    ENV.prepend_path "PATH", formula_opt_bin("node@22")
    system formula_opt_bin("node@22")/"npm", "install", "--global", "--prefix", libexec,
           "--ignore-scripts", "--no-audit", "--no-fund", cached_download
    package_root = libexec/"lib/node_modules/@knowledge-forge-ai/theme-forge-stellar-burst"
    prebuilds = package_root/"native/directory-snapshot/prebuilds"
    native_target = Hardware::CPU.arm? ? "darwin-arm64" : "darwin-x64"
    prebuilds.children.each { |directory| rm_r directory if directory.basename.to_s != native_target }
    (bin/"tfsb").write_env_script libexec/"bin/tfsb", PATH: "#{formula_opt_bin("node@22")}:$PATH"
    (bin/"tfsb-studio-service").write_env_script libexec/"bin/tfsb-studio-service",
                                              PATH: "#{formula_opt_bin("node@22")}:$PATH"
  end

  def caveats
    "SVG-only distribution. Raster and PNG output are unavailable."
  end

  test do
    assert_match "tfsb", shell_output("#{bin}/tfsb --help")
    assert_equal ["tfsb", "tfsb-studio-service"], bin.children.map { |x| x.basename.to_s }.sort
    package = libexec/"lib/node_modules/@knowledge-forge-ai/theme-forge-stellar-burst"
    cp package/"protocol/tfsb-scene-v1/examples/scene-geometry.json", testpath/"scene.json"
    system bin/"tfsb", "scene", "compile", "scene.json", "--output", "one.svg"
    system bin/"tfsb", "scene", "compile", "scene.json", "--output", "two.svg"
    assert_equal (testpath/"one.svg").read, (testpath/"two.svg").read
    first_inspection = shell_output("#{bin}/tfsb scene inspect scene.json --json")
    assert_equal first_inspection, shell_output("#{bin}/tfsb scene inspect scene.json --json")
    (testpath/"external.svg").write('<svg xmlns="http://www.w3.org/2000/svg"><image href="https://example.invalid/image.png"/></svg>')
    assert_match "REJECT", shell_output("#{bin}/tfsb scene import-svg external.svg --output rejected.json --json", 1)
    (testpath/"probe.mjs").write <<~JAVASCRIPT
      import assert from 'node:assert/strict';
      import {mkdirSync,writeFileSync} from 'node:fs';
      import * as pkg from '#{package}/dist/index.js';
      mkdirSync('icons');
      writeFileSync('icons/one.svg','<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><circle cx="12" cy="12" r="8"/></svg>');
      const map=pkg.parseSourceMap('schema_version = 1\\nsource_root = "."\\n[[collection]]\\nid = "icons"\\nname = "Icons"\\nroot = "icons"\\nidentity = "basename"\\nprefix = ""\\ninclude_paths = []\\ninclude_trees = ["."]\\nexclude_paths = []\\nexclude_trees = []\\n');
      assert(map.ok); assert(pkg.getDirectorySnapshotCapability(process.cwd()).supported);
      const snapshot=await pkg.createDirectorySnapshot(process.cwd(),map.value);assert(snapshot.ok);
      try{assert((await pkg.revalidateDirectorySnapshot(snapshot.value,map.value)).ok);}finally{pkg.closeDirectorySnapshot(snapshot.value);}
      const raster=await pkg.loadRasterCapability();assert.equal(raster.available,false);assert.equal(raster.code,'EXPORT_CAPABILITY_UNAVAILABLE');
    JAVASCRIPT
    system formula_opt_bin("node@22")/"node", "probe.mjs"
  end
end
