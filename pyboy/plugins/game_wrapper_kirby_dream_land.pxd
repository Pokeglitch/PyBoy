#
# License: See LICENSE.md file
# GitHub: https://github.com/Baekalfen/PyBoy
#
cimport cython
from libc.stdint cimport uint8_t

from pyboy.plugins.base_plugin cimport PyBoyGameWrapper
from pyboy.utils cimport Logger


cdef Logger logger

cdef int ROWS, COLS


cdef class GameWrapperKirbyDreamLand(PyBoyGameWrapper):
    cdef public int score
    cdef public int health
    cdef public int lives_left
    cdef public int fitness
    cdef public int _game_over