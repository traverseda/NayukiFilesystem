"""nayukiFsCli is a python cli tool for accessing
a nayukiFs Instance.

Usage:
    nayukiFsCli info
    nayukiFsCli get <filter>...
    nayukiFsCli watch <filter>...
    nayukiFsCli put <tag>...

Options:
  -h --help     Show this screen.

"""
from docopt import docopt
import asyncio, socket, capnp
NayukiFilesystem = capnp.load('capnpSchema/NayukiFilesystem.capnp')

client = capnp.TwoPartyClient("localhost:7890")
def printInfo():
#    NayukiFilesystem.Services().version()
    services = client.bootstrap().cast_as(NayukiFilesystem.Services)
    print(services.version().wait())

if __name__ == '__main__':
    arguments = docopt(__doc__, version='nayukiFsCli 0.0')
    if arguments['info']:
        printInfo()
    print(arguments)
