#! /bin/sh -e
capnp compile -onim capnpSchema/NayukiFilesystem.capnp > capnpSchema/NayukiFilesystem_schema.nim
capnp compile -onim capnpSchema/files.capnp > capnpSchema/files_schema.nim
capnp compile -onim capnpSchema/tags.capnp > capnpSchema/tags_schema.nim
nim c --nimcache:".nimcache" --threads:on -p:./ -o:nayukiFsService nayukiFsService.nim && rm -rf .nimcache
