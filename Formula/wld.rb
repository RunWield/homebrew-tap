require "json"

class Wld < Formula
  desc "Plan-first AI coding harness"
  homepage "https://github.com/gandazgul/runwield"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/gandazgul/runwield/releases/download/v0.12.1/wld-v0.12.1-darwin-arm64.tar.gz"
    sha256 "c0ed1530863d903c0c00aa178dfac661c13b908811dde25059294e477663380d"
  else
    url "https://github.com/gandazgul/runwield/releases/download/v0.12.1/wld-v0.12.1-darwin-x64.tar.gz"
    sha256 "8e1d70d5a43d80c630ee272d11d6d455722cb2ccc5b0ed3998625b1fd840ac53"
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
