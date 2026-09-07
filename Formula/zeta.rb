class Zeta < Formula
  desc "Command-line client for TI 2.0 Zero Trust services (ZETA Guard, PoPP, VSDM)"
  homepage "https://github.com/gematik/zeta-cli"
  url "https://github.com/gematik/zeta-cli/releases/download/v0.14.0/zeta-0.14.0.tar.gz"
  sha256 "9d33f6992dfbba73253995f6d5aac78b08cef5b53be5ae52c33c75159fb12cda"
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
