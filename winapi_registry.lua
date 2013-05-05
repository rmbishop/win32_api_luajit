--proc/registry: registry API.
setfenv(1, require'winapi_init')

ffi.cdef[[
struct HKEY__ { int unused; }; typedef struct HKEY__ *HKEY;
typedef HKEY *PHKEY;
]]

