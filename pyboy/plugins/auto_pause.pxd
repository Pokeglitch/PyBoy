#
# License: See LICENSE.md file
# GitHub: https://github.com/Baekalfen/PyBoy
#

from pyboy.plugins.base_plugin cimport PyBoyPlugin
from pyboy.utils cimport Logger


cdef Logger logger

cdef class AutoPause(PyBoyPlugin):
    pass


