--ptrdiff_t, size_t and wchar_t are built-in but wint_t isn't.
--defined as short per mingw for compatibility with MS.
local ffi = require'ffi'
ffi.cdef[[
typedef short unsigned int wint_t;
]]
