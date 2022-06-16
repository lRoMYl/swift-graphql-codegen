# Known Issues

## Failed to create file
```
Failed to create file at /API/Core/GraphQLEntities.generated.swift
```
Make sure the directory path exist, if not create it manually and retry again.

If this is the first time you're running the codegen, do note that you would need to manually create two directories in the directory you've provided.
- Core
- A second folder, following the name provided in `--api-client-prefix`.
- You can refer to the path in the errors as reference on what folders are missing.

P.S. Will rectify this issue by using a single directory to output the files and allow specific path customization if necessary using arguments.

## Empty fields selections for recursive fragment

E.g.
```Swift
enum SubCategorySelection: String, GraphQLSelection {
  case id
  case subCategories = """
  subCategories {
    ...%@SubCategoryFragment
  }
  """
}

struct ShopDetailsSelections {
  let subCategorySelections: Set<SubCategorySelection>
}

let selection = ShopDetailsSelections(
  subCategorySelections: [.subCategories]
)
```

If you only selected a single field in the selections field and that single field is a recursive fragment,
the generated code would be invalid as it is trying to select a fragment with empty fields in it.

This would create the following queries which is a nested subCategories query without any field being selected
```GraphQL
query {
  shopDetails {
    subCategories {
      subCategories {
        subCategories {
          subCategories {
            subCategories {
            }
          }
        }
      }
    }
  }
}
```

## Xcode Swift Package Manager unable to locate repository
```
Xcode Swift Package Manager error - The repository could not be found
```

HTTPS connection failed due to proxy configuration, check your `~/.gitconfig` and remove the following statement temporarily

```
[url "git@github.com:"]
insteadOf = https://github.com/
```