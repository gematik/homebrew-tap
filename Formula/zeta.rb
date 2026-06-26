class Zeta < Formula
  desc "Swiss-army-knife Zeta client and tools"
  homepage "https://github.com/gematik/zeta-cli"
  url "https://github.com/spilikin/homebrew-tap/releases/download/v0.7.0/zeta-0.7.0.tar.gz"
  sha256 "0aa24ff7be7622e7ea803ac3c54dbf84f43394033d65b3a34b44f3a001f4b8a7"
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
