class DhGraphqlCodegenIosTest < Formula
  desc "Swift GraphQL Code Generator"
  homepage "https://github.com/lRoMYl/test-brew-cli"
  url "https://github.com/lRoMYl/test-brew-cli/archive/refs/tags/0.1.0.tar.gz"
  sha256 "1261106a36fce34030e2b95754079d34b5e25f465c7eb84925cb496c78a99625"
  head "https://github.com/lRoMYl/test-brew-cli.git"
  version "0.1.0"

  depends_on :xcode
  depends_on :macos

  def install
    xcodebuild "-arch", Hardware::CPU.arch,
        "-project", "DHGraphQLCodegenSwift.xcodeproj",
        "-scheme", "DHGraphQLCodegenSwift",
        "-configuration", "Release",
        "CODE_SIGN_IDENTITY=",
        "SYMROOT=build", "OBJROOT=build"
    bin.install "build/Release/DHGraphQLCodegenSwift"
  end
end