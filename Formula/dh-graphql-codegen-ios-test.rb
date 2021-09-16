class DhGraphqlCodegenIosTest < Formula
  desc "Swift GraphQL Code Generator"
  homepage "https://github.com/lRoMYl/dh-graphql-codegen-ios"
  url "https://github.com/lRoMYl/dh-graphql-codegen-ios/archive/0.1.10.tar.gz"
  sha256 "8d6470111dbcc826ffb4a23d80666dea9b11b1ebec9ed1a1b57faad475ea8d50"
  head "https://github.com/lRoMYl/dh-graphql-codegen-ios.git"

  depends_on :xcode => :build
  depends_on :macos

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end
end
