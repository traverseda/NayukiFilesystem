#Stores everything in a single lmdb file 
#max file size on 64 bit os is 128Tb, the maximum address space for a 48bit pointer
#So we can store 128Tb of data, plus tags.
#We don't actually need that much ram, obviously. LMDB uses memory-mapped files and lets
# the operating system handle paging/caching/whatever, and while it will use all the
# memory it can get it's hands on, that memory is generally immediatly freeable.

import lmdb
let dbenv = newLMDBEnv("./nayukiFsStore")
let txn = dbenv.newTxn()
let dbi = txn.dbiOpen(nil, 0)

dbenv.close(dbi)
dbenv.envClose()
