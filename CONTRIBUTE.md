# How to Contribute

Atm, there are no procedures/processes to contribute to the project so just look through the documents to understand the overall structure of the codegen tool and submit a PR :)

Atm, do tag @lRoMYl for code review

## Creating a new release

**Manual**
- Draft a new release [here](https://github.com/lRoMYl/swift-graphql-codegen/releases) just like any other Github release.
- Download the Source code (tar.gz) for the release you've just created
- Obtain the sha256 of the tar.gz file. For example, you can use this [online tool](https://emn178.github.io/online-tools/sha256_checksum.html)
- Goto [homebrew-tap](https://github.com/lRoMYl/homebrew-tap) to update the homebrew formulae for this new release
  - Locate `swift-graphql-codegen.rb`
  - Update the `url` field to point to the new release url, generally we only need to update the version portion of the url. E.g. `https://github.com/lRoMYl/swift-graphql-codegen/archive/refs/tags/`0.3.1`.tar.gz`
  - Update the `sha` field with the new release tar.gz sha256
- Use `brew install --build-from-source swift-graphql-codegen.rb` command to test if the build succeded locally
- Create a new PR in [homebrew-tap](https://github.com/lRoMYl/homebrew-tap) with the changes in `swift-graphql-codegen.rb`

**Automated**
- Its possible to just write a script in [homebrew-tap](https://github.com/lRoMYl/homebrew-tap) to update the version and sha256 with a single command line
- Will work on this later on when its necessary as there is some issues with the command to generate sha256 locally on my current local machine to test it properly.