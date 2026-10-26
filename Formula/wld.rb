require "json"

class Wld < Formula
  desc "Plan-first AI coding harness"
  homepage "https://github.com/RunWield/runwield"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/RunWield/runwield/releases/download/v0.14.2/wld-v0.14.2-darwin-arm64.tar.gz"
    sha256 "e99b0d1c8e1dc5e856d51c3c7cb4d5fedc20c214e41dfffd6d0111efd2b35e16"
  else
    url "https://github.com/RunWield/runwield/releases/download/v0.14.2/wld-v0.14.2-darwin-x64.tar.gz"
    sha256 "5b57d2d8d2422cf2fabaf54681254f18588ce2fbd35738b0bf48922945d36221"
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
