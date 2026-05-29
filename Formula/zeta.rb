class Zeta < Formula
  desc "Swiss-army-knife Zeta client and tools"
  homepage "https://github.com/gematik/zeta-cli"
  url "https://github.com/spilikin/homebrew-tap/releases/download/v0.5.1/zeta-0.5.1.tar.gz"
  sha256 "6c84f8af8af934d6c4620099841cc0d4b6716bca376b498a676ddf60976f6f0f"
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
