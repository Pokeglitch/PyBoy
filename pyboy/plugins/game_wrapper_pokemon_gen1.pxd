#
# License: See LICENSE.md file
# GitHub: https://github.com/Baekalfen/PyBoy
#
cimport cython
from libc.stdint cimport uint8_t

from pyboy.plugins.base_plugin cimport PyBoyGameWrapper
from pyboy.utils cimport Logger


cdef Logger logger

cdef class GameWrapperPokemonGen1(PyBoyGameWrapper):
    pass
