#! /bin/sh -e
capnp compile -onim src/capnpSchema/NayukiFilesystem.capnp > src/capnpSchema/NayukiFilesystem_schema.nim
capnp compile -onim src/capnpSchema/files.capnp > src/capnpSchema/files_schema.nim
capnp compile -onim src/capnpSchema/query.capnp > src/capnpSchema/query_schema.nim
capnp compile -onim src/capnpSchema/tags.capnp > src/capnpSchema/tags_schema.nim
nim c --nimcache:".nimcache" --threads:on --debugger:native -p:./ -o:build/nayukiFsService src/nayukiFsService.nim && rm -rf .nimcache
