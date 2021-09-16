class DhGraphqlCodegenIosTest < Formula
  desc "Swift GraphQL Code Generator"
  homepage "https://github.com/lRoMYl/homebrew-test-brew-cli"
  url "https://github.com/lRoMYl/homebrew-test-brew-cli/archive/0.1.1.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  head "https://github.com/lRoMYl/homebrew-test-brew-cli.git"
  version "0.1.1"

  depends_on :xcode => :build
  depends_on :macos

  def install
    system "make", "PREFIX=#{prefix}"
  end
end
