#
# License: See LICENSE.md file
# GitHub: https://github.com/Baekalfen/PyBoy
#

import cython

from cpython.array cimport array
from libc.stdint cimport uint8_t, uint16_t, uint32_t

from pyboy.utils cimport Logger

from .base_mbc cimport BaseMBC


cdef Logger logger

cpdef BaseMBC load_cartridge(str) noexcept
cdef bint validate_checksum(uint8_t[:,:]) noexcept

@cython.locals(romdata=array, banksize=int)
cdef uint8_t[:, :] load_romfile(str) noexcept

cdef dict CARTRIDGE_TABLE
cdef dict EXTERNAL_RAM_TABLE
