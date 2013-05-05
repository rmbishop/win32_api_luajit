--result of cpp sys/types.h from mingw
local ffi = require'ffi'
require'stddef_h'
ffi.cdef[[
typedef long __time32_t;
typedef long long __time64_t;
typedef long _off_t;
typedef _off_t off_t;
typedef unsigned int _dev_t;
typedef _dev_t dev_t;
typedef short _ino_t;
typedef _ino_t ino_t;
typedef int _pid_t;
typedef _pid_t pid_t;
typedef unsigned short _mode_t;
typedef _mode_t mode_t;
typedef int _sigset_t;
typedef _sigset_t sigset_t;
typedef int _ssize_t;
typedef _ssize_t ssize_t;
typedef long long fpos64_t;
typedef long long off64_t;
typedef unsigned int useconds_t;
]]
