class Gren < Formula
  desc "Beautiful terminal UI for managing Git worktrees"
  homepage "https://github.com/langtind/gren"
  version "0.2.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/langtind/gren/releases/download/v#{version}/gren-v#{version}-darwin-arm64.tar.gz"
      sha256 "74137d951918ee33909d1c9b12c608492ae70ad96ed9f50769d3d88e0e6c9dfc"
    else
      url "https://github.com/langtind/gren/releases/download/v#{version}/gren-v#{version}-darwin-amd64.tar.gz"
      sha256 "4a4f92a6c8827eb85799bed7de99ac7360144f75a6350d4e317dc3f58f74b712"
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