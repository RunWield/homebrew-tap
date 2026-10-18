require "json"

class Wld < Formula
  desc "Plan-first AI coding harness"
  homepage "https://github.com/gandazgul/runwield"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/gandazgul/runwield/releases/download/v0.12.3/wld-v0.12.3-darwin-arm64.tar.gz"
    sha256 "295c98ebedcb79db90e034b5eaab5e228d410cb46df68bf400a0ebd7a6d5bff8"
  else
    url "https://github.com/gandazgul/runwield/releases/download/v0.12.3/wld-v0.12.3-darwin-x64.tar.gz"
    sha256 "49d7ae1dbc2970d1040ca10bc5826cdbc88590f0d417c05b56802ad6a79c02e3"
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
