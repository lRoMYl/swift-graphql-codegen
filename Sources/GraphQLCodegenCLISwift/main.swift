//
//  File.swift
//  
//
//  Created by Romy Cheah on 6/10/21.
//

import ArgumentParser
import GraphQLCodegenCLICore

GraphQLCodegenCLISwift.main()

struct GraphQLCodegenCLISwift: ParsableCommand {
  func run() throws {
    do {
      try mockGroceriesExample()
      print("Excuted")
    } catch {
      print("Error")
    }
  }
}
