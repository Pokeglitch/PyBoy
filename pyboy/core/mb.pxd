#
# License: See LICENSE.md file
# GitHub: https://github.com/Baekalfen/PyBoy
#

from libc.stdint cimport uint8_t, uint16_t, uint32_t, uint64_t, int64_t

import cython
cimport pyboy.core.cpu
cimport pyboy.core.timer
cimport pyboy.core.cartridge.base_mbc
from pyboy.utils cimport IntIOInterface
cimport pyboy.core.bootrom
cimport pyboy.core.ram
cimport pyboy.core.lcd
cimport pyboy.core.interaction
cimport pyboy.core.sound
from pyboy.utils cimport WindowEvent


cdef uint16_t STAT, LY, LYC
cdef short VBLANK, LCDC, TIMER, SERIAL, HIGHTOLOW
cdef int INTR_VBLANK, INTR_LCDC, INTR_TIMER, INTR_SERIAL, INTR_HIGHTOLOW
cdef int STATE_VERSION


cdef class Motherboard:
    cdef pyboy.core.interaction.Interaction interaction
    cdef pyboy.core.bootrom.BootROM bootrom
    cdef public pyboy.core.ram.RAM ram
    cdef pyboy.core.lcd.LCD lcd
    cdef public pyboy.core.cpu.CPU cpu
    cdef pyboy.core.timer.Timer timer
    cdef pyboy.core.sound.Sound sound
    cdef public pyboy.core.cartridge.base_mbc.BaseMBC cartridge
    cdef public bint bootrom_enabled
    cdef str serialbuffer

    # CGB
    cdef HDMA hdma
    cdef uint8_t key1
    cdef bint double_speed
    cdef public bint cgb

    cdef bint breakpoints_enabled
    cdef list breakpoints_list
    cdef int breakpoint_latch
    cdef list onCycle

    cdef inline bint processing_frame(self) noexcept

    cdef void buttonevent(self, WindowEvent) noexcept
    cdef void stop(self, bint) noexcept
    @cython.locals(cycles=int64_t, escape_halt=cython.int, mode0_cycles=int64_t)
    cdef bint tick(self) noexcept

    cdef void switch_speed(self) noexcept

    @cython.locals(pc=cython.int, bank=cython.int)
    cdef bint breakpoint_reached(self) noexcept

    cdef uint8_t getitem(self, uint16_t) noexcept
    cdef void setitem(self, uint16_t, uint8_t) noexcept

    @cython.locals(offset=cython.int, dst=cython.int, n=cython.int)
    cdef void transfer_DMA(self, uint8_t) noexcept
    cdef void save_state(self, IntIOInterface) noexcept
    cdef void load_state(self, IntIOInterface) noexcept

cdef class HDMA:
    cdef uint8_t hdma1
    cdef uint8_t hdma2
    cdef uint8_t hdma3
    cdef uint8_t hdma4
    cdef uint8_t hdma5
    cdef uint8_t _hdma5

    cdef bint transfer_active
    cdef uint16_t curr_src
    cdef uint16_t curr_dst

    cdef void set_hdma5(self, uint8_t, Motherboard) noexcept
    cdef int tick(self, Motherboard) noexcept

    cdef void save_state(self, IntIOInterface) noexcept
    cdef void load_state(self, IntIOInterface, int) noexcept
