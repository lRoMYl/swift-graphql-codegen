class DhGraphqlCodegenIosTest < Formula
  desc "Swift GraphQL Code Generator"
  homepage "https://github.com/lRoMYl/homebrew-test-brew-cli"
  url "https://github.com/lRoMYl/homebrew-test-brew-cli/archive/refs/tags/0.1.1.tar.gz"
  sha256 "62ce69460fb6d5edc42f10c603c00471dd4fc767"
  head "https://github.com/lRoMYl/homebrew-test-brew-cli.git"
  version "0.1.1"

  depends_on :xcode => :build
  depends_on :macos

  def install
    system "make", "PREFIX=#{prefix}"
  end
end