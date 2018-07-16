import capnp, capnp/gensupport, collections/iface

import reactor, caprpc, caprpc/rpcgensupport
# file: src/capnpSchema/NayukiFilesystem.capnp
from src/capnpSchema/files_schema import nil
from src/capnpSchema/query_schema import nil

type
  VersionKind* {.pure.} = enum
    semVar = 0, commit = 1

  Version* = ref object
    case kind*: VersionKind:
    of VersionKind.semVar:
      major*: int8
      minor*: int8
      patch*: int8
    of VersionKind.commit:
      commit*: string

  Services* = distinct Interface
  Services_CallWrapper* = ref object of CapServerWrapper

  Services_version_Params* = ref object

  Services_version_Result* = ref object
    version*: Version



makeStructCoders(Version, [
  (kind, 4, low(VersionKind), true),
  (major, 0, 0, VersionKind.semVar),
  (minor, 1, 0, VersionKind.semVar),
  (patch, 2, 0, VersionKind.semVar)
  ], [
  (commit, 0, PointerFlag.text, VersionKind.commit)
  ], [])

interfaceMethods Services:
  toCapServer(): CapServer
  version(): Future[Version]

proc version*(selfFut: Future[Services], ): Future[Version] =
  return selfFut.then((selfV) => selfV.version())

proc getInterfaceId*(t: typedesc[Services]): uint64 = return 14426587463180164121'u64

template forwardDecl*(iftype: typedesc[Services], self, impltype): untyped {.dirty.} =
  proc version(self: impltype, ): Future[Version] {.async.}

miscCapMethods(Services, Services_CallWrapper)

proc capCall*[T: Services](cap: T, id: uint64, args: AnyPointer): Future[AnyPointer] =
  case int(id):
    of 0:
      let argObj = args.castAs(Services_version_Params)
      let retVal = cap.version()
      return wrapFutureInSinglePointer(Services_version_Result, version, retVal)
    else: raise newException(NotImplementedError, "not implemented")

proc getMethodId*(t: typedesc[Services_version_Params]): uint64 = 0'u64

proc version*[T: Services_CallWrapper](self: T, ): Future[Version] =
  return getFutureField(self.cap.call(14426587463180164121'u64, 0, toAnyPointer(Services_version_Params())).castAs(Services_version_Result), version)

makeStructCoders(Services_version_Params, [], [], [])

makeStructCoders(Services_version_Result, [], [
  (version, 0, PointerFlag.none, true)
  ], [])


