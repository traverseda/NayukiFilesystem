#! /bin/sh -e
capnp compile -onim capnpSchema/tags.capnp > capnpSchema/tags.nim
nim c --nimcache:".nimcache" --threads:on -o:nayukiFsService nayukiFsService.nim && rm -rf .nimcache
