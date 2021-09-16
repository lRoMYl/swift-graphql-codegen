class DhGraphqlCodegenIosTest < Formula
  desc "Swift GraphQL Code Generator"
  homepage "https://github.com/lRoMYl/homebrew-test-brew-cli"
  url "https://github.com/lRoMYl/homebrew-test-brew-cli/archive/0.1.4.tar.gz"
  sha256 "2ef751ea8b0bba39cbd003e4ef70a33841b23ca2dbd35064b142a540919c448a"
  head "https://github.com/lRoMYl/homebrew-test-brew-cli.git"
  version "0.1.3"

  depends_on :xcode => :build
  depends_on :macos

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end
end
