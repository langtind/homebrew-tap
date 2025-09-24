class Gren < Formula
  desc "Beautiful terminal UI for managing Git worktrees"
  homepage "https://github.com/langtind/gren"
  version "0.1.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/langtind/gren/releases/download/v#{version}/gren-v#{version}-darwin-arm64.tar.gz"
      sha256 "2e544357b8a88feb9abdcfbf0ee803af85b6fe66f2545186f979688d13a38290"
    else
      url "https://github.com/langtind/gren/releases/download/v#{version}/gren-v#{version}-darwin-amd64.tar.gz"
      sha256 "2333e84292f0e7de50d26c7fcb3c9042d3c4f22c7065eb643fd79172ad25fb81"
    end
  end

  def install
    if Hardware::CPU.arm?
      bin.install "gren-v#{version}-darwin-arm64" => "gren"
    else
      bin.install "gren-v#{version}-darwin-amd64" => "gren"
    end
  end

  test do
    assert_match "gren version", shell_output("#{bin}/gren --version")
  end
end