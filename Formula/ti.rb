# Template for the tap's Formula/ti.rb; `just publish-brew` fills in the placeholders.
class Ti < Formula
  desc "Command-line tool for the gematik Telematikinfrastruktur (TI)"
  homepage "https://github.com/gematik/zero-lab/tree/main/rust/ti-cli"
  version "0.1.0"
  license "Apache-2.0"

  # Released for Apple silicon Macs and x86_64 Linux only.
  on_macos do
    depends_on arch: :arm64
    url "https://github.com/gematik/zero-lab/releases/download/rust/ti-cli/v0.1.0/ti-0.1.0-aarch64-apple-darwin"
    sha256 "8c2f2f42a5f20560ed83baeffdf6651b0dc297aa4ecbf88f562d5c929fddba71"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/gematik/zero-lab/releases/download/rust/ti-cli/v0.1.0/ti-0.1.0-x86_64-unknown-linux-musl"
    sha256 "6d00d38492d1267a75d75703c776243298ae079802fa66023123dee72bb05341"
  end

  def install
    # The release assets are bare executables, downloaded without the executable bit.
    binary = Dir["ti-*"].first
    chmod 0755, binary
    bin.install binary => "ti"
  end

  test do
    assert_match "ti #{version}", shell_output("#{bin}/ti --version")
  end
end
