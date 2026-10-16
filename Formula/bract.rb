class Bract < Formula
  desc "A TUI that turns your CLI toolchain into a guided, browsable command palette."
  homepage "https://github.com/hopefullysurprising/bract"
  version "0.9.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hopefullysurprising/bract/releases/download/v0.9.0/bract-aarch64-apple-darwin.tar.xz"
      sha256 "f36b6bdc16071e1fc7ea641e4428f4fb7ed7e4fb4010c860e235aa74daf15e71"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hopefullysurprising/bract/releases/download/v0.9.0/bract-x86_64-apple-darwin.tar.xz"
      sha256 "f55b5c8c5035d7b0aa21f36243a2808103e24050fa71132661353148d2c16b82"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hopefullysurprising/bract/releases/download/v0.9.0/bract-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "64a1f56d64f861ec12968f2735b6d271f21ca65ccea39c56317bcb022958d603"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hopefullysurprising/bract/releases/download/v0.9.0/bract-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "68fc4f6b6e34cf3cbc05ca904b66106dda9960e966245e07ce1ec8e3548adbc7"
    end
  end
  license "GPL-3.0-only"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-pc-windows-gnu":    {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "bract"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "bract"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "bract"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "bract"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
