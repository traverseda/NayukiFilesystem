@0xd7ba548c2e44f821;
#This is meant to be a generic tagging interface
#similar to the one used by tagsistant
#In addition to traditional text tags like "file"
#or "photo", you should be able to use "namespace"
#tags. These tags have data, like `season:2`.
#This lets you construct queries like `date:>1992` or
#`score:>=50`.

struct Tag {
    name @0 :Text;
    union {
        plainTag @1 :Void;
        text @2 :Text;
        bool @3 :Bool;
        unixTime @4 :UInt64;
    }    
}
