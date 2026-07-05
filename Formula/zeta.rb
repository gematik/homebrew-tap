class Zeta < Formula
  desc "Swiss-army-knife Zeta client and tools"
  homepage "https://github.com/gematik/zeta-cli"
  url "https://github.com/spilikin/homebrew-tap/releases/download/v0.8.0/zeta-0.8.0.tar.gz"
  sha256 "c6132cc3715852ccb713c11772d1edfbea3cd5f789e28b67a7c40126ffbf9a55"
  license "Apache-2.0"

  depends_on "openjdk@21"

  def install
    libexec.install Dir["*"]
    (bin/"zeta").write_env_script libexec/"bin/zeta",
      Language::Java.overridable_java_home_env("21")
  end

  test do
    assert_match(/^zeta /, shell_output("#{bin}/zeta version"))
  end
end
