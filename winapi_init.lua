--core/winapi: winapi namespace + core + ffi: the platform for loading any proc/ file or oo/ file.
setfenv(1, require'winapi_namespace')
--require'winapi_debug'
require'winapi_ffi'
require'winapi_wintypes'
require'winapi_util'
require'winapi_types'
require'winapi_array'
require'winapi_struct'
require'winapi_wcs'
require'winapi_bitmask'
return _M
