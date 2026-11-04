require "json"

class Wld < Formula
  desc "Plan-first AI coding harness"
  homepage "https://github.com/RunWield/runwield"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/RunWield/runwield/releases/download/v0.14.4/wld-v0.14.4-darwin-arm64.tar.gz"
    sha256 "3fcaa6f9cd8e7fd5725eb568af7ed034c0b490be92973a8adb5c76993536a503"
  else
    url "https://github.com/RunWield/runwield/releases/download/v0.14.4/wld-v0.14.4-darwin-x64.tar.gz"
    sha256 "a897700ce6511b6cec6bde2589ecd857df5f58759009be53874a80bdd61393b0"
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
