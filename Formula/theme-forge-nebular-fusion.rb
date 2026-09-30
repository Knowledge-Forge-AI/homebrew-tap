class ThemeForgeNebularFusion < Formula
  desc "CLI launcher for the Nebular Fusion desktop workbench"
  homepage "https://github.com/Knowledge-Forge-AI/theme-forge-nebular-fusion"
  url "https://github.com/Knowledge-Forge-AI/theme-forge-nebular-fusion/releases/download/v0.6.1/theme-forge-nebular-fusion-v0.6.1-aarch64-apple-darwin.app.tar.gz"
  sha256 "e5ab9c5ce5dd7fb02274b11b223db9db7ac1f3b2167334ee2f322abd3c8ec4be"
  license "AGPL-3.0-or-later"

  depends_on arch: :arm64
  depends_on :macos

  def install
    app = "Theme Forge Nebular Fusion.app"
    # Homebrew changes into an archive's lone top-level directory before install.
    staged = (File.basename(Dir.pwd) == app) ? Pathname.pwd : Pathname(app)
    odie "Nebular Fusion application payload is missing" unless (staged/"Contents/MacOS/theme-forge-nebular-fusion").file?

    (libexec/app).install staged.children

    (bin/"tfnf").write <<~SH
      #!/bin/sh
      app="#{libexec}/Theme Forge Nebular Fusion.app"
      executable="$app/Contents/MacOS/theme-forge-nebular-fusion"

      case "$1" in
        -v|--version)
          echo "theme-forge-nebular-fusion 0.6.1 (aarch64-darwin)"
          exit 0
          ;;
        -h|--help)
          echo "Theme Forge Nebular Fusion CLI launcher (aarch64-darwin Homebrew Formula)"
          echo "Usage: tfnf [--help|--version|--path]"
          exit 0
          ;;
        --path)
          echo "$app"
          exit 0
          ;;
      esac

      exec "$executable" "$@"
    SH
    chmod 0755, bin/"tfnf"
  end

  def caveats
    <<~EOS
      Installs the ad-hoc-signed macOS Apple Silicon developer application used by
      the tfnf launcher. Developer ID signing, notarization, Gatekeeper qualification,
      and a Homebrew Cask are not claimed.
    EOS
  end

  test do
    assert_match "0.6.1", shell_output("#{bin}/tfnf --version")
    assert_match "Nebular Fusion CLI launcher", shell_output("#{bin}/tfnf --help")
    assert_path_exists shell_output("#{bin}/tfnf --path").strip
  end
end
