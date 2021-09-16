class DhGraphqlCodegenIosTest < Formula
  desc "Swift GraphQL Code Generator"
  homepage "https://github.com/lRoMYl/homebrew-test-brew-cli"
  url "https://github.com/lRoMYl/homebrew-test-brew-cli/archive/0.1.2.tar.gz"
  sha256 "aadc12bcfc73c3c8a6971753636b76e8a882346688040e71a821a6ed86ddef71"
  head "https://github.com/lRoMYl/homebrew-test-brew-cli.git"
  version "0.1.2"

  depends_on :xcode => :build
  depends_on :macos

  def install
    system "make", "PREFIX=#{prefix}"
  end
end
