import capnp, capnp/gensupport, collections/iface

# file: capnpSchema/tags.capnp

type
  TagKind* {.pure.} = enum
    plainTag = 0, text = 1, bool = 2, unixTime = 3

  Tag* = ref object
    name*: string
    case kind*: TagKind:
    of TagKind.plainTag:
      discard
    of TagKind.text:
      text*: string
    of TagKind.bool:
      bool*: bool
    of TagKind.unixTime:
      unixTime*: uint64



makeStructCoders(Tag, [
  (kind, 0, low(TagKind), true),
  (unixTime, 8, 0, TagKind.unixTime)
  ], [
  (name, 0, PointerFlag.text, true),
  (text, 1, PointerFlag.text, TagKind.text)
  ], [
  (bool, 16, false, TagKind.bool)
  ])


