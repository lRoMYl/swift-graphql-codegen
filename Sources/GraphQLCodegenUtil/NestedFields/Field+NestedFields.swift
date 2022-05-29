//
//  File.swift
//
//
//  Created by Romy Cheah on 22/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig

public extension Field {
  func nestedTypeFields(
    schema: Schema,
    excluded: [Field],
    scalarMap: ScalarMap,
    selectionMap: SelectionMap?,
    objectTypeMap: ObjectTypeMap,
    sortType: FieldSortType = .name
  ) throws -> [Field] {
    let namedType = schema.type(name: type.namedType.name)

    var fields = [Field]()
    var objectTypes = [ObjectType]()

    switch namedType {
    case .enum, .scalar:
      break
    case let .interface(interfaceType):
      fields.append(Field(with: interfaceType))

      let possibleObjectTypes = try interfaceType.possibleObjectTypes(objectTypeMap: objectTypeMap)
      objectTypes.append(contentsOf: possibleObjectTypes)
    case let .union(unionType):
      fields.append(Field(with: unionType))

      let possibleObjectTypes = try unionType.possibleObjectTypes(objectTypeMap: objectTypeMap)
      objectTypes.append(contentsOf: possibleObjectTypes)
    case let .object(objectType):
      objectTypes.append(objectType)
    case .inputObject:
      break
    case .none:
      break
    }

    try objectTypes.forEach {
      switch $0.kind {
      case .object, .interface, .union:
        fields.append(Field(with: $0))
      case .enumeration, .inputObject, .scalar:
        break
      }

      let selectableFields = $0.selectableFields(selectionMap: selectionMap).filter {
        $0.type.namedType != self.type.namedType && !excluded.contains($0)
      }

      try selectableFields.forEach {
        switch $0.type {
        case let .named(outputRef):
          switch outputRef {
          case .object, .interface, .union:
            fields.append($0)

            fields.append(
              contentsOf: try $0.nestedTypeFields(
                schema: schema,
                excluded: excluded + fields,
                scalarMap: scalarMap,
                selectionMap: selectionMap,
                objectTypeMap: objectTypeMap,
                sortType: sortType
              )
            )
          case .enum, .scalar:
            break
          }
        case .list, .nonNull:
          fields.append(
            contentsOf: try $0.nestedTypeFields(
              schema: schema,
              excluded: excluded + fields,
              scalarMap: scalarMap,
              selectionMap: selectionMap,
              objectTypeMap: objectTypeMap,
              sortType: sortType
            )
          )
        }
      }
    }

    return fields
      .unique(by: { $0.type.namedType.name })
      .sorted(by: sortType)
  }

  func nestedFields(
    objects: [ObjectType],
    scalarMap: ScalarMap,
    excluded: [Field],
    selectionMap: SelectionMap?,
    sortType: FieldSortType = .name
  ) throws -> [Field] {
    var fields = [Field]()
    fields.append(self)

    guard
      let returnObjectType = objects.first(where: { $0.name == type.namedType.name })
    else {
      return fields
    }

    let selectableFields = returnObjectType.selectableFields(selectionMap: selectionMap).filter {
      $0.type.namedType != self.type.namedType && !excluded.contains($0)
    }
    let filteredSelectableFields = selectableFields.filter {
      $0.type.namedType != self.type.namedType && !excluded.contains($0)
    }

    try filteredSelectableFields.forEach {
      switch $0.type {
      case let .named(outputRef):
        switch outputRef {
        case .object, .interface, .union:
          fields.append($0)
          let innerNestedFields = try $0.nestedFields(
            objects: objects,
            scalarMap: scalarMap,
            excluded: excluded + fields,
            selectionMap: selectionMap
          )
          fields.append(contentsOf: innerNestedFields)
        case .enum, .scalar:
          fields.append($0)
        }
      case .list, .nonNull:
        fields.append(
          contentsOf: try $0.nestedFields(
            objects: objects,
            scalarMap: scalarMap,
            excluded: excluded + fields,
            selectionMap: selectionMap
          )
        )
      }
    }

    return fields
      .unique(by: { $0.name + $0.type.namedType.name })
      .sorted(by: sortType)
  }
}
