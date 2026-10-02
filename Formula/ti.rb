# Template for the tap's Formula/ti.rb; `just publish-brew` fills in the placeholders.
class Ti < Formula
  desc "Command-line tool for the gematik Telematikinfrastruktur (TI)"
  homepage "https://github.com/gematik/zero-lab/tree/main/rust/ti-cli"
  version "0.1.2"
  license "Apache-2.0"

  # Released for Apple silicon Macs and x86_64 Linux only.
  on_macos do
    depends_on arch: :arm64
    url "https://github.com/gematik/zero-lab/releases/download/rust/ti-cli/v0.1.2/ti-0.1.2-aarch64-apple-darwin"
    sha256 "b9422d806de708c891c85b52b9e986161030b55253b3cc76698c2a1f4ac8fdc7"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/gematik/zero-lab/releases/download/rust/ti-cli/v0.1.2/ti-0.1.2-x86_64-unknown-linux-musl"
    sha256 "582578bca3d7f04904f4594932a6d728f30adc1347ff06265501df272c636749"
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
