# Template for the tap's Formula/ehca.rb; `just publish-brew` fills in the placeholders.
class Ehca < Formula
  desc "Issues gematik TI test cards: eGK, HBA and SMC-B certificates and card images"
  homepage "https://github.com/gematik/homebrew-tap"
  license "Apache-2.0"

  # Released for Apple silicon Macs and x86_64 Linux only. Homebrew allows url only
  # in an architecture block inside an OS block. The unsupported architecture of each
  # OS gets that OS's binary too, only so the formula still loads there and the arch
  # requirement refuses it with a clear message.
  on_macos do
    depends_on arch: :arm64
    on_arm do
      url "https://github.com/gematik/homebrew-tap/releases/download/ehca-v0.4.1/ehca-0.4.1-aarch64-apple-darwin"
      sha256 "9dfce565d15ebc8285b027e90969bbae5adeea5d1f73f25dfc1f8585fa4b2c79"
    end
    on_intel do
      url "https://github.com/gematik/homebrew-tap/releases/download/ehca-v0.4.1/ehca-0.4.1-aarch64-apple-darwin"
      sha256 "9dfce565d15ebc8285b027e90969bbae5adeea5d1f73f25dfc1f8585fa4b2c79"
    end
  end

  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://github.com/gematik/homebrew-tap/releases/download/ehca-v0.4.1/ehca-0.4.1-x86_64-unknown-linux-gnu"
      sha256 "2561633314b299c3a5b1641747af8ab6a5bd161c9cb648b9ad9de2ce5ed03508"
    end
    on_arm do
      url "https://github.com/gematik/homebrew-tap/releases/download/ehca-v0.4.1/ehca-0.4.1-x86_64-unknown-linux-gnu"
      sha256 "2561633314b299c3a5b1641747af8ab6a5bd161c9cb648b9ad9de2ce5ed03508"
    end
  end

  def install
    # The release assets are bare executables, downloaded without the executable bit.
    binary = Dir["ehca-*"].first
    chmod 0755, binary
    bin.install binary => "ehca"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/ehca version").strip
  end
end
