class Lunch < Formula
  desc "CLI for Agens lunch ordering system"
  homepage "https://github.com/agensdev/lunsjbot-cli"
  version "0.1.0"

  head "https://github.com/agensdev/lunsjbot-cli.git", branch: "main"

  head do
    depends_on "go" => :build
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/agensdev/lunsjbot-cli/releases/download/v#{version}/lunch-v#{version}-darwin-arm64.tar.gz"
      sha256 "5ef1d30dbdb496195622c62eb4b646bf2c48e811f665e883cc015dce4fd1387e"
    else
      url "https://github.com/agensdev/lunsjbot-cli/releases/download/v#{version}/lunch-v#{version}-darwin-amd64.tar.gz"
      sha256 "f92329f9210e91d8088e0b7828a474a403ed39a66f3ba26722a6cf80815670e1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/agensdev/lunsjbot-cli/releases/download/v#{version}/lunch-v#{version}-linux-arm64.tar.gz"
      sha256 "ad7c5d466a318cb362cdfe8de0070a0f8a313243cc743a351e64b053eacbff03"
    else
      url "https://github.com/agensdev/lunsjbot-cli/releases/download/v#{version}/lunch-v#{version}-linux-amd64.tar.gz"
      sha256 "168dff4e3a3dd14651f7400fd9e6d4b7621dc6058ce10cabb53f9d7f25cf3d0d"
    end
  end

  def install
    if build.head?
      ldflags = %W[
        -s -w
        -X main.version=HEAD
        -X main.commit=#{Utils.git_short_head}
        -X main.date=#{time.iso8601}
      ]
      system "go", "build", *std_go_args(ldflags:)
    elsif OS.mac?
      if Hardware::CPU.arm?
        bin.install "lunch-v#{version}-darwin-arm64" => "lunch"
      else
        bin.install "lunch-v#{version}-darwin-amd64" => "lunch"
      end
    elsif OS.linux?
      if Hardware::CPU.arm?
        bin.install "lunch-v#{version}-linux-arm64" => "lunch"
      else
        bin.install "lunch-v#{version}-linux-amd64" => "lunch"
      end
    end
  end

  def caveats
    <<~EOS
      To use the lunch CLI, you need an API key from https://lunsjbot.agens.io/settings

      Configure your API key:
        lunch config set-key <your-api-key>

      Note: The API is only accessible on the Agens network (office or VPN).
    EOS
  end

  test do
    assert_match "version", shell_output("#{bin}/lunch version")
  end
end
