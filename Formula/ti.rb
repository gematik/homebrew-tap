# Template for the tap's Formula/ti.rb; `just publish-brew` fills in the placeholders.
class Ti < Formula
  desc "Command-line tool for the gematik Telematikinfrastruktur (TI)"
  homepage "https://github.com/gematik/zero-lab/tree/main/rust/ti-cli"
  version "0.1.1"
  license "Apache-2.0"

  # Released for Apple silicon Macs and x86_64 Linux only.
  on_macos do
    depends_on arch: :arm64
    url "https://github.com/gematik/zero-lab/releases/download/rust/ti-cli/v0.1.1/ti-0.1.1-aarch64-apple-darwin"
    sha256 "f29c322c724bc9732bb392d28c95c68c152e944f0acedcaae3aa36f765cdfd5a"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/gematik/zero-lab/releases/download/rust/ti-cli/v0.1.1/ti-0.1.1-x86_64-unknown-linux-musl"
    sha256 "b176b8c06d5bbca97dbae894ad6b33f597e0d66e7c60f6f977f64a0b7a896251"
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
