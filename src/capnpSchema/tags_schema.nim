import capnp, capnp/gensupport, collections/iface

# file: src/capnpSchema/tags.capnp

type
  IdKind* {.pure.} = enum
    uuid = 0, sha256 = 1

  Id* = ref object
    case kind*: IdKind:
    of IdKind.uuid:
      uuid*: string
    of IdKind.sha256:
      sha256*: string

  PlainTag* = ref object
    data*: PlainTag_Data
    query*: PlainTag_Query

  PlainTag_Data* = ref object
    id*: Id

  PlainTag_Query* = ref object
    exists*: bool

  GenericNumeralTag* = ref object
    exists*: bool

  GenericNumeralTag_QueryType* {.pure.} = enum
    greatorThan = 0, lesserThan = 1, equalTo = 2

  UIntTag* = ref object
    data*: UIntTag_Data
    query*: GenericNumeralTag

  UIntTag_Data* = ref object
    id*: Id
    value*: uint64

  UnixTimestampTag* = ref object
    data*: UnixTimestampTag_Data
    query*: GenericNumeralTag

  UnixTimestampTag_Data* = ref object
    id*: Id
    value*: int64



makeStructCoders(Id, [
  (kind, 0, low(IdKind), true)
  ], [
  (uuid, 0, PointerFlag.none, IdKind.uuid),
  (sha256, 0, PointerFlag.none, IdKind.sha256)
  ], [])

makeStructCoders(PlainTag, [], [
  (data, 0, PointerFlag.none, true),
  (query, 1, PointerFlag.none, true)
  ], [])

makeStructCoders(PlainTag_Data, [], [
  (id, 0, PointerFlag.none, true)
  ], [])

makeStructCoders(PlainTag_Query, [], [], [
  (exists, 0, false, true)
  ])

makeStructCoders(GenericNumeralTag, [], [], [
  (exists, 0, false, true)
  ])

makeStructCoders(UIntTag, [], [
  (data, 0, PointerFlag.none, true),
  (query, 1, PointerFlag.none, true)
  ], [])

makeStructCoders(UIntTag_Data, [
  (value, 0, 0, true)
  ], [
  (id, 0, PointerFlag.none, true)
  ], [])

makeStructCoders(UnixTimestampTag, [], [
  (data, 0, PointerFlag.none, true),
  (query, 1, PointerFlag.none, true)
  ], [])

makeStructCoders(UnixTimestampTag_Data, [
  (value, 0, 0, true)
  ], [
  (id, 0, PointerFlag.none, true)
  ], [])


