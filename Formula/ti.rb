# Template for the tap's Formula/ti.rb; `just publish-brew` fills in the placeholders.
class Ti < Formula
  desc "Command-line tool for the gematik Telematikinfrastruktur (TI)"
  homepage "https://github.com/gematik/zero-lab/tree/main/rust/ti-cli"
  license "EUPL-1.2"

  # Released for Apple silicon Macs and x86_64 Linux only. Homebrew allows url only
  # in an architecture block inside an OS block. The unsupported architecture of each
  # OS gets that OS's binary too, only so the formula still loads there and the arch
  # requirement refuses it with a clear message.
  on_macos do
    depends_on arch: :arm64
    on_arm do
      url "https://github.com/gematik/zero-lab/releases/download/rust/ti-cli/v0.6.2/ti-0.6.2-aarch64-apple-darwin"
      sha256 "0ed11359177f75d3104615c49cd15790e623fefcf96fa1631a2e68ae5bfd2699"
    end
    on_intel do
      url "https://github.com/gematik/zero-lab/releases/download/rust/ti-cli/v0.6.2/ti-0.6.2-aarch64-apple-darwin"
      sha256 "0ed11359177f75d3104615c49cd15790e623fefcf96fa1631a2e68ae5bfd2699"
    end
  end

  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://github.com/gematik/zero-lab/releases/download/rust/ti-cli/v0.6.2/ti-0.6.2-x86_64-unknown-linux-musl"
      sha256 "71ddb20c20afc4075747f9e29c9fdd8e0378c77467de169b22da955a31c56702"
    end
    on_arm do
      url "https://github.com/gematik/zero-lab/releases/download/rust/ti-cli/v0.6.2/ti-0.6.2-x86_64-unknown-linux-musl"
      sha256 "71ddb20c20afc4075747f9e29c9fdd8e0378c77467de169b22da955a31c56702"
    end
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
