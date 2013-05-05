--test/showcase: showcase window for the showcase part of modules.
setfenv(1, require'winapi_init')
require'winapi_windowclass'
require'winapi_messageloop'
require'winapi_comctl'
require'winapi_imagelistclass'

function ShowcaseWindow(info)
	return Window(update({}, {title = 'Showcase', autoquit = true}, info))
end

require'winapi_shellapi'
function ShowcaseImageList()
	return ImageList(ffi.cast('HIMAGELIST',
				SHGetFileInfo('c:\\', 0, 'SHGFI_ICON | SHGFI_SYSICONINDEX | SHGFI_SMALLICON')))
end


if not ... then
local window = ShowcaseWindow()
MessageLoop()
end
