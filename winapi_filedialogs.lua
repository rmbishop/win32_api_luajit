--proc/comdlg/filedialogs: standard open and save file dialogs.
setfenv(1, require'winapi_init')
require'winapi_comdlg'

OFN_READONLY                 = 0x00000001
OFN_OVERWRITEPROMPT          = 0x00000002
OFN_HIDEREADONLY             = 0x00000004
OFN_NOCHANGEDIR              = 0x00000008
OFN_SHOWHELP                 = 0x00000010
OFN_ENABLEHOOK               = 0x00000020
OFN_ENABLETEMPLATE           = 0x00000040
OFN_ENABLETEMPLATEHANDLE     = 0x00000080
OFN_NOVALIDATE               = 0x00000100
OFN_ALLOWMULTISELECT         = 0x00000200
OFN_EXTENSIONDIFFERENT       = 0x00000400
OFN_PATHMUSTEXIST            = 0x00000800
OFN_FILEMUSTEXIST            = 0x00001000
OFN_CREATEPROMPT             = 0x00002000
OFN_SHAREAWARE               = 0x00004000
OFN_NOREADONLYRETURN         = 0x00008000
OFN_NOTESTFILECREATE         = 0x00010000
OFN_NONETWORKBUTTON          = 0x00020000
OFN_NOLONGNAMES              = 0x00040000     -- force no long names for 4.x modules
OFN_EXPLORER                 = 0x00080000     -- new look commdlg
OFN_NODEREFERENCELINKS       = 0x00100000
OFN_LONGNAMES                = 0x00200000     -- force long names for 3.x modules
-- OFN_ENABLEINCLUDENOTIFY and OFN_ENABLESIZING require
-- Windows 2000 or higher to have any effect.
OFN_ENABLEINCLUDENOTIFY      = 0x00400000     -- send include message to callback
OFN_ENABLESIZING             = 0x00800000
OFN_DONTADDTORECENT          = 0x02000000
OFN_FORCESHOWHIDDEN          = 0x10000000    -- Show All files including System and hidden files

--FlagsEx Values
OFN_EX_NOPLACESBAR = 0x00000001

-- Return values for the registered message sent to the hook function
-- when a sharing violation occurs.  OFN_SHAREFALLTHROUGH allows the
-- filename to be accepted, OFN_SHARENOWARN rejects the name but puts
-- up no warning (returned when the app has already put up a warning
-- message), and OFN_SHAREWARN puts up the default warning message
-- for sharing violations.
--
-- Note:  Undefined return values map to OFN_SHAREWARN, but are
--        reserved for future use.
OFN_SHAREFALLTHROUGH     = 2
OFN_SHARENOWARN          = 1
OFN_SHAREWARN            = 0

ffi.cdef[[
typedef UINT_PTR (*LPOFNHOOKPROC) (HWND, UINT, WPARAM, LPARAM);

typedef struct tagOFNW {
   DWORD        lStructSize;
   HWND         hwndOwner;
   HINSTANCE    hInstance;
   LPCWSTR      lpstrFilter;
   LPWSTR       lpstrCustomFilter;
   DWORD        nMaxCustFilter;
   DWORD        nFilterIndex;
   LPWSTR       lpstrFile;
   DWORD        nMaxFile;
   LPWSTR       lpstrFileTitle;
   DWORD        nMaxFileTitle;
   LPCWSTR      lpstrInitialDir;
   LPCWSTR      lpstrTitle;
   DWORD        Flags;
   WORD         nFileOffset;
   WORD         nFileExtension;
   LPCWSTR      lpstrDefExt;
   LPARAM       lCustData;
   LPOFNHOOKPROC lpfnHook;
   LPCWSTR      lpTemplateName;
   void *        pvReserved;
   DWORD        dwReserved;
   DWORD        FlagsEx;
} OPENFILENAMEW, *LPOPENFILENAMEW;

BOOL GetSaveFileNameW(LPOPENFILENAMEW);

typedef struct tagOFN {
  DWORD         lStructSize;
  HWND          hwndOwner;
  HINSTANCE     hInstance;
  LPCTSTR       lpstrFilter;
  LPTSTR        lpstrCustomFilter;
  DWORD         nMaxCustFilter;
  DWORD         nFilterIndex;
  LPTSTR        lpstrFile;
  DWORD         nMaxFile;
  LPTSTR        lpstrFileTitle;
  DWORD         nMaxFileTitle;
  LPCTSTR       lpstrInitialDir;
  LPCTSTR       lpstrTitle;
  DWORD         Flags;
  WORD          nFileOffset;
  WORD          nFileExtension;
  LPCTSTR       lpstrDefExt;
  LPARAM        lCustData;
  LPOFNHOOKPROC lpfnHook;
  LPCTSTR       lpTemplateName;
  void          *pvReserved;
  DWORD         dwReserved;
  DWORD         Flags;
} OPENFILENAMEA, *LPOPENFILENAME;


typedef struct tagNMHDR_alt {
  HWND     hwndFrom;
  UINT_PTR idFrom;
  int     code;
} NMHDR_alt;


typedef struct _OFNOTIFY {
  NMHDR_alt          hdr;
  LPOPENFILENAME lpOFN;
  LPTSTR         pszFile;
} OFNOTIFY, *LPOFNOTIFY;



BOOL GetOpenFileNameA(OPENFILENAMEA *lpofn);
BOOL GetSaveFileNameA(OPENFILENAMEA *lpofn);


DWORD GetFullPathNameA(LPCTSTR lpFileName,
                      DWORD nBufferLength,
					  LPTSTR lpBuffer,
					  LPTSTR *lpFilePart);


]]

kernel32 = ffi.load("Kernel32")

CDM_FIRST = (WM_USER+100)
CDM_GETSPEC = CDM_FIRST
CDM_GETFOLDERPATH   =  (CDM_FIRST + 2)

CDN_FIRST  = (0-601)
CDN_SELCHANGE = (CDN_FIRST - 1)
CDN_FILEOK = (CDN_FIRST - 5)


ERROR_NO_MORE_FILES = 18

function GetFolderPathSize(hwnd,wparam,lparam)
  return winapi.SendMessage(hwnd,CDM_GETFOLDERPATH,wparam,lparam) 
  end

function GetMultiSelectSize(hwnd,wparam,lparam)
  return winapi.SendMessage(hwnd,CDM_GETSPEC,wparam,lparam)
end

function GetFullPathName(file_name)
   local full_path_buffer = ffi.new("char[256]")
   ffi.fill(full_path_buffer,256,0) 
   result = kernel32.GetFullPathNameA(file_name,
					  256,
					  full_path_buffer,
					  nil);
  
   if(256 < result) then
		full_path_buffer = ffi.new("char[" .. result .. "]")
		ffi.fill(full_path_buffer,result,0) 
		result = kernel32.GetFullPathNameA(file_name,
					  result,
					  full_path_buffer,
					  nil);

   end

   return ffi.string(full_path_buffer)   

end



function GetOpenFileNameA(file_info)
  local title = file_info.title
  local buf_size = 1024
  local file_name        = ffi.new("char[" .. buf_size .. "]")
  local ret_val
  local file_list = {}
  file_list.path = ""
  file_list.files = {}
  file_dialog = ffi.new("OPENFILENAMEA")
  ffi.fill(file_dialog,ffi.sizeof(file_dialog),0) 
  file_dialog.lStructSize = ffi.sizeof(file_dialog)
  file_dialog.hwndOwner = file_info.hwnd
  file_dialog.lpstrFile = file_name
  file_dialog.nMaxFile = buf_size
  file_dialog.lpstrTitle = ffi.new("char[" .. #title+1 .."]" ,title .. "\0")
  file_dialog.nMaxFileTitle = 0
  file_dialog.lpstrInitialDir = nil
  if(true == file_info.multiselect) then
     file_dialog.Flags = bit.bor(OFN_EXPLORER,OFN_ALLOWMULTISELECT,OFN_ENABLEHOOK)	
  end
  file_dialog.lpfnHook = function(hwnd,msg,wparam,lparam)
	 if(winapi.WM_NOTIFY == msg) then
	    local notify_msg = ffi.cast("LPOFNOTIFY",lparam)
        if(CDN_SELCHANGE == notify_msg.hdr.code) then
	
		   parent = GetParent(hwnd)
		   
		   length = GetFolderPathSize(parent,nil,nil) +
		            GetMultiSelectSize(parent,nil,nil)
					
		   if (length > file_dialog.nMaxFile) then
		     
		     file_dialog.nMaxFile = length + 1
			 file_dialog.lpstrFile = ffi.new("char[" .. length .. "]")
			 
		   end
		end
	 end
	 return 0
  end
  

  comdlg.GetOpenFileNameA(file_dialog)
  first_file_name = file_dialog.lpstrFile

  
  str_len = #ffi.string(first_file_name)
 
  full_path = GetFullPathName(first_file_name)
   
  file_name = first_file_name + str_len + 1
 
  --If there is only one file selected, add the file to the
  --list, and return it.  Else, there is more than one file,
  --and we should enter the while loop below.  The first
  --file is actually a directory name when there is more than one file.
  lua_file_name = ffi.string(file_name)
  if(0 == #lua_file_name) then
    file_list.path = full_path:sub(0,file_dialog.nFileOffset)
    table.insert(file_list.files,lua_file_name) 
	return file_list
  end
  file_list.path = first_file_name
  while(true) do
      lua_file_name = ffi.string(file_name)
	  str_len = #lua_file_name
	  if(0 == str_len) then
		 break
	  else
	   table.insert(file_list.files,lua_file_name)
	   file_name = file_name + str_len + 1
	  end
  end
  
  return file_list
end

function GetSaveFileNameA(file_info)
  local buf_size = 1024
  local ret_val
  file_dialog = ffi.new("OPENFILENAMEA")
  ffi.fill(file_dialog,ffi.sizeof(file_dialog),0) 
  file_dialog.lStructSize = ffi.sizeof(file_dialog)

  if(nil == file_info) then
    file_dialog.lpstrFile = ffi.new("char[" .. buf_size .. "]","")
    file_dialog.lpstrTitle = ffi.new("char[" .. 1 .."]" ,"" .. "\0")
    file_dialog.hwndOwner = nil
  else
	if(nil ~= file_info.default_name) then
	  file_dialog.lpstrFile = ffi.new("char[" .. buf_size .. "]",file_info.default_name)
    end
	
	if(nil ~= file_info.title) then
	  file_dialog.lpstrTitle = ffi.new("char[" .. #file_info.title+1 .."]" ,file_info.title .. "\0")
    end
	if(nil ~= file_info.hwnd) then
  	  file_dialog.hwndOwner = file_info.hwnd
    end
  end  

  file_dialog.nMaxFile = buf_size
  file_dialog.nMaxFileTitle = 0
  file_dialog.lpstrInitialDir = nil  
  ret_val = comdlg.GetSaveFileNameA(file_dialog)

  if(0 ~= ret_val) then
     return GetFullPathName(file_dialog.lpstrFile)
  else
     return nil
  end
  
end


