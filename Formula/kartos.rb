# Template for the tap's Formula/kartos.rb; `just publish-brew` fills in the placeholders.
class Kartos < Formula
  desc "Simulator for gematik G2 and G2.1 smart cards and SICCT card terminals"
  homepage "https://github.com/gematik/homebrew-tap"
  license "Apache-2.0"

  # Released for Apple silicon Macs and x86_64 Linux only. Homebrew allows url only
  # in an architecture block inside an OS block. The unsupported architecture of each
  # OS gets that OS's binary too, only so the formula still loads there and the arch
  # requirement refuses it with a clear message.
  on_macos do
    depends_on arch: :arm64
    on_arm do
      url "https://github.com/gematik/homebrew-tap/releases/download/kartos-v0.9.2/kartos-0.9.2-aarch64-apple-darwin"
      sha256 "3875a4be67105aaa57f41a90072cfba8a7c3077dceb052500f0a7767a69c14ee"
    end
    on_intel do
      url "https://github.com/gematik/homebrew-tap/releases/download/kartos-v0.9.2/kartos-0.9.2-aarch64-apple-darwin"
      sha256 "3875a4be67105aaa57f41a90072cfba8a7c3077dceb052500f0a7767a69c14ee"
    end
  end

  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://github.com/gematik/homebrew-tap/releases/download/kartos-v0.9.2/kartos-0.9.2-x86_64-unknown-linux-gnu"
      sha256 "26c865e64e879722716761f92b8a5e3b16362f2a319e429e06f1d946a7dbe889"
    end
    on_arm do
      url "https://github.com/gematik/homebrew-tap/releases/download/kartos-v0.9.2/kartos-0.9.2-x86_64-unknown-linux-gnu"
      sha256 "26c865e64e879722716761f92b8a5e3b16362f2a319e429e06f1d946a7dbe889"
    end
  end

  def install
    # The release assets are bare executables, downloaded without the executable bit.
    binary = Dir["kartos-*"].first
    chmod 0755, binary
    bin.install binary => "kartos"
  end

  def caveats
    return unless OS.linux?

    <<~EOS
      The Linux binary links the system's PC/SC library, so it needs libpcsclite1
      (Debian/Ubuntu: apt install libpcsclite1). Physical readers also need pcscd.
    EOS
  end

  test do
    assert_match "kartos #{version}", shell_output("#{bin}/kartos version")
  end
end
