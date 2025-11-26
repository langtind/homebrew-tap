class Gren < Formula
  desc "Beautiful terminal UI for managing Git worktrees"
  homepage "https://github.com/langtind/gren"
  version "0.1.6"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/langtind/gren/releases/download/v#{version}/gren-v#{version}-darwin-arm64.tar.gz"
      sha256 "060b74da2ddb625f059a6d4caa7c492c1c73a974ad9fc54dba6203edee8c1ad1"
    else
      url "https://github.com/langtind/gren/releases/download/v#{version}/gren-v#{version}-darwin-amd64.tar.gz"
      sha256 "afffc32aeabcac1b0fd201bdcff506381d56f885d8b83a82e621b83eb6e5c7ed"
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