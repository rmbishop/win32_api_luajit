--proc/gl21: opengl 2.1 API
setfenv(1, require'winapi_init')
require'winapi_gl'
require'gl_funcs21'
update(gl, require'gl_consts21')
package.loaded['gl_consts21'] = nil

return gl

