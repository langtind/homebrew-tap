class Gren < Formula
  desc "Beautiful terminal UI for managing Git worktrees"
  homepage "https://github.com/langtind/gren"
  version "0.5.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/langtind/gren/releases/download/v#{version}/gren-v#{version}-darwin-arm64.tar.gz"
      sha256 "6e0a27e259aeb983c627dce04be3bc037a8d84c36c4e89daa56f28ff505c341e"
    else
      url "https://github.com/langtind/gren/releases/download/v#{version}/gren-v#{version}-darwin-amd64.tar.gz"
      sha256 "83f324448bcb4520f6ec4d60567183f581aab6e70f6dec5acbbe437cce732189"
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