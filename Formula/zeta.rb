class Zeta < Formula
  desc "Swiss-army-knife Zeta client and tools"
  homepage "https://github.com/gematik/zeta-cli"
  url "https://github.com/gematik/zeta-cli/releases/download/v0.9.3/zeta-0.9.3.tar.gz"
  sha256 "0f04137d1547bfb48f8904fc1f6687ec5b8ae8c532ca6433351a64d048a487f9"
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
