@0xd7ba548c2e44f821;
#This is meant to be a generic tagging interface
#similar to the one used by tagsistant
#In addition to traditional text tags like "file"
#or "photo", you should be able to use "namespace"
#tags. These tags have data, like `season:2`.
#This lets you construct queries like `date:>1992` or
#`score:>=50`.

using Tags = import "tags.capnp";
struct Tag {
    union {
        plain @0 :Tags.PlainTag;
        uInt @1 :Tags.UIntTag;
        unixTime @2 :Tags.UnixTimestampTag;
    }
}

struct Query {
    statements @0 :List(Tag);
}

interface QuerySet(ExposedObjectType) {
    #Queryset api inspired by dango
    filter @0 (query :Query) -> (self :QuerySet); #Appends a query to a queryset
    latest @1 () -> (result :ExposedObjectType);
    pop @2 () -> (result :ExposedObjectType);
    length @3 () -> (length :Int64);
    byId @4 (id :Tags.Id) -> (result :ExposedObjectType);
    copy @5 () -> (new :QuerySet);
}
