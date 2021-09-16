class DhGraphqlCodegenIosTest < Formula
  desc "Swift GraphQL Code Generator"
  homepage "https://github.com/lRoMYl/homebrew-test-brew-cli"
  url "https://github.com/lRoMYl/homebrew-test-brew-cli/archive/0.1.3.tar.gz"
  sha256 "916beebfc10c289f5d74c915f1672aa520e573a0c545223bc786b551e88a2825"
  head "https://github.com/lRoMYl/homebrew-test-brew-cli.git"
  version "0.1.2"

  depends_on :xcode => :build
  depends_on :macos

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end
end
