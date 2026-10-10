# Template for the tap's Formula/ti.rb; `just publish-brew` fills in the placeholders.
class Ti < Formula
  desc "Command-line tool for the gematik Telematikinfrastruktur (TI)"
  homepage "https://github.com/gematik/zero-lab/tree/main/rust/ti-cli"
  version "0.3.0"
  license "Apache-2.0"

  # Released for Apple silicon Macs and x86_64 Linux only.
  on_macos do
    depends_on arch: :arm64
    url "https://github.com/gematik/zero-lab/releases/download/rust/ti-cli/v0.3.0/ti-0.3.0-aarch64-apple-darwin"
    sha256 "dd490ab73ddcb00ecea0ba132cf55297f559bd91fccf3166ae82574afc8007ab"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/gematik/zero-lab/releases/download/rust/ti-cli/v0.3.0/ti-0.3.0-x86_64-unknown-linux-musl"
    sha256 "eed260ecdf5b2a8c79613e2caac744ccf29ebd6abc8a1f7935b545445cd74b2c"
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
