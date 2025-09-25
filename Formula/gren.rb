class Gren < Formula
  desc "Beautiful terminal UI for managing Git worktrees"
  homepage "https://github.com/langtind/gren"
  version "0.1.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/langtind/gren/releases/download/v#{version}/gren-v#{version}-darwin-arm64.tar.gz"
      sha256 "bbf48fe301a1cd8a205f3f34b64468650dd10e014ed20283ee1a7ba51bb3dcf6"
    else
      url "https://github.com/langtind/gren/releases/download/v#{version}/gren-v#{version}-darwin-amd64.tar.gz"
      sha256 "fe55f0daf8748cff8b16ada9371dd225a413278be4955b251feaf0aa0af1650c"
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