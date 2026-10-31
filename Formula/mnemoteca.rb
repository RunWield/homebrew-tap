class Mnemoteca < Formula
  desc "Local semantic memory CLI"
  homepage "https://github.com/gandazgul/mnemoteca"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/RunWield/mnemoteca/releases/download/v0.3.4/mnemoteca_0.3.4_darwin_arm64.tar.gz"
    sha256 "b8e4a21c40ff3288b0792034e4cb847d7237c8c985c1c99989a8aac044479174"
  else
    url "https://github.com/RunWield/mnemoteca/releases/download/v0.3.4/mnemoteca_0.3.4_darwin_amd64.tar.gz"
    sha256 "550d1c9a9f5acd8921d9658b0ed14ad0529ae3d79dc329b210e0c6108490cacb"
  end

  depends_on :macos

  def install
    bin.install "mnemoteca"
  end

  test do
    ENV["MNEMOTECA_DB_PATH"] = testpath/"mnemoteca.sqlite3"
    assert_match "mnemoteca", shell_output(bin/"mnemoteca")
    system bin/"mnemoteca", "init", "--name", "homebrew-test"
  end
end
