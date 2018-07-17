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

using import "query.capnp".QuerySet;
using Fs = import "files.capnp";
interface Services {
    version @0 () -> (version :Version);
    files @1 () -> (querySet :QuerySet(Fs.File));
    #mutableFiles @2 () -> (querySet :QuerySet(Fs.MutableFile));
    #streams @3 () -> (querySet :QuerySet(Fs.Stream));
}
