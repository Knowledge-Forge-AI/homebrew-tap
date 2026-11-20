class ReleaseStarport9 < Formula
  include Language::Python::Virtualenv

  desc "Release contract validation and publication planning CLI"
  homepage "https://github.com/Knowledge-Forge-AI/release-starport-9"
  url "https://github.com/Knowledge-Forge-AI/release-starport-9/releases/download/v0.1.0/release_starport_9-0.1.0.tar.gz"
  version "0.1.0"
  sha256 "95766cfc6c99cd61eea4a9c146a5ae2ae6776469f8e513676177cb4fd1bd1840"
  license "AGPL-3.0-or-later"

  depends_on "python@3.14"

  resource "cli-wheel" do
    url "https://github.com/Knowledge-Forge-AI/release-starport-9/releases/download/v0.1.0/release_starport_9-0.1.0-py3-none-any.whl"
    sha256 "8eca005afde7134e0dcb0e817b58f9b0e1ffe12a1e8697ba9a67123b28f84b57"
  end

  def install
    ENV["PIP_NO_INDEX"] = "1"
    wheel = buildpath/"release_starport_9-#{version}-py3-none-any.whl"
    cp resource("cli-wheel").cached_download, wheel
    virtualenv_create(libexec, "python3.14", system_site_packages: false)
      .pip_install_and_link(wheel, build_isolation: false)
    pkgshare.install "LICENSE", "NOTICE", "COMMERCIAL-LICENSE.md"
  end

  test do
    assert_equal "#{version}\n", shell_output("#{bin}/rs9 --version")
    doctor = JSON.parse(shell_output("#{bin}/rs9 --json doctor"))
    assert_equal true, doctor.fetch("ok")
    assert_equal true, doctor.fetch("result").fetch("python").fetch("tomllib")
    %w[LICENSE NOTICE COMMERCIAL-LICENSE.md].each do |file|
      assert_predicate pkgshare/file, :file?
    end
  end
end
