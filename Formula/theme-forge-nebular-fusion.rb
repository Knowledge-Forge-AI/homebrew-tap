class ThemeForgeNebularFusion < Formula
  desc "CLI launcher for the Nebular Fusion desktop workbench"
  homepage "https://github.com/Knowledge-Forge-AI/theme-forge-nebular-fusion"
  url "https://github.com/Knowledge-Forge-AI/theme-forge-nebular-fusion/releases/download/v0.4.0/theme-forge-nebular-fusion-v0.4.0-aarch64-apple-darwin.tar.gz"
  sha256 "cf42598dabfa1b789c389c0c67fb0420fbf3e9c3947dd93f8478b60ec2652891"
  license "AGPL-3.0-or-later"

  depends_on arch: :arm64
  depends_on :macos

  def install
    app = "Theme Forge Nebular Fusion.app"
    odie "Nebular Fusion application payload is missing" unless File.directory?(app)

    libexec.install app

    (bin/"tfnf").write <<~SH
      #!/bin/sh
      app="#{libexec}/Theme Forge Nebular Fusion.app"
      executable="$app/Contents/MacOS/theme-forge-nebular-fusion"

      case "$1" in
        -v|--version)
          echo "theme-forge-nebular-fusion 0.4.0 (aarch64-darwin)"
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
    assert_match "0.4.0", shell_output("#{bin}/tfnf --version")
    assert_match "Nebular Fusion CLI launcher", shell_output("#{bin}/tfnf --help")
    assert_path_exists shell_output("#{bin}/tfnf --path").strip
  end
end
