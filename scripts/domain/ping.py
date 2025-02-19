from Pinger import Pinger
from Printer import Printer
import sys

if len(sys.argv) < 2:
    printer = Printer()
    printer.colored('No domain specified on the command line, try:  ', '', printer.colors.fg.red)
    printer.colored('$ ./ping.py example.net', '', printer.colors.fg.green)
    exit(1)
domain = sys.argv[1]

pinger = Pinger()
pinger.domain = domain
pinger.ping()
