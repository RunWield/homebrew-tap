require "json"

class Wld < Formula
  desc "Plan-first AI coding harness"
  homepage "https://github.com/gandazgul/runwield"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/gandazgul/runwield/releases/download/v0.11.9/wld-v0.11.9-darwin-arm64.tar.gz"
    sha256 "a98ff6e9f4b76c4c95896fa4ada683a58b7557f39baae96ffe47157fe486c3f8"
  else
    url "https://github.com/gandazgul/runwield/releases/download/v0.11.9/wld-v0.11.9-darwin-x64.tar.gz"
    sha256 "00e84bba12c6e7694594821324c7e765e9bd92850cf83fc3e43bc28ec2494f5f"
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
