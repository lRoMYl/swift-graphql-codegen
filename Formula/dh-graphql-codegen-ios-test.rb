class DhGraphqlCodegenIosTest < Formula
  desc "Swift GraphQL Code Generator"
  homepage "https://github.com/lRoMYl/homebrew-test-brew-cli"
  url "https://github.com/lRoMYl/homebrew-test-brew-cli/archive/refs/tags/0.1.1.tar.gz"
  sha256 "91b936ed3961b668736a293c927375ab5b76f42e9b1d2d029592449328984ccc"
  head "https://github.com/lRoMYl/homebrew-test-brew-cli.git"
  version "0.1.1"

  depends_on :xcode => :build
  depends_on :macos

  def install
    system "make", "PREFIX=#{prefix}"
  end
end