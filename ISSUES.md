# Known Issues

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
