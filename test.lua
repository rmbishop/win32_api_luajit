winapi = require'winapi_init'
require'winapi_messageloop'

local main = winapi.Window{
   title = 'Demo',
   w = 600, h = 400,
   autoquit = true,
}

os.exit(winapi.MessageLoop())