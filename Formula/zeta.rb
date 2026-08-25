class Zeta < Formula
  desc "Swiss-army-knife Zeta client and tools"
  homepage "https://github.com/gematik/zeta-cli"
  url "https://github.com/gematik/zeta-cli/releases/download/v0.11.1/zeta-0.11.1.tar.gz"
  sha256 "6b439152bbd1e17d443e8d38b8da127b72447a1c10366b358b244a0a2d09666c"
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
