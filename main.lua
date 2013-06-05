winapi = require'winapi_init'
setfenv(1, winapi)
require'winapi_messageloop'
require'winapi_menuclass'
require'winapi_messagebox'
require'winapi_htmlayoutclass'
require'winapi_filedialogs'
ffi = require("ffi")
bit = require("bit")


css_text = [[

	
	options#file_free 
	{
	   context-menu: selector(menu#source_file_context_menu);
	   behavior:file_tree;
	   border:none;
	}	
	
	
	

]]

html_text = [[
<HTML>
  <BODY>
  <frameset cols="200px,*">
  <div>
  <widget type="select" multiple style="height:*; width:*">
  <options #file_free>
  Files
  </options>
  </widget>
  </div>
  <splitter>
  </splitter>	
  <div>
  test
  </div>
  </frameset>
  
  <menu.context id="source_file_context_menu">
    <li style="behavior:context_remove_file" id="i1">Remove File</li>
    <li id="i2">Second item</li>
    <li id="i3">Third item</li>
    <li id="i4">Fourth item</li>
  </menu>	


  </BODY>
</HTML>
]]

local main = winapi.Window{
   title = 'Example',
   w = 600, h = 400,
   autoquit = true,

}


context_remove_file = {
	on_mouse = function(event)
	  if(html_events.MOUSE_DOWN == event.cmd) then
	    if(html_events.MAIN_MOUSE_BUTTON == event.button_state) then
		    to_delete = {}
			SelectElements(file_tree.element,"option",
			  function(element,param)
			    if(html_events.STATE_CHECKED == 
				  bit.band(GetState(element),html_events.STATE_CHECKED)) then
				  table.insert(to_delete,element)
				end
				return 0
			  end
			
			,nil)
			
			--do it in batch, not up above, or else htmlayout
			--will become confused.
			for i,element in pairs(to_delete) do
			   DeleteElement(element)
			end
	    end
	  end
	end,

}


file_tree = {

	on_initialization = function(event)
	end,
	
	on_key = function(event)
	   --print("KEY")
	end,

	on_mouse = function(event)
	  --print("MOUSE")
	end,

	on_focus = function(event)
	  --print("FOCUS")
	end,

	on_scroll = function(event)
	   --print("SCROLL")
	end,

	on_timer = function(event)
		   --print("TIMER")
	end,	

	on_size = function(event)
	   --print("SIZE")
	end,	

	on_draw = function(event)
	   --print("DRAW")
	end,		
	
	on_exchange = function(event)
	   --print("EXCHANGE")
	end,		

	on_event = function(event)
	--print(event.cmd)
	
	   
	end,	

	on_data_arrived = function(event)
	   --print("DATA ARRIVED")
	end,	
	
}

function add_files(file_list)
   for i,file in pairs(file_list.files) do	    
	 AppendInnerHtml(file_tree.element,[[<option >]] .. [[<table border="1"><th>]] .. file .. [[</th><th></th><tr><td></td></tr><tr><td>Placeholder1</td><td>Placeholder2</td><tr></table>]] .. [[</option>]])
   end
end


function OpenFiles(parent_hwnd)
	file_list = GetOpenFileNameA({multiselect = true, hwnd = parent_hwnd,title="Test Open"})
	return file_list
end

function SaveFile(parent_hwnd)
    file_name = GetSaveFileNameA({title="test title",hwnd = parent_hwnd, default_name = "test name"})
    return file_name
end

local file_submenu = Menu{
		items = {
			{
			text = 'Exit', on_click = function() main:close() end
			},
			{
			text = 'Save', on_click = function() SaveFile(main.hwnd) end
			},
			{
			text = 'Add File(s)', on_click = function() 
						 file_list = OpenFiles(main.hwnd);

						 if(0 ~= #file_list.files) then
							 
							 add_files(file_list); 
					     end
						end
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
htmlayout = HTMLayout
			{
					parent = main, 
					x = 10, 
					y = 10, 
					case = 'upper', 
					limit = 8,
					anchors = {
					left = true,
					top = true,
					right = true,
					bottom = true
					},	
					
			}

htmlayout:AppendMasterCSS(css_text)
htmlayout:LoadHtml(html_text)
Window.maximize(htmlayout)


os.exit(MessageLoop())



