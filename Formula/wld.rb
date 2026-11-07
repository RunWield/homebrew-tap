require "json"

class Wld < Formula
  desc "Plan-first AI coding harness"
  homepage "https://github.com/RunWield/runwield"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/RunWield/runwield/releases/download/v0.14.5/wld-v0.14.5-darwin-arm64.tar.gz"
    sha256 "be2b2261ddff7181747c7767ebf1fbe67d3c84162a5c7dcea166bb7cd4bf7aa9"
  else
    url "https://github.com/RunWield/runwield/releases/download/v0.14.5/wld-v0.14.5-darwin-x64.tar.gz"
    sha256 "e204834d1bceb74cf24fb86f22998420b599b06ece9dc9eb2af0035c2ed0eb01"
  end

  depends_on "1broseidon/tap/cymbal"
  depends_on "agent-browser"
  depends_on "gandazgul/tap/mnemoteca"
  depends_on "git"
  depends_on "ketch"
  depends_on :macos

  def install
    libexec.install "wld"
    (libexec/"runwield-install.json").write JSON.pretty_generate({
      schemaVersion:     1,
      packageManager:    "homebrew",
      packageIdentifier: "gandazgul/tap/wld",
      updateCommand:     "brew upgrade gandazgul/tap/wld",
      repairCommand:     "brew reinstall gandazgul/tap/wld",
      installDirectory:  libexec.to_s,
      version:           "v#{version}",
    })
    bin.install_symlink libexec/"wld" => "wld"
  end

  test do
    assert_match "runwield", shell_output("#{bin}/wld --version")
    assert_match "brew upgrade gandazgul/tap/wld", shell_output("#{bin}/wld update")
  end
end
