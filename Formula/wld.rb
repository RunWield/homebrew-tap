require "json"

class Wld < Formula
  desc "Plan-first AI coding harness"
  homepage "https://github.com/RunWield/runwield"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/RunWield/runwield/releases/download/v0.14.0/wld-v0.14.0-darwin-arm64.tar.gz"
    sha256 "02904d0380515fff623ea03fa356d3f114acf2b51cab078aabfcbc617dd4b51e"
  else
    url "https://github.com/RunWield/runwield/releases/download/v0.14.0/wld-v0.14.0-darwin-x64.tar.gz"
    sha256 "f714f2bc8aa4c6d547613eba70a9eced33026c67b19f3e829da34924d98aad38"
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
