@0xe569486054391e10;
#This file is full of dense and unpleasent tag definitions,
#as I can't figure out a pleasent way to do this without
#repeating myself a lot.

#If you're reading this file, you should probably start with
# `query.capnp`, as it's a lot more useful.

struct Id @0xa90ddc98d0b52631 {
    union {
        uuid @0 :Data;
        sha256 @1 :Data;
    }
}

struct PlainTag {
    struct Data {
        id @0 :Id;
    }
    struct Query {
        exists @0 :Bool;
    }
    data @0 :Data;
    query @1 :Query;
}

struct GenericNumeralQuery {
    #Generic query for all "== > <" tags
    exists @0 :Bool;
    enum QueryType {
        greatorThan @0;
        lesserThan @1;
        equalTo @2;
    }
}

struct UIntTag {
    struct Data {
        id @0 :Id;
        value @1 :UInt64;
    }
    data @0 :Data;
    query @1 :GenericNumeralQuery;
}

struct UnixTimestampTag {
    struct Data {
        id @0 :Id;
        value @1 :Int64;
    }
    data @0 :Data;
    query @1 :GenericNumeralQuery;
}
