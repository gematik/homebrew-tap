# Template for the tap's Formula/ti.rb; `just publish-brew` fills in the placeholders.
class Ti < Formula
  desc "Command-line tool for the gematik Telematikinfrastruktur (TI)"
  homepage "https://github.com/gematik/zero-lab/tree/main/rust/ti-cli"
  version "0.4.0"
  license "Apache-2.0"

  # Released for Apple silicon Macs and x86_64 Linux only.
  on_macos do
    depends_on arch: :arm64
    url "https://github.com/gematik/zero-lab/releases/download/rust/ti-cli/v0.4.0/ti-0.4.0-aarch64-apple-darwin"
    sha256 "6c5d28aeb28514f4d0fdf3f9311148bd30a9836b5eaa5600989776f9989d336c"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/gematik/zero-lab/releases/download/rust/ti-cli/v0.4.0/ti-0.4.0-x86_64-unknown-linux-musl"
    sha256 "258d4b47b99e12ecca1981a7fa374d5a617fed6b0444383f9502e8fa3a6a79aa"
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
