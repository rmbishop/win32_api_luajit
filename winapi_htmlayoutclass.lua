--oo/edit: standard edit control.
global_space = require'winapi_init'
setfenv(1, global_space)

require'winapi_controlclass'
local ffi = require'ffi'

ffi.cdef[[
typedef unsigned int* HELEMENT;
void  HTMLayoutInit( HINSTANCE hModule, bool start);
typedef const BYTE *LPCBYTE;
 LPCSTR   HTMLayoutClassNameA();
 LPCWSTR  HTMLayoutClassNameW();
typedef LRESULT __stdcall HTMLAYOUT_NOTIFY(UINT uMsg, WPARAM wParam, LPARAM lParam, LPVOID vParam);
typedef HTMLAYOUT_NOTIFY* LPHTMLAYOUT_NOTIFY;

typedef struct tagNMHL_CREATE_CONTROL
{
    NMHDR     hdr;              
    HELEMENT  helement;         
    HWND      inHwndParent;     
    HWND      outControlHwnd;   
    DWORD     reserved1;
    DWORD     reserved2;

} NMHL_CREATE_CONTROL,  *LPNMHL_CREATE_CONTROL;

typedef struct tagNMHL_DESTROY_CONTROL
{
    NMHDR     hdr;              
    HELEMENT  helement; 
    HWND      inoutControlHwnd; 
    DWORD     reserved1;

} NMHL_DESTROY_CONTROL,  *LPNMHL_DESTROY_CONTROL;
typedef struct tagNMHL_LOAD_DATA
{
    NMHDR    hdr;              
    LPCWSTR  uri;              
    LPVOID   outData;          
    DWORD    outDataSize;      
    UINT     dataType;         
    HELEMENT principal;        
    HELEMENT initiator;        
} NMHL_LOAD_DATA,  *LPNMHL_LOAD_DATA;
typedef struct tagNMHL_DATA_LOADED
{
    NMHDR    hdr;              
    LPCWSTR  uri;              
    LPCBYTE  data;             
    DWORD    dataSize;         
    UINT     dataType;         
    UINT     status;                                            
} NMHL_DATA_LOADED,  *LPNMHL_DATA_LOADED;


typedef BOOL __stdcall ElementEventProc(LPVOID tag, HELEMENT he, UINT evtg, LPVOID prms );
typedef ElementEventProc* LPELEMENT_EVENT_PROC;
typedef struct tagNMHL_ATTACH_BEHAVIOR
{
    NMHDR    hdr;              
    HELEMENT element;          
    LPCSTR   behaviorName;     
    ElementEventProc* elementProc;    
    LPVOID            elementTag;
    UINT              elementEvents;  
} NMHL_ATTACH_BEHAVIOR,  *LPNMHL_ATTACH_BEHAVIOR;

typedef struct tagNMHL_BEHAVIOR_CHANGED
{
    NMHDR    hdr;              
    HELEMENT element;          
    LPCSTR   oldNames;         
    LPCSTR   newNames;         
} NMHL_BEHAVIOR_CHANGED,  *LPNMHL_BEHAVIOR_CHANGED;


typedef struct tagNMHL_DIALOG_CLOSE_RQ
{
    NMHDR   hdr;              
    BOOL    outCancel;        
} NMHL_DIALOG_CLOSE_RQ,  *LPNMHL_DIALOG_CLOSE_RQ;

typedef struct
{
  UINT   t;
  UINT   u;
  UINT64 d;
} VALUE;

 BOOL  HTMLayoutDataReady(HWND hwnd,LPCWSTR uri,LPBYTE data, DWORD dataLength);

 BOOL  HTMLayoutDataReadyAsync(HWND hwnd,LPCWSTR uri,LPBYTE data, DWORD dataLength, UINT dataType /*HTMLayoutResourceType*/ );
 LRESULT __stdcall HTMLayoutProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam);
 LRESULT __stdcall HTMLayoutProcW(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam);
 LRESULT  HTMLayoutProcND(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam, BOOL* pbHandled);
typedef BOOL __stdcall HTMLAYOUT___stdcall_RES(LPCWSTR resourceUri, LPCSTR resourceType, LPCBYTE imageData, DWORD imageDataSize);
typedef BOOL __stdcall HTMLAYOUT___stdcall_RES_EX(LPCWSTR resourceUri, LPCSTR resourceType, LPCBYTE imageData, DWORD imageDataSize, LPVOID prm);
 UINT      HTMLayoutGetMinWidth(HWND hWndHTMLayout);
 UINT      HTMLayoutGetMinHeight(HWND hWndHTMLayout, UINT width);
 BOOL      HTMLayoutLoadFile(HWND hWndHTMLayout, LPCWSTR filename);
 BOOL      HTMLayoutLoadHtml(HWND hWndHTMLayout, LPCBYTE html, UINT htmlSize);
 BOOL      HTMLayoutLoadHtmlEx(HWND hWndHTMLayout, LPCBYTE html, UINT htmlSize, LPCWSTR baseUrl);
 void      HTMLayoutSetMode(HWND hWndHTMLayout, int HTMLayoutMode);
 void      HTMLayoutSet__stdcall(HWND hWndHTMLayout, LPHTMLAYOUT_NOTIFY cb, LPVOID cbParam);
 BOOL      HTMLayoutSelectionExist(HWND hWndHTMLayout);
 LPCBYTE   HTMLayoutGetSelectedHTML(HWND hWndHTMLayout, unsigned int * pSize);
 BOOL      HTMLayoutClipboardCopy(HWND hWndHTMLayout);
 UINT      HTMLayoutEnumResources(HWND hWndHTMLayout,HTMLAYOUT___stdcall_RES* cb);
 UINT      HTMLayoutEnumResourcesEx(HWND hWndHTMLayout,HTMLAYOUT___stdcall_RES_EX* cb, LPVOID cbPrm);
 BOOL      HTMLayoutSetMasterCSS(LPCBYTE utf8, UINT numBytes);
 BOOL      HTMLayoutAppendMasterCSS(LPCBYTE utf8, UINT numBytes);
typedef void __stdcall   HTMLAYOUT_DATA_WRITER(LPCWSTR uri, UINT dataType, LPCBYTE data, UINT dataLength);
typedef BOOL __stdcall   HTMLAYOUT_DATA_LOADER(LPCWSTR uri, UINT dataType, HTMLAYOUT_DATA_WRITER* pDataWriter);
 BOOL      HTMLayoutSetDataLoader(HTMLAYOUT_DATA_LOADER* pDataLoader);
 BOOL      HTMLayoutDeclareElementType(LPCSTR name, UINT/*ELEMENT_MODEL*/ elementModel);
 BOOL      HTMLayoutSetCSS(HWND hWndHTMLayout, LPCBYTE utf8, UINT numBytes, LPCWSTR baseUrl, LPCWSTR mediaType);
 BOOL      HTMLayoutSetMediaType(HWND hWndHTMLayout, LPCWSTR mediaType);
 BOOL      HTMLayoutSetMediaVars(HWND hWndHTMLayout, const VALUE *mediaVars);
 BOOL      HTMLayoutSetHttpHeaders(HWND hWndHTMLayout, LPCSTR httpHeaders, UINT httpHeadersLength );
 BOOL      HTMLayoutSetOption(HWND hWndHTMLayout, UINT option, UINT value );
 BOOL      HTMLayoutRender(HWND hWndHTMLayout, HBITMAP hBmp, RECT area );
 BOOL      HTMLayoutUpdateWindow(HWND hWndHTMLayout );
 BOOL      HTMLayoutCommitUpdates(HWND hWndHTMLayout);
 BOOL      HTMLayoutTranslateMessage(MSG* lpMsg);



 UINT  HTMLayoutUrlEscape( LPCWSTR text, BOOL spaceToPlus, LPSTR buffer, UINT bufferLength );
 UINT  HTMLayoutUrlUnescape( LPCSTR url, LPWSTR buffer, UINT bufferLength );
 INT_PTR  HTMLayoutDialog(
                HWND                  hWndParent, 
                POINT                 position, 
                INT                   alignment, 
                UINT                  style, 
                UINT                  styleEx,
                LPHTMLAYOUT_NOTIFY    notification__stdcall,
                LPELEMENT_EVENT_PROC  events__stdcall,
                LPVOID                __stdcallParam,
                LPCBYTE               html,
                UINT                  htmlLength);
				
typedef void (__stdcall* DEBUG_OUTPUT_PROC)(LPVOID param, INT character);
 void  HTMLayoutSetupDebugOutput(
                LPVOID                param,    
                DEBUG_OUTPUT_PROC     pfOutput  
                );

unsigned int wcstombs (char* dest, const wchar_t* src, size_t max);				
typedef int HLDOM_RESULT;				
HLDOM_RESULT HTMLayoutGetElementType(HELEMENT he, LPCSTR* p_type);
HLDOM_RESULT HTMLayoutGetAttributeByName(HELEMENT he, LPCSTR name, LPCWSTR* p_value);
			

typedef struct MOUSE_PARAMS
{
  UINT      cmd;          // MOUSE_EVENTS
  HELEMENT  target;       // target element
  POINT     pos;          // position of cursor, element relative
  POINT     pos_document; // position of cursor, document root relative
  UINT      button_state; // MOUSE_BUTTONS or MOUSE_WHEEL_DELTA
  UINT      alt_state;    // KEYBOARD_STATES 
  UINT      cursor_type;  // CURSOR_TYPE to set, see CURSOR_TYPE
  BOOL      is_on_icon;   // mouse is over icon (foreground-image, foreground-repeat:no-repeat)
  
  HELEMENT  dragging;     // element that is being dragged over, this field is not NULL if (cmd & DRAGGING) != 0
  UINT      dragging_mode;// see DRAGGING_TYPE. 
}MOUSE_PARAMS;

HLDOM_RESULT HTMLayoutAttachEventHandlerEx( HELEMENT he, LPELEMENT_EVENT_PROC pep, LPVOID tag, UINT subscription );	

typedef struct KEY_PARAMS
{
  UINT      cmd;          // KEY_EVENTS
  HELEMENT  target;       // target element
  UINT      key_code;     // key scan code, or character unicode for KEY_CHAR
  UINT      alt_state;    // KEYBOARD_STATES   
}KEY_PARAMS;

			
]]



HTMLayout_C = ffi.load("htmlayout")


HLN_CREATE_CONTROL    = 0xAFF + 0x01
HLN_LOAD_DATA         = 0xAFF + 0x02
HLN_CONTROL_CREATED   = 0xAFF + 0x03
HLN_DATA_LOADED       = 0xAFF + 0x04 
HLN_DOCUMENT_COMPLETE = 0xAFF + 0x05 
HLN_UPDATE_UI         = 0xAFF + 0x06
HLN_DESTROY_CONTROL   = 0xAFF + 0x07
HLN_ATTACH_BEHAVIOR   = 0xAFF + 0x08
HLN_BEHAVIOR_CHANGED  = 0xAFF + 0x09
HLN_DIALOG_CREATED    = 0xAFF + 0x10
HLN_DIALOG_CLOSE_RQ   = 0xAFF + 0x0A
HLN_DOCUMENT_LOADED   = 0xAFF + 0x0B 

HTMLayout = subclass({

	__wm_notify_handler_names = {
		on_create_control = HLN_CREATE_CONTROL,
		on_load_data = HLN_LOAD_DATA,
		on_control_created = HLN_CONTROL_CREATED,
		on_data_loaded = HLN_DATA_LOADED,
		on_hln_document_complete = HLN_DOCUMENT_COMPLETE,
		on_update_ui =	HLN_UPDATE_UI, 	
		on_destroy_control = HLN_DESTROY_CONTROL,
		on_attach_behavior =	HLN_ATTACH_BEHAVIOR,	
		on_behavior_changed = HLN_BEHAVIOR_CHANGED,
		on_dialog_created =	HLN_DIALOG_CREATED, 	
		on_dialog_close_rq = HLN_DIALOG_CLOSE_RQ,
		on_document_loaded =	HLN_DOCUMENT_LOADED 	
		},		
		
	__defaults = {
		text = '',
		w = -1, h = -1,
		readonly = false,
		client_edge = true,
		

	},		
}, Control)

function HTMLayout:__before_create(info, args)
	HTMLayout.__index.__before_create(self, info, args)
	args.class = "HTMLAYOUT"
end

function WM_NOTIFY_DECODERS.HLN_LOAD_DATA(hdr) 
end

function WM_NOTIFY_DECODERS.HLN_CONTROL_CREATED(hdr) 
end

function WM_NOTIFY_DECODERS.HLN_DATA_LOADED(hdr) 
end

function WM_NOTIFY_DECODERS.HLN_DOCUMENT_COMPLETE(hdr) 
end


--From htmlayout_behavior.h
HANDLE_INITIALIZATION = 0x0000    
HANDLE_MOUSE = 0x0001              
HANDLE_KEY = 0x0002                
HANDLE_FOCUS = 0x0004              
HANDLE_SCROLL = 0x0008             
HANDLE_TIMER = 0x0010              
HANDLE_SIZE = 0x0020               
HANDLE_DRAW = 0x0040               
HANDLE_DATA_ARRIVED = 0x080        
HANDLE_BEHAVIOR_EVENT = 0x0100     
HANDLE_METHOD_CALL = 0x0200        
HANDLE_EXCHANGE   = 0x1000         
HANDLE_GESTURE    = 0x2000               
HANDLE_ALL        = 0xFFFF         
DISABLE_INITIALIZATION = 0x80000000 


--Stubbed functions that the user can redefine in order to capture these events                                      								  

accesskeys = {}
hyperlink = {}


dispatcher = {}

function WM_NOTIFY_DECODERS.HLN_ATTACH_BEHAVIOR(hdr) 
	local t = ffi.cast('NMHL_ATTACH_BEHAVIOR*', hdr)
	local behavior_name = ffi.string(t.behaviorName) 

	local params
	if(nil == dispatcher[behavior_name]) then
		dispatcher[behavior_name] = {}
	end	
	if(nil ~= global_space[behavior_name].on_key) then
		dispatcher[behavior_name].on_key = function(tag, he, evtg, prms )
		   params = ffi.cast('KEY_PARAMS *',prms)
		   global_space[behavior_name].on_key({cmd = params.cmd, key_code = params.key_code, alt_state = params.alt_state})
		   return 0
		end
		HTMLayout_C.HTMLayoutAttachEventHandlerEx(t.element, dispatcher[behavior_name].on_key,t.elementTag,HANDLE_KEY)
	end	
end


    
                                          
          





update(WM_NOTIFY_NAMES, constants{
	HLN_CREATE_CONTROL    = 0xAFF + 0x01,
	HLN_LOAD_DATA         = 0xAFF + 0x02,
	HLN_CONTROL_CREATED   = 0xAFF + 0x03,
	HLN_DATA_LOADED       = 0xAFF + 0x04,
	HLN_DOCUMENT_COMPLETE = 0xAFF + 0x05,
	HLN_UPDATE_UI         = 0xAFF + 0x06,
	HLN_DESTROY_CONTROL   = 0xAFF + 0x07,
	HLN_ATTACH_BEHAVIOR   = 0xAFF + 0x08,
	HLN_BEHAVIOR_CHANGED  = 0xAFF + 0x09,
	HLN_DIALOG_CREATED    = 0xAFF + 0x10,
	HLN_DIALOG_CLOSE_RQ   = 0xAFF + 0x0A,
	HLN_DOCUMENT_LOADED   = 0xAFF + 0x0B 
})


function HTMLayout:ClassNameA() return HTMLayout_C.HTMLayoutClassNameA() end

function HTMLayout:LoadHtml(html_text) 
	HTMLayout_C.HTMLayoutLoadHtml(self.hwnd,html_text,html_text:len())
end

