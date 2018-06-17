discard """This file defines the on-disk format for nayukiFs.
Each file starts with a metadata block.

If you're looking to extend this into a real filesysten layer,
something that interacts with block devices directly, this is
probably the place to start.
"""

from capnpSchema.tags import Tag

