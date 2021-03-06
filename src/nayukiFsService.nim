import reactor, capnp, caprpc
# you can't use `from xxx import yyy` for schema files
import capnpSchema.NayukiFilesystem_schema, capnpSchema.files_schema, capnpSchema.tags_schema, capnpSchema.query_schema

let serviceVersion = Version(kind:VersionKind.semVar,major:0, minor:1, patch:0)

type ServiceImpl = ref object of RootObj

proc version(self: ServiceImpl): Future[Version] {.async.} =
  return serviceVersion

let filesQuery = distinct query_schema.QuerySet files_schema.File

proc files(self: ServiceImpl): Future[filesQuery] {.async.} =
  return filesQuery

# implement other methods here

capServerImpl(ServiceImpl, [Services])

import parsecfg
var config = loadConfig("config.ini")

proc main() {.async.} =
  # let sys = newTwoPartyClient(await connectTcp("127.0.0.1:7890")) # localhost:6789
  let server = await createTcpServer(7890)

  let services = ServiceImpl()

  echo "waiting for incoming connections"
  asyncFor conn in server.incomingConnections:
    echo "connection received"
    discard newTwoPartyServer(conn.BytePipe, services.asServices.toCapServer)

when isMainModule:
  main().runMain()
