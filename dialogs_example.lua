winapi = require'winapi_init'
setfenv(1, require'winapi_init')
require'winapi_messageloop'
require'winapi_menuclass'
require'winapi_messagebox'
require'winapi_filedialogs'

function maximize()
	winapi.MessageBox("HI")
end


local main = winapi.Window{
   title = 'Menu Example',
   w = 600, h = 400,
   autoquit = true,
   on_resizinsg = maximize
}

function OpenFiles(parent_hwnd)
	file_list = GetOpenFileNameA({multiselect = true, hwnd = parent_hwnd,title="Test Open"})

end

function SaveFile(parent_hwnd)
    file_name = GetSaveFileNameA({title="test title",hwnd = parent_hwnd, default_name = "test name"})
end

local file_submenu = Menu{
		items = {
			{
			text = 'Exit', on_click = function() main:close() end
			},
			{
			text = 'Message Box', on_click = function() winapi.MessageBox("hi") end
			},
			{
			text = 'Open', on_click = OpenFiles
			},
			{
			text = 'Save', on_click = SaveFile
			},
		}
	}
	


local mainm = MenuBar{ 
	items = {
		{
		 text = '&File', 
		 submenu = file_submenu
		},
		
		{text = '&Help'},
	},
}

main.menu = mainm


os.exit(MessageLoop())



