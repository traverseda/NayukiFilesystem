@0xd7ba548c2e44f821;
#This is meant to be a generic tagging interface
#similar to the one used by tagsistant
#In addition to traditional text tags like "file"
#or "photo", you should be able to use "namespace"
#tags. These tags have data, like `season:2`.
#This lets you construct queries like `date:>1992` or
#`score:>=50`.

struct Id @0xa90ddc98d0b52631 {
    union {
        uuid @0 :Data;
        sha256 @1 :Data;
    }
}

struct PlainTag {
    struct data {
        id @0 :Id;
    }
    exists @1 :Bool;
}

struct GenericNumeralTag(ExposedData) {
    struct data {
        id @0 :Id;
        value @2 :ExposedData;
    }
    exists @1 :Bool;
    enum queryType {
        greatorThan @3;
        lesserThan @4;
        equalTo @5;
    } 
}

struct Tag {
    union {
        plain @0 :PlainTag;
        uInt @1 :GenericNumeralTag(:UInt64)
        unixTime @2 :GenericNumeralTag(:Int64)
    }
}

struct Query {
    statements @0 :List(Statement);
    struct Statement {
        tag @0 :Tag;
    }
}

interface QuerySet(ExposedObjectType) {
    #Queryset api inspired by dango
    filter @0 (query :Query) -> (self :QuerySet); #Appends a query to a queryset
    latest @1 () -> (result :ExposedObjectType);
    pop @2 () -> (result :ExposedObjectType);
    length @3 () -> (length :Int64);
    byId @4 (id :Id) -> (result :ExposedObjectType);
    copy @5 () -> (new :QuerySet);
}
