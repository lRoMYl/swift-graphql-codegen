class DhGraphqlCodegenIosTest < Formula
  desc "Swift GraphQL Code Generator"
  homepage "https://github.com/lRoMYl/homebrew-test-brew-cli"
  url "https://github.com/lRoMYl/homebrew-test-brew-cli/archive/0.1.8.tar.gz"
  sha256 "fb0dccb54fc024cc38baac82c6bffdefb99fbfced27cdc9ef6899162a2ce6098"
  head "https://github.com/lRoMYl/homebrew-test-brew-cli.git"

  depends_on :xcode => :build
  depends_on :macos

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end
end
