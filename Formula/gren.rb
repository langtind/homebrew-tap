class Gren < Formula
  desc "Beautiful terminal UI for managing Git worktrees"
  homepage "https://github.com/langtind/gren"
  version "0.3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/langtind/gren/releases/download/v#{version}/gren-v#{version}-darwin-arm64.tar.gz"
      sha256 "1542f300f6ece30d181a74870c863035ef798c6f88f3d19eda72395990b954ee"
    else
      url "https://github.com/langtind/gren/releases/download/v#{version}/gren-v#{version}-darwin-amd64.tar.gz"
      sha256 "1045aba1c00ce0e32dd6910ecfd005c80043a5d81ad30d682596abc6dd80da47"
    end
  end

  def install
    if Hardware::CPU.arm?
      bin.install "gren-v#{version}-darwin-arm64" => "gren"
    else
      bin.install "gren-v#{version}-darwin-amd64" => "gren"
    end
  end

  def caveats
    <<~EOS
      Navigation functionality requires shell integration.

      Add one of these lines to your shell config:

        # Zsh (~/.zshrc):
        eval "$(gren shell-init zsh)"

        # Bash (~/.bashrc):
        eval "$(gren shell-init bash)"

        # Fish (~/.config/fish/config.fish):
        gren shell-init fish | source

      This enables:
        - 'g' key in TUI to navigate to worktree folder
        - 'gcd <name>' alias for quick navigation
        - 'gren navigate <name>' command
    EOS
  end

  test do
    assert_match "gren version", shell_output("#{bin}/gren --version")
    assert_match "gren()", shell_output("#{bin}/gren shell-init zsh")
  end
end