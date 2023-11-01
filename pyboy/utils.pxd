#
# License: See LICENSE.md file
# GitHub: https://github.com/Baekalfen/PyBoy
#
# cython: c_string_type=bytes, c_string_encoding=ascii

cimport cython
from libc.stdint cimport int64_t, uint8_t, uint16_t, uint32_t, uint64_t
from libc.stdio cimport fprintf, printf, stderr


cdef extern from "stdarg.h":
    ctypedef struct va_list:
        pass


cdef extern from *:
    """
    #define _log() ({ va_list va; va_start(va, __pyx_v_fmt); vfprintf(stderr, __pyx_v_fmt, va); va_end(va);})
    """
    # void _log(const char* fmt)
    void _log()

cdef class Logger:
    """
    iusdjfiosdf
    """
    cdef int log_level
    cdef str module

    # cdef void error3(self, *args) noexcept

    cdef inline void critical(self, char[] fmt, ...) noexcept:
        _log()
        # printf(self.module)
        # printf(x)

    cdef inline void error2(self, char[] fmt, ...) noexcept:
        # cdef char[128] _fmt = fmt.decode()
        # _log(_fmt)
        _log()

    cdef inline void error(self, char[] fmt, ...) noexcept:
        # cdef char[128] _fmt = fmt.decode()
        # _log(_fmt)
        _log()

    cdef inline void warning(self, char[] fmt, ...) noexcept:
        _log()
        # printf(self.module)
        # printf(x)

# IF DEBUG
#     cdef inline void info(self, char[] fmt, ...) noexcept:
#         _log()
#         # printf(self.module)
#         # printf(x)

#     cdef inline void debug(self, char[] fmt, ...) noexcept:
#         _log()
#         # printf(self.module)
#         # printf(x)
# ELSE
    cdef inline void info(self, str fmt, ...) noexcept:
        pass

    cdef inline void debug(self, str fmt, ...) noexcept:
        pass
# ENDIF

cdef Logger logger


##############################################################
# Buffer classes

cdef class IntIOInterface:
    cdef int64_t write(self, uint8_t) noexcept
    cdef int64_t write_16bit(self, uint16_t) noexcept
    cdef int64_t write_32bit(self, uint32_t) noexcept
    cdef int64_t write_64bit(self, uint64_t) noexcept
    cdef uint8_t read(self) noexcept
    cdef uint16_t read_16bit(self) noexcept
    cdef uint32_t read_32bit(self) noexcept

    @cython.locals(a=uint64_t, b=uint64_t, c=uint64_t,d=uint64_t,e=uint64_t,f=uint64_t,g=uint64_t,h=uint64_t,ret=uint64_t, ret2=uint64_t, ret1=uint64_t)
    cdef uint64_t read_64bit(self) noexcept
    cdef void seek(self, int64_t) noexcept
    cdef void flush(self) noexcept
    cdef uint64_t tell(self) noexcept


cdef class IntIOWrapper(IntIOInterface):
    cdef object buffer

##############################################################
# Misc

cdef uint8_t color_code(uint8_t, uint8_t, uint8_t) noexcept

##############################################################
# Window Events
# Temporarily placed here to not be exposed on public API

cdef class WindowEvent:
    cdef public int event

cdef class WindowEventMouse(WindowEvent):
    cdef public int window_id
    cdef public int mouse_x
    cdef public int mouse_y
    cdef public int mouse_scroll_x
    cdef public int mouse_scroll_y
    cdef public int mouse_button
