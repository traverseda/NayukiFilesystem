import reactor, capnp, caprpc
from capnpSchema.NayukiFilesystem_schema import Services, Version, VersionKind

let serviceVersion = Version(kind:VersionKind.semVar,major:0, minor:0, patch:0)

proc version(self: Services): Version =
  return serviceVersion

proc main() {.async.} =
  # let sys = newTwoPartyClient(await connectTcp("127.0.0.1:7890")) # localhost:6789
  let server = await createTcpServer(7890)

  let services = new(Services)

  echo "waiting for incoming connections"
  asyncFor conn in server.incomingConnections:
    echo "connection received"
    discard newTwoPartyServer(conn.BytePipe, toGenericCapServer(services))

when isMainModule:
main().runMain()
