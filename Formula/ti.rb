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
      url "https://github.com/gematik/zero-lab/releases/download/rust/ti-cli/v0.6.1/ti-0.6.1-aarch64-apple-darwin"
      sha256 "76072642d48f71cf26f0390419b5c8f9066b8b3ffeb60196b70550dc7d5cf4c2"
    end
    on_intel do
      url "https://github.com/gematik/zero-lab/releases/download/rust/ti-cli/v0.6.1/ti-0.6.1-aarch64-apple-darwin"
      sha256 "76072642d48f71cf26f0390419b5c8f9066b8b3ffeb60196b70550dc7d5cf4c2"
    end
  end

  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://github.com/gematik/zero-lab/releases/download/rust/ti-cli/v0.6.1/ti-0.6.1-x86_64-unknown-linux-musl"
      sha256 "3676354064e69f830736c17b42f96fb9cc701a07027ff06f30dafacf8995f0c1"
    end
    on_arm do
      url "https://github.com/gematik/zero-lab/releases/download/rust/ti-cli/v0.6.1/ti-0.6.1-x86_64-unknown-linux-musl"
      sha256 "3676354064e69f830736c17b42f96fb9cc701a07027ff06f30dafacf8995f0c1"
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
