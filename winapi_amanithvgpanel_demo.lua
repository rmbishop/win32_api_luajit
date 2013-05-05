require'unit'
local winapi = require'winapi_init'
require'winapi_windowclass'
require'winapi_messageloop'
require'winapi_amanithvgpanel'
local gl = require'winapi_gl11'
local vg = require'amanithvg'

local main = winapi.Window{
	autoquit = true,
	visible = false,
	title = 'AmanithVGPanel test'
}

local panel = winapi.AmanithVGPanel{
	anchors = {left = true, top = true, right = true, bottom = true},
	visible = false,
}

function main:init()
	panel.w = self.client_w
	panel.h = self.client_h
	panel.parent = self
	panel.visible = true
	self.visible = true
	panel:settimer(1/60, panel.invalidate)
end

function panel:set_viewport()
	--set default viewport
	local w, h = self.client_w, self.client_h
	gl.glViewport(0, 0, w, h)
	gl.glMatrixMode(gl.GL_PROJECTION)
	gl.glLoadIdentity()
	gl.glFrustum(-1, 1, -1, 1, 1, 100) --so fov is 90 deg
	gl.glScaled(1, w/h, 1)
end

r = 1
function panel:on_render()
	r = r + 1

	gl.glEnable(gl.GL_BLEND)
	gl.glBlendFunc(gl.GL_SRC_ALPHA, gl.GL_SRC_ALPHA)
	gl.glDisable(gl.GL_DEPTH_TEST)
	gl.glDisable(gl.GL_CULL_FACE)
	gl.glDisable(gl.GL_LIGHTING)

	gl.glMatrixMode(gl.GL_MODELVIEW)
	gl.glLoadIdentity()

	gl.glTranslated(0,0,-1)
	--gl.glRotated(r,1,0,0)
	--gl.glTranslated(-5500,-5500,-r)

	vg.vgSeti(vg.VG_RENDERING_QUALITY, vg.VG_RENDERING_QUALITY_BETTER)
	vg.vgSeti(vg.VG_BLEND_MODE, vg.VG_BLEND_SRC)
	vg.vgClear(0, 0, self.client_w, self.client_h)
	vg.vgSeti(vg.VG_MATRIX_MODE, vg.VG_MATRIX_PATH_USER_TO_SURFACE)
	vg.vgLoadIdentity()
end

main:init()

os.exit(winapi.MessageLoop())

