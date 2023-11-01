#
# License: See LICENSE.md file
# GitHub: https://github.com/Baekalfen/PyBoy
#

from libc.stdint cimport int64_t, uint8_t, uint16_t, uint64_t

from pyboy cimport utils
from pyboy.utils cimport IntIOInterface, Logger


cdef Logger logger

cdef class RTC:
    cdef str filename
    cdef bint latch_enabled
    cdef uint64_t timezero
    cdef uint64_t sec_latch
    cdef uint64_t min_latch
    cdef uint64_t hour_latch
    cdef uint64_t day_latch_low
    cdef uint64_t day_latch_high
    cdef uint64_t day_carry
    cdef uint64_t halt

    cdef void stop(self) noexcept
    cdef void save_state(self, IntIOInterface) noexcept
    cdef void load_state(self, IntIOInterface, int) noexcept
    @cython.locals(t=uint64_t, days=int64_t)
    cdef void latch_rtc(self) noexcept nogil
    cdef void writecommand(self, uint8_t) noexcept nogil
    cdef uint8_t getregister(self, uint8_t) noexcept nogil
    @cython.locals(t=uint64_t)
    cdef void setregister(self, uint8_t, uint8_t) noexcept nogil
