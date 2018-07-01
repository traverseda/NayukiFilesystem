@0x95ea522d8ccfc280;

interface File {
   #Copy-on-write files can't be written to
   #so the `write` method creates a new file
   #with all the same tags as the old file, and
   #adds the `deleted` tag to the old copy.
}

interface MutableFile {
   #MutableFiles are addresable by uuid and support
   #standard unix file operations
   #They do not use copy-on-write.
   #They exist mainly for the sake up bootstrapping the
   #sqlite database, since almost everything else can
   #be done using normal files.
}

interface Stream {
   #Streams are pubsub mechanisms based on tags
   #They're similar to mqtt, but unordered
}
