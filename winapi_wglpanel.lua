--oo/wglpanel: opengl-enabled panel.
setfenv(1, require'winapi_init')
require'winapi_panelclass'
require'winapi_gl11'
require'winapi_wglext'

WGLPanel = class(Panel)

function WGLPanel:__before_create(info, args)
	info.own_dc = true
	WGLPanel.__index.__before_create(self, info, args)
end

function WGLPanel:__init(...)
	WGLPanel.__index.__init(self,...)
	self:invalidate()
end

function WGLPanel:on_destroy()
	if not self.hrc then return end
	wglMakeCurrent(nil, nil)
	wglDeleteContext(self.hrc)
end

function WGLPanel:WM_ERASEBKGND()
	return false --we draw our own background
end

function WGLPanel:on_resized()
	if not self.hrc then return end
	self:set_viewport()
	self:invalidate()
end

function WGLPanel:on_render() end --stub
function WGLPanel:set_viewport() end --stub
function WGLPanel:__after_gl_context() end --stub

function WGLPanel:on_paint(window_hdc)
	if not self.hrc then
		local pfd = PIXELFORMATDESCRIPTOR{
			flags = 'PFD_DRAW_TO_WINDOW | PFD_SUPPORT_OPENGL | PFD_DOUBLEBUFFER',
			pixel_type = 'PFD_TYPE_RGBA',
			cColorBits = 32,
			cDepthBits = 24,
			cStencilBits = 8,
			layer_type = 'PFD_MAIN_PLANE',
		}
		SetPixelFormat(window_hdc, ChoosePixelFormat(window_hdc, pfd), pfd)
		self.hrc = wglCreateContext(window_hdc)
		wglMakeCurrent(window_hdc, self.hrc)
		if gl.wglSwapIntervalEXT then --enable vsync
			gl.wglSwapIntervalEXT(1)
		end
		self:__after_gl_context()
		--TODO: use wglChoosePixelFormatARB to enable FSAA
		self:set_viewport()
	end
	self:on_render()
	SwapBuffers(window_hdc)
end

if not ... then require'winapi_wglpanel_demo' end
