A filesystem component for the k operating system, inspired by
[this](https://www.nayuki.io/page/designing-better-file-organization-around-tags-not-hierarchies)
tag based filesystem post.

It uses a traditional filesystem for actually storing the files, and caches tag
info in sqlite for faster querying.

As a component of the k operating system, the main way of interacting with it is
over a capnproto RPC interface.

As if this writing, the status of this component is: theoretical, this is all
wishfull thinking.

nayukiFs addresses content using hashes, so it is defacto copy-on-write. A
provision for temporary and special files, addressable via UUID, as intended.

Tags are capnproto ids, with plain-text mappings. Nayuki ships with several of
these tags built in, for internal use and for bootstrapping other mappings.
