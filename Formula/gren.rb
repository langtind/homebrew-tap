class Gren < Formula
  desc "Beautiful terminal UI for managing Git worktrees"
  homepage "https://github.com/langtind/gren"
  version "0.1.5"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/langtind/gren/releases/download/v#{version}/gren-v#{version}-darwin-arm64.tar.gz"
      sha256 "08df713734e02a10bffdc05c0335bbc54b937a5be4a092ad2d75c8eeb20bb533"
    else
      url "https://github.com/langtind/gren/releases/download/v#{version}/gren-v#{version}-darwin-amd64.tar.gz"
      sha256 "6a3a190971548217c8a1fe84372c49a3151454be45d28acbbdbc529bb275e8de"
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