import capnp, capnp/gensupport, collections/iface

import reactor, caprpc, caprpc/rpcgensupport
# file: src/capnpSchema/files.capnp

type
  File* = distinct Interface
  File_CallWrapper* = ref object of CapServerWrapper

  MutableFile* = distinct Interface
  MutableFile_CallWrapper* = ref object of CapServerWrapper

  Stream* = distinct Interface
  Stream_CallWrapper* = ref object of CapServerWrapper



interfaceMethods File:
  toCapServer(): CapServer


proc getInterfaceId*(t: typedesc[File]): uint64 = return 15574692273134335745'u64

miscCapMethods(File, File_CallWrapper)

proc capCall*[T: File](cap: T, id: uint64, args: AnyPointer): Future[AnyPointer] =
  case int(id):
    else: raise newException(NotImplementedError, "not implemented")

interfaceMethods MutableFile:
  toCapServer(): CapServer


proc getInterfaceId*(t: typedesc[MutableFile]): uint64 = return 10870393762345656438'u64

miscCapMethods(MutableFile, MutableFile_CallWrapper)

proc capCall*[T: MutableFile](cap: T, id: uint64, args: AnyPointer): Future[AnyPointer] =
  case int(id):
    else: raise newException(NotImplementedError, "not implemented")

interfaceMethods Stream:
  toCapServer(): CapServer


proc getInterfaceId*(t: typedesc[Stream]): uint64 = return 15994043755830787513'u64

miscCapMethods(Stream, Stream_CallWrapper)

proc capCall*[T: Stream](cap: T, id: uint64, args: AnyPointer): Future[AnyPointer] =
  case int(id):
    else: raise newException(NotImplementedError, "not implemented")


