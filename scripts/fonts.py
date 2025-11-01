#!/usr/bin/env python3

import os
import sys

stderr = os.dup(2)
null = os.open(os.devnull, os.O_WRONLY)
os.dup2(null, 2)
os.close(null)
sys.stderr = os.fdopen(stderr, "w")

import gi
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

class Example(Gtk.Window):
    """Using Pango to get system fonts names"""

    def list_system_fonts(self):
        """Yield system fonts families names using Pango"""
        context = self.create_pango_context()
        for fam in context.list_families():
            yield fam.get_name()


a = Example()
system_fonts = list(a.list_system_fonts())
# print(system_fonts)

for i in system_fonts:
    print(i)

os.close(stderr)
