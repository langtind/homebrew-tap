class Lunch < Formula
  desc "CLI for Agens lunch ordering system"
  homepage "https://github.com/agensdev/lunsjbot-cli"
  version "0.2.0"

  head "https://github.com/agensdev/lunsjbot-cli.git", branch: "main"

  head do
    depends_on "go" => :build
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/agensdev/lunsjbot-cli/releases/download/v#{version}/lunch-v#{version}-darwin-arm64.tar.gz"
      sha256 "7ddbe2ede510dd9bcd477d5d0d95ae402d12a9092e93b88560606e2443acb8c6"
    else
      url "https://github.com/agensdev/lunsjbot-cli/releases/download/v#{version}/lunch-v#{version}-darwin-amd64.tar.gz"
      sha256 "56c6acd514f62329775495a25481a60b9e604bfaa741aa20e5f888f270cfa794"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/agensdev/lunsjbot-cli/releases/download/v#{version}/lunch-v#{version}-linux-arm64.tar.gz"
      sha256 "55baada99f348113c466646f4a911bf2c95f894e5de11161e6525dd2377b013f"
    else
      url "https://github.com/agensdev/lunsjbot-cli/releases/download/v#{version}/lunch-v#{version}-linux-amd64.tar.gz"
      sha256 "742203e73e910a81f49c541e2ea614684623602cdcc436470f6d3ba9244afed6"
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
