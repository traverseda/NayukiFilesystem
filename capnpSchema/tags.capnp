@0xd7ba548c2e44f821;
#This is meant to be a generic tagging interface
#similar to the one used by tagsistant
#In addition to traditional text tags like "file"
#or "photo", you should be able to use "namespace"
#tags. These tags have data, like `season:2`.
#This lets you construct queries like `date:>1992` or
#`score:>=50`.

struct Tag {
    name @0 :Text; #Canonical textual representation of this tag
    uuid @5 :Data;
    union {
        plainTag @1 :Void;
        text @2 :Text;
        bool @3 :Bool;
        unixTime @4 :UInt64;
    }    
}

struct Query {
    #Queries obviously need to be little chunka of bytecode.
    #But without building a capnproto interface to webassembly
    # we're just going to build a quick-and-dirty AST.

}

interface QuerySet(exposedObject) {
    filter @0 (query :Query) -> (self :QuerySet);
    latest @1 () -> (result :exposedObject);
#    run @2 () -> (values :List(exposedObject));
}
