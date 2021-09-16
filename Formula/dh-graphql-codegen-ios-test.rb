class DhGraphqlCodegenIosTest < Formula
  desc "Swift GraphQL Code Generator"
  homepage "https://github.com/lRoMYl/homebrew-test-brew-cli"
  url "https://github.com/lRoMYl/homebrew-test-brew-cli/archive/0.1.10.tar.gz"
  sha256 "5fe9ea0801f1332837a69a2a74519f68190d52ab161c5154f327a248b7d78420"
  head "https://github.com/lRoMYl/homebrew-test-brew-cli.git"

  depends_on :xcode => :build
  depends_on :macos

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end
end
