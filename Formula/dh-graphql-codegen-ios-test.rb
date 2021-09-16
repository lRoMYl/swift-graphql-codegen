class DhGraphqlCodegenIosTest < Formula
  desc "Swift GraphQL Code Generator"
  homepage "https://github.com/lRoMYl/homebrew-test-brew-cli"
  url "https://github.com/lRoMYl/homebrew-test-brew-cli/archive/0.1.10.tar.gz"
  sha256 "161f76bdbed6447d8f1c152ed5768658b99f9fee9d993e429a8c75bb63c38b7e"
  head "https://github.com/lRoMYl/homebrew-test-brew-cli.git"

  depends_on :xcode => :build
  depends_on :macos

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end
end
