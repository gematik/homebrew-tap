# Template for the tap's Formula/ti.rb; `just publish-brew` fills in the placeholders.
class Ti < Formula
  desc "Command-line tool for the gematik Telematikinfrastruktur (TI)"
  homepage "https://github.com/gematik/zero-lab/tree/main/rust/ti-cli"
  version "0.5.0"
  license "EUPL-1.2"

  # Released for Apple silicon Macs and x86_64 Linux only.
  on_macos do
    depends_on arch: :arm64
    url "https://github.com/gematik/zero-lab/releases/download/rust/ti-cli/v0.5.0/ti-0.5.0-aarch64-apple-darwin"
    sha256 "f9c1cb3cc0d26901843f6555e38ee1eaa63a463c0e08a4a4170ae65b2d9059a3"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/gematik/zero-lab/releases/download/rust/ti-cli/v0.5.0/ti-0.5.0-x86_64-unknown-linux-musl"
    sha256 "4b67f09f9ddecabddaa423ae2136bb67e5810bcde5239cc5ea2e5ae578cfc8be"
  end

  def install
    # The release assets are bare executables, downloaded without the executable bit.
    binary = Dir["ti-*"].first
    chmod 0755, binary
    bin.install binary => "ti"
  end

  test do
    assert_match "ti #{version}", shell_output("#{bin}/ti --format text version")
  end
end
