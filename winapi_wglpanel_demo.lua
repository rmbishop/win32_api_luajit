require'unit'
local winapi = require'winapi_init'
require'winapi_windowclass'
require'winapi_messageloop'
require'winapi_wglpanel'
local gl = require'winapi_gl11'

local main = winapi.Window{
	autoquit = true,
	visible = false,
	title = 'WGLPanel test'
}

local panel = winapi.WGLPanel{
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

local function pm(which)
	local ffi = require'ffi'
	local m = ffi.new'float[16]'
	gl.glGetFloatv(which, m)
	print'-----------------------'
	for i=0,3 do print(string.format('%.3f\t%.3f\t%.3f\t%.3f\t', m[i*4+0], m[i*4+1], m[i*4+2], m[i*4+3])) end
end

function axes(w)
	gl.glBegin(gl.GL_LINES)
	gl.glColor3d(1, 0, 0)
	gl.glVertex3d(0, 0, 0)
	gl.glVertex3d(w, 0, 0)
	gl.glColor3d(0, 1, 0)
	gl.glVertex3d(0, 0, 0)
	gl.glVertex3d(0, w, 0)
	gl.glColor3d(0, 0, 1)
	gl.glVertex3d(0, 0, 0)
	gl.glVertex3d(0, 0, w)
	gl.glEnd()
end

function plane(w, size)
	gl.glColor3d(1, 1, 1)
	gl.glBegin(gl.GL_LINES)
	w = w/2
	for y=-w,w,size do
		gl.glVertex3d(-w, y, 0)
		gl.glVertex3d(w, y, 0)
	end
	for x=-w,w,size do
		gl.glVertex3d(x, -w, 0)
		gl.glVertex3d(x, w, 0)
	end
	gl.glEnd()
end

function cube(w)
	gl.glPushMatrix()
	gl.glScaled(w, w, 1)
	gl.glRotated(r,1,0,0)
	axes(2)
	gl.glTranslated(0,0,2)
	local function face(c)
		gl.glBegin(gl.GL_QUADS)
		gl.glColor4d(c,0,0,.5)
		gl.glVertex3d(-1, -1, -1)
		gl.glColor4d(0,c,0,.5)
		gl.glVertex3d(1, -1, -1)
		gl.glColor4d(0,0,c,.5)
		gl.glVertex3d(1, 1, -1)
		gl.glColor4d(c,0,c,.5)
		gl.glVertex3d(-1, 1, -1)
		gl.glEnd()
	end
	gl.glTranslated(0,0,-2)
	face(1)
	gl.glTranslated(0,0,2)
	face(1)
	gl.glTranslated(0,0,-2)
	gl.glRotated(-90,0,1,0)
	face(1)
	gl.glTranslated(0,0,2)
	face(1)
	gl.glRotated(-90,1,0,0)
	gl.glTranslated(0,2,0)
	face(1)
	gl.glTranslated(0,0,2)
	face(1)
	gl.glPopMatrix()
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

	--axes(1)
	gl.glTranslated(0,0,-1)
	--gl.glRotated(r,1,0,0)
	--gl.glTranslated(-5500,-5500,-r)
	--plane(2000, 100)
	--axes(1000)
	cube(1)
end

main:init()

os.exit(winapi.MessageLoop())

