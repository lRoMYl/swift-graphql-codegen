class DHGraphQLCodegeniOS < Formula
  desc "Swift GraphQL Code Generator"
  homepage "https://github.com/lRoMYl/test-brew-cli"
  url "https://github.com/lRoMYl/test-brew-cli/archive/refs/tags/0.1.0.tar.gz"
  sha256 "cee7118df26f0eb0427c1d7e485e32e1547823c7"
  head "https://github.com/lRoMYl/test-brew-cli.git"
  version "0.1.0"

  depends_on :xcode

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end
end