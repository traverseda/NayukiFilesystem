@0x95ea522d8ccfc280;
using import "tags.capnp".QuerySet;

interface File extends(QuerySet(File)){
   #Copy-on-write files can't be written to
   #so the `write` method creates a new file
   #with all the same tags as the old file, and
   #adds the `deleted` tag to the old copy.
}

interface TempFile extends(QuerySet(TempFile)){
   #Tempfiles are addresable by uuid and support
   #standard unix file operations
}

interface Stream extends(QuerySet(Stream)){
   #Streams are pubsub mechanism based on tags
}
