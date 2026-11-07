class Zeta < Formula
  desc "Command-line client for TI 2.0 Zero Trust services (ZETA Guard, PoPP, VSDM)"
  homepage "https://github.com/gematik/zeta-cli"
  url "https://github.com/gematik/zeta-cli/releases/download/v0.15.0/zeta-0.15.0.tar.gz"
  sha256 "f966a5f5557a921e4946e9405f8eb411bdf62b63261457640b4af7f8c8de8102"
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
