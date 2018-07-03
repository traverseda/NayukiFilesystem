import reactor, capnp, caprpc
from capnpSchema.NayukiFilesystem_schema import Services, Version, VersionKind

let serviceVersion = Version(kind:VersionKind.semVar,major:0, minor:0, patch:0)

proc version(self: Services): Version =
  return serviceVersion

