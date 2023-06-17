import class Foundation.Bundle
import XCTest

final class DHGraphQLCodegenCLITests: XCTestCase {
  func testExample() throws {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct
    // results.

    // Some of the APIs that we use below are available in macOS 10.13 and above.
    guard #available(macOS 10.13, *) else {
      return
    }

    let fooBinary = productsDirectory.appendingPathComponent("swift-graphql-codegen")

    let process = Process()

    // TODO add test argument for `bootstrap`, `codegen` and `introspection`
    //process.arguments = [""]

    process.executableURL = fooBinary

    let pipe = Pipe()
    process.standardOutput = pipe

    try process.run()
    process.waitUntilExit()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)

    XCTAssertEqual(
      output,
      """
      OVERVIEW: Swift GraphQL Codegeneration Tool\n\nUSAGE: swift-graphql-codegen <subcommand>\n\nOPTIONS:\n  --version               Show the version.\n  -h, --help              Show help information.\n\nSUBCOMMANDS:\n  codegen\n  introspection\n  bootstrap\n\n  See \'swift-graphql-codegen help <subcommand>\' for detailed help.\n
      """
    )
  }

  /// Returns path to the built products directory.
  var productsDirectory: URL {
#if os(macOS)
    for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
      return bundle.bundleURL.deletingLastPathComponent()
    }
    fatalError("couldn't find the products directory")
#else
    return Bundle.main.bundleURL
#endif
  }

  static var allTests = [
    ("testExample", testExample)
  ]
}
