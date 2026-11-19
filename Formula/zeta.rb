class Zeta < Formula
  desc "Command-line client for TI 2.0 Zero Trust services (ZETA Guard, PoPP, VSDM)"
  homepage "https://github.com/gematik/zeta-cli"
  url "https://github.com/gematik/zeta-cli/releases/download/v0.15.1/zeta-0.15.1.tar.gz"
  sha256 "9bdb5f0b2eacf7bffc0dca3436af3eb24efaa4ba914141478a2b2c6a618aeb8a"
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
