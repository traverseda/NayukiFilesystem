import capnp, capnp/gensupport, collections/iface

import reactor, caprpc, caprpc/rpcgensupport
# file: src/capnpSchema/query.capnp
from src/capnpSchema/tags_schema import nil

type
  TagKind* {.pure.} = enum
    plain = 0, uInt = 1, unixTime = 2

  Tag* = ref object
    case kind*: TagKind:
    of TagKind.plain:
      plain*: tags_schema.PlainTag
    of TagKind.uInt:
      uInt*: tags_schema.UIntTag
    of TagKind.unixTime:
      unixTime*: tags_schema.UnixTimestampTag

  Query* = ref object
    statements*: seq[Tag]

  QuerySet* = distinct Interface
  QuerySet_CallWrapper* = ref object of CapServerWrapper

  QuerySet_filter_Params* = ref object
    query*: Query

  QuerySet_filter_Result* = ref object
    self*: QuerySet

  QuerySet_latest_Params* = ref object

  QuerySet_latest_Result* = ref object
    result*: AnyPointer

  QuerySet_pop_Params* = ref object

  QuerySet_pop_Result* = ref object
    result*: AnyPointer

  QuerySet_length_Params* = ref object

  QuerySet_length_Result* = ref object
    length*: int64

  QuerySet_byId_Params* = ref object
    id*: tags_schema.Id

  QuerySet_byId_Result* = ref object
    result*: AnyPointer

  QuerySet_copy_Params* = ref object

  QuerySet_copy_Result* = ref object
    new*: QuerySet



makeStructCoders(Tag, [
  (kind, 0, low(TagKind), true)
  ], [
  (plain, 0, PointerFlag.none, TagKind.plain),
  (uInt, 0, PointerFlag.none, TagKind.uInt),
  (unixTime, 0, PointerFlag.none, TagKind.unixTime)
  ], [])

makeStructCoders(Query, [], [
  (statements, 0, PointerFlag.none, true)
  ], [])

interfaceMethods QuerySet:
  toCapServer(): CapServer
  filter(query: Query): Future[QuerySet]
  latest(): Future[AnyPointer]
  pop(): Future[AnyPointer]
  length(): Future[int64]
  byId(id: tags_schema.Id): Future[AnyPointer]
  copy(): Future[QuerySet]

proc filter*(selfFut: Future[QuerySet], query: Query): Future[QuerySet] =
  return selfFut.then((selfV) => selfV.filter(query))
proc latest*(selfFut: Future[QuerySet], ): Future[AnyPointer] =
  return selfFut.then((selfV) => selfV.latest())
proc pop*(selfFut: Future[QuerySet], ): Future[AnyPointer] =
  return selfFut.then((selfV) => selfV.pop())
proc length*(selfFut: Future[QuerySet], ): Future[int64] =
  return selfFut.then((selfV) => selfV.length())
proc byId*(selfFut: Future[QuerySet], id: tags_schema.Id): Future[AnyPointer] =
  return selfFut.then((selfV) => selfV.byId(id))
proc copy*(selfFut: Future[QuerySet], ): Future[QuerySet] =
  return selfFut.then((selfV) => selfV.copy())

proc getInterfaceId*(t: typedesc[QuerySet]): uint64 = return 14745132663550066130'u64

template forwardDecl*(iftype: typedesc[QuerySet], self, impltype): untyped {.dirty.} =
  proc filter(self: impltype, query: Query): Future[QuerySet] {.async.}
  proc latest(self: impltype, ): Future[AnyPointer] {.async.}
  proc pop(self: impltype, ): Future[AnyPointer] {.async.}
  proc length(self: impltype, ): Future[int64] {.async.}
  proc byId(self: impltype, id: tags_schema.Id): Future[AnyPointer] {.async.}
  proc copy(self: impltype, ): Future[QuerySet] {.async.}

miscCapMethods(QuerySet, QuerySet_CallWrapper)

proc capCall*[T: QuerySet](cap: T, id: uint64, args: AnyPointer): Future[AnyPointer] =
  case int(id):
    of 0:
      let argObj = args.castAs(QuerySet_filter_Params)
      let retVal = cap.filter(argObj.query)
      return wrapFutureInSinglePointer(QuerySet_filter_Result, self, retVal)
    of 1:
      let argObj = args.castAs(QuerySet_latest_Params)
      let retVal = cap.latest()
      return wrapFutureInSinglePointer(QuerySet_latest_Result, result, retVal)
    of 2:
      let argObj = args.castAs(QuerySet_pop_Params)
      let retVal = cap.pop()
      return wrapFutureInSinglePointer(QuerySet_pop_Result, result, retVal)
    of 3:
      let argObj = args.castAs(QuerySet_length_Params)
      let retVal = cap.length()
      return wrapFutureInSinglePointer(QuerySet_length_Result, length, retVal)
    of 4:
      let argObj = args.castAs(QuerySet_byId_Params)
      let retVal = cap.byId(argObj.id)
      return wrapFutureInSinglePointer(QuerySet_byId_Result, result, retVal)
    of 5:
      let argObj = args.castAs(QuerySet_copy_Params)
      let retVal = cap.copy()
      return wrapFutureInSinglePointer(QuerySet_copy_Result, new, retVal)
    else: raise newException(NotImplementedError, "not implemented")

proc getMethodId*(t: typedesc[QuerySet_filter_Params]): uint64 = 0'u64

proc filter*[T: QuerySet_CallWrapper](self: T, query: Query): Future[QuerySet] =
  return getFutureField(self.cap.call(14745132663550066130'u64, 0, toAnyPointer(QuerySet_filter_Params(query: query))).castAs(QuerySet_filter_Result), self)

proc getMethodId*(t: typedesc[QuerySet_latest_Params]): uint64 = 1'u64

proc latest*[T: QuerySet_CallWrapper](self: T, ): Future[AnyPointer] =
  return getFutureField(self.cap.call(14745132663550066130'u64, 1, toAnyPointer(QuerySet_latest_Params())).castAs(QuerySet_latest_Result), result)

proc getMethodId*(t: typedesc[QuerySet_pop_Params]): uint64 = 2'u64

proc pop*[T: QuerySet_CallWrapper](self: T, ): Future[AnyPointer] =
  return getFutureField(self.cap.call(14745132663550066130'u64, 2, toAnyPointer(QuerySet_pop_Params())).castAs(QuerySet_pop_Result), result)

proc getMethodId*(t: typedesc[QuerySet_length_Params]): uint64 = 3'u64

proc length*[T: QuerySet_CallWrapper](self: T, ): Future[int64] =
  return getFutureField(self.cap.call(14745132663550066130'u64, 3, toAnyPointer(QuerySet_length_Params())).castAs(QuerySet_length_Result), length)

proc getMethodId*(t: typedesc[QuerySet_byId_Params]): uint64 = 4'u64

proc byId*[T: QuerySet_CallWrapper](self: T, id: tags_schema.Id): Future[AnyPointer] =
  return getFutureField(self.cap.call(14745132663550066130'u64, 4, toAnyPointer(QuerySet_byId_Params(id: id))).castAs(QuerySet_byId_Result), result)

proc getMethodId*(t: typedesc[QuerySet_copy_Params]): uint64 = 5'u64

proc copy*[T: QuerySet_CallWrapper](self: T, ): Future[QuerySet] =
  return getFutureField(self.cap.call(14745132663550066130'u64, 5, toAnyPointer(QuerySet_copy_Params())).castAs(QuerySet_copy_Result), new)

makeStructCoders(QuerySet_filter_Params, [], [
  (query, 0, PointerFlag.none, true)
  ], [])

makeStructCoders(QuerySet_filter_Result, [], [
  (self, 0, PointerFlag.none, true)
  ], [])

makeStructCoders(QuerySet_latest_Params, [], [], [])

makeStructCoders(QuerySet_latest_Result, [], [
  (result, 0, PointerFlag.none, true)
  ], [])

makeStructCoders(QuerySet_pop_Params, [], [], [])

makeStructCoders(QuerySet_pop_Result, [], [
  (result, 0, PointerFlag.none, true)
  ], [])

makeStructCoders(QuerySet_length_Params, [], [], [])

makeStructCoders(QuerySet_length_Result, [
  (length, 0, 0, true)
  ], [], [])

makeStructCoders(QuerySet_byId_Params, [], [
  (id, 0, PointerFlag.none, true)
  ], [])

makeStructCoders(QuerySet_byId_Result, [], [
  (result, 0, PointerFlag.none, true)
  ], [])

makeStructCoders(QuerySet_copy_Params, [], [], [])

makeStructCoders(QuerySet_copy_Result, [], [
  (new, 0, PointerFlag.none, true)
  ], [])


