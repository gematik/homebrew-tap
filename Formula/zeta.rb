class Zeta < Formula
  desc "Swiss-army-knife Zeta client and tools"
  homepage "https://github.com/gematik/zeta-cli"
  url "https://github.com/gematik/zeta-cli/releases/download/v0.8.1/zeta-0.8.1.tar.gz"
  sha256 "0f884c8a4c24f21f9a2d70472b5c0c24c1d5cc0ab5aef63391a90995673203a5"
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
