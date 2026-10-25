class Bract < Formula
  desc "A TUI that turns your CLI toolchain into a guided, browsable command palette."
  homepage "https://github.com/hopefullysurprising/bract"
  version "0.10.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hopefullysurprising/bract/releases/download/v0.10.0/bract-aarch64-apple-darwin.tar.xz"
      sha256 "2910d9029d91fe69231206a2233f10f013c5fb7710d2c16903a0ec8b9c6268bd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hopefullysurprising/bract/releases/download/v0.10.0/bract-x86_64-apple-darwin.tar.xz"
      sha256 "dbf7978e08667361d9335ba73f5c68323c173c7a521a251f49bc03c0b07d9ae3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hopefullysurprising/bract/releases/download/v0.10.0/bract-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8501d337e93076b89572c96b5ccab80ad601e47ae709729d3d539a179238d7d5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hopefullysurprising/bract/releases/download/v0.10.0/bract-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d99c5c6093a97a63ae47e8411babbb69c8d95dbe2ca4afa82fe11e06379268a9"
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
