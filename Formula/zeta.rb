class Zeta < Formula
  desc "Swiss-army-knife Zeta client and tools"
  homepage "https://github.com/gematik/zeta-cli"
  url "https://github.com/spilikin/homebrew-tap/releases/download/v0.7.1/zeta-0.7.1.tar.gz"
  sha256 "c2ad3b3c47efc3e6a6d711b89bb8ce3a16b87d39f49f6cfce16cf29956ebf156"
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
