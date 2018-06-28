@0x9d2966ac7a5e5c41;

struct Version @0x8441555316c8ea1b {
    union {
        semVar :group {
            major @0 :Int8;
            minor @1 :Int8;
            patch @2 :Int8;
        }
        commit @3 :Text;
    }
}

interface Services {
    files @0 () -> (files :import "files.capnp".File);
    mutableFiles @1 () -> (files :import "files.capnp".MutableFile);
    stream @2 () -> (files :import "files.capnp".Stream);
    version @3 () -> (version :Version);
}
