class Zeta < Formula
  desc "Swiss-army-knife Zeta client and tools"
  homepage "https://github.com/gematik/zeta-cli"
  url "https://github.com/spilikin/homebrew-tap/releases/download/v0.5.2/zeta-0.5.2.tar.gz"
  sha256 "3af871c6345f3f86b149210a541d0227bf760bf5926af0e6e67ef060c6e11e49"
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
