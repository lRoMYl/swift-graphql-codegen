class DhGraphqlCodegenIosTest < Formula
  desc "Swift GraphQL Code Generator"
  homepage "https://github.com/lRoMYl/homebrew-test-brew-cli"
  url "https://github.com/lRoMYl/homebrew-test-brew-cli/archive/0.1.9.tar.gz"
  sha256 "1c3977fbd60a219e46fdb8b0da74900115d988b97afce7539f07107828910de0"
  head "https://github.com/lRoMYl/homebrew-test-brew-cli.git"

  depends_on :xcode => :build
  depends_on :macos

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end
end
