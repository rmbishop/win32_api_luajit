--proc/gl11: opengl 1.1 API
setfenv(1, require'winapi_init')
require'winapi_gl'
require'gl_funcs11'
update(gl, require'gl_consts11')
package.loaded['gl_consts11'] = nil

local glGetString = gl.glGetString
function gl.glGetString(...)
	return ffi.string(glGetString(...))
end

return gl
