#
# License: See LICENSE.md file
# GitHub: https://github.com/Baekalfen/PyBoy
#

from pyboy.plugins.base_plugin cimport PyBoyWindowPlugin
from pyboy.utils cimport Logger


cdef Logger logger

cdef class WindowHeadless(PyBoyWindowPlugin):
    pass
