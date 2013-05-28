winapi = require'winapi_init'
setfenv(1, winapi)
require'winapi_messageloop'
require'winapi_menuclass'
require'winapi_messagebox'
require'winapi_htmlayoutclass'
require'winapi_filedialogs'
ffi = require'ffi'



html_text = [[
<HTML>
	<HEAD>
	<STYLE>
    h1 
    {
      font-size: 14pt;
    }
    h2
    {
      font-size: 14pt;
      text-align:right; 
    }
  
    #dd options > * /* tree line support */
    {
      display: list-item;
      --list-style-type: tree-line;
      --list-marker-size:1px;
      --list-marker-color:black;
      --list-marker-style:solid;      
    }
    #dd options 
    {
      padding-left:16px;
    }
    #dd options >:first-child
    {
      margin-left:0;
    } 
	
	#dd options.source_tree
	{
	   behavior:source_tree;
	}
	
    #dd option code
    {
      /*display:inline-block;
      margin-left:*;
      text-align:center;
      min-width:2em;*/
      background-color:cornsilk;
      padding:0 2px;
      border:1px solid threedshadow;
    } 
    
    ul.tree-lines > li
    {
      display: list-item;
      list-style-type: tree-line;
      list-marker-color:green;
      list-marker-style:dashed;      
      list-marker-size:3px;
      padding:2px;
    }
    
	</STYLE>
	</HEAD>
	<BODY>
  
  <widget #dd type="select" style="height:*">
    <options class = "source_tree">
    <b>Files</b>
	</options>
  </widget> 
  </BODY>
  
</HTML>

]]



local main = winapi.Window{
   title = 'Example',
   w = 600, h = 400,
   autoquit = true,

}

source_tree = {

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
	   --print("EVENT")
	end,	

	on_data_arrived = function(event)
	   --print("DATA ARRIVED")
	end,	
	
}

function populate_tree(file_list)
   for i,file in pairs(file_list.files) do	 
     source_tree.AppendInnerHtml([[<option>]] .. file .. [[</option>]])
   end
local a = source_tree.GetInnerHtml()
print(a)
end


function OpenFiles(parent_hwnd)
	file_list = GetOpenFileNameA({multiselect = true, hwnd = parent_hwnd,title="Test Open"})
    return file_list
end

function SaveFile(parent_hwnd)
    file_name = GetSaveFileNameA({title="test title",hwnd = parent_hwnd, default_name = "test name"})
    return file_name
end

opening = 0
local file_submenu = Menu{
		items = {
			{
			text = 'Exit', on_click = function() main:close() end
			},
			{
			text = 'Save', on_click = function() SaveFile(main.hwnd) end
			},
			{
			text = 'Open', on_click = function() 
						 file_list = OpenFiles(main.hwnd);
						 htmlayout:LoadHtml(html_text); 
						 populate_tree(file_list); 
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


Window.maximize(htmlayout)


os.exit(MessageLoop())



