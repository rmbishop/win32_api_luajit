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
 BOOL      HTMLayoutSetCSS(HWND hWndHTMLayout, LPCBYTE utf8, UINT numBytes);
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

typedef struct FOCUS_PARAMS
{
  UINT      cmd;            // FOCUS_EVENTS
  HELEMENT  target;         // target element, for FOCUS_LOST it is a handle of new focus element
							// and for FOCUS_GOT it is a handle of old focus element, can be NULL
  BOOL      by_mouse_click; // TRUE if focus is being set by mouse click
  BOOL      cancel;         // in FOCUS_LOST phase setting this field to TRUE will cancel transfer focus from old element to the new one.
}FOCUS_PARAMS;

typedef struct SCROLL_PARAMS
{
  UINT      cmd;          // SCROLL_EVENTS
  HELEMENT  target;       // target element
  INT       pos;          // scroll position if SCROLL_POS
  BOOL      vertical;     // TRUE if from vertical scrollbar
}SCROLL_PARAMS;
		
typedef struct TIMER_PARAMS
{
  UINT_PTR timerId;    // timerId that was used to create timer by using HTMLayoutSetTimerEx
}TIMER_PARAMS;		



typedef struct DRAW_PARAMS
{
  UINT      cmd;          
  HDC       hdc;          
  RECT      area;          
  UINT      reserved;     
						  
}DRAW_PARAMS;
	

typedef struct BEHAVIOR_EVENT_PARAMS
{
  UINT     cmd;        
  HELEMENT heTarget;   
  HELEMENT source_element;        
  UINT     reason;     			   
  LPVOID data;       
}BEHAVIOR_EVENT_PARAMS;

typedef struct DATA_ARRIVED_PARAMS
{
  HELEMENT  initiator;     
  LPCBYTE   data;         
  UINT      dataSize;     
  UINT      dataType;     
  UINT      status;       						 					  
  LPCWSTR   uri;          
}DATA_ARRIVED_PARAMS;

typedef BOOL FETCH_EXCHANGE_DATA(LPVOID params, UINT data_type, LPCBYTE* ppDataStart, UINT* pDataLength );


typedef struct EXCHANGE_PARAMS
{
	UINT      cmd;          
	HELEMENT  target;       
	POINT     pos;          
	POINT     pos_view;     
	UINT      data_types;   
	UINT      drag_cmd;     
	FETCH_EXCHANGE_DATA* fetch_data;		     
}EXCHANGE_PARAMS;

struct html_events
{
  enum
  {
	  HANDLE_INITIALIZATION = 0x0000,     
	  HANDLE_MOUSE = 0x0001,              
	  HANDLE_KEY = 0x0002,                
	  HANDLE_FOCUS = 0x0004,              
	  HANDLE_SCROLL = 0x0008,             
	  HANDLE_TIMER = 0x0010,              
	  HANDLE_SIZE = 0x0020,               
	  HANDLE_DRAW = 0x0040,               
	  HANDLE_DATA_ARRIVED = 0x080,        
	  HANDLE_BEHAVIOR_EVENT = 0x0100,     
										  
										  
	  HANDLE_METHOD_CALL = 0x0200,        

	  HANDLE_EXCHANGE   = 0x1000,         
	  HANDLE_GESTURE    = 0x2000,         
	  
	  HANDLE_ALL        = 0xFFFF,         

	  DISABLE_INITIALIZATION = 0x80000000 
  };


  enum
  {
	  BUBBLING = 0,        
	  SINKING  = 0x08000,  
	  HANDLED  = 0x10000   
	  
  };

  enum
  {
	  MAIN_MOUSE_BUTTON = 0x01, 
	  PROP_MOUSE_BUTTON = 0x02, 
	  MIDDLE_MOUSE_BUTTON = 0x04,
	  X1_MOUSE_BUTTON = 0x08,
	  X2_MOUSE_BUTTON = 0x10,
  };

  enum
  {
	  CONTROL_KEY_PRESSED = 0x1,
	  SHIFT_KEY_PRESSED = 0x2,
	  ALT_KEY_PRESSED = 0x4
  };


  enum
  {
	BEHAVIOR_DETACH = 0,
	BEHAVIOR_ATTACH = 1
  };


  enum
  {
	NO_DRAGGING,
	DRAGGING_MOVE,
	DRAGGING_COPY,
  };

  enum
  {
	  MOUSE_ENTER = 0,
	  MOUSE_LEAVE = 1,
	  MOUSE_MOVE  = 2,
	  MOUSE_UP    = 3,
	  MOUSE_DOWN  = 4,
	  MOUSE_DCLICK = 5,
	  MOUSE_WHEEL = 6, 
	  MOUSE_TICK  = 7, 
	  MOUSE_IDLE  = 8, 

	  DROP        = 9,   
	  DRAG_ENTER  = 0xA, 
	  DRAG_LEAVE  = 0xB, 
	  DRAG_REQUEST = 0xC,  

	  MOUSE_CLICK = 0xFF, 

	  DRAGGING = 0x100, 
						
  };


  enum
  {
	  CURSOR_ARROW, 
	  CURSOR_IBEAM, 
	  CURSOR_WAIT,  
	  CURSOR_CROSS, 
	  CURSOR_UPARROW,  
	  CURSOR_SIZENWSE, 
	  CURSOR_SIZENESW, 
	  CURSOR_SIZEWE,   
	  CURSOR_SIZENS,   
	  CURSOR_SIZEALL,  
	  CURSOR_NO,       
	  CURSOR_APPSTARTING, 
	  CURSOR_HELP,        
	  CURSOR_HAND,        
	  CURSOR_DRAG_MOVE,   
	  CURSOR_DRAG_COPY,   
  };

  enum
  {
	  KEY_DOWN = 0,
	  KEY_UP,
	  KEY_CHAR
  };

  enum
  {
	  FOCUS_LOST = 0,
	  FOCUS_GOT = 1,
  };

  enum
  {
	  BY_CODE,
	  BY_MOUSE,
	  BY_KEY_NEXT,
	  BY_KEY_PREV
  };

  enum
  {
	  SCROLL_HOME = 0,
	  SCROLL_END,
	  SCROLL_STEP_PLUS,
	  SCROLL_STEP_MINUS,
	  SCROLL_PAGE_PLUS,
	  SCROLL_PAGE_MINUS,
	  SCROLL_POS,
	  SCROLL_SLIDER_RELEASED
  };


  enum
  {
	GESTURE_REQUEST = 0, 
	GESTURE_ZOOM,        
	GESTURE_PAN,         
	GESTURE_ROTATE,      
	GESTURE_TAP1,        
	GESTURE_TAP2,        
  };
  enum
  {
	GESTURE_STATE_BEGIN   = 1, 
	GESTURE_STATE_INERTIA = 2, 
	GESTURE_STATE_END     = 4, 
  };

  enum
  {
	GESTURE_FLAG_ZOOM               = 0x0001,
	GESTURE_FLAG_ROTATE             = 0x0002,
	GESTURE_FLAG_PAN_VERTICAL       = 0x0004,
	GESTURE_FLAG_PAN_HORIZONTAL     = 0x0008,
	GESTURE_FLAG_TAP1               = 0x0010, 
	GESTURE_FLAG_TAP2               = 0x0020, 

	GESTURE_FLAG_PAN_WITH_GUTTER    = 0x4000, 
	GESTURE_FLAG_PAN_WITH_INERTIA   = 0x8000, 
	GESTURE_FLAGS_ALL               = 0xFFFF, 
  };

  enum
  {
	  DRAW_BACKGROUND = 0,
	  DRAW_CONTENT = 1,
	  DRAW_FOREGROUND = 2,
  };

  enum
  {
	X_DRAG_ENTER,
	X_DRAG_LEAVE,
	X_DRAG,
	X_DROP,
  };

  enum
  {
	EXF_UNDEFINED   = 0,
	EXF_TEXT        = 0x01, 
	EXF_HTML        = 0x02, 
	EXF_HYPERLINK   = 0x04, 
	EXF_JSON        = 0x08, 
	EXF_FILE        = 0x10, 
  };
  enum
  {
	EXC_NONE = 0,
	EXC_COPY = 1,
	EXC_MOVE = 2,
	EXC_LINK = 4,
  };

  enum
  {
	  BUTTON_CLICK = 0,              
	  BUTTON_PRESS = 1,              
	  BUTTON_STATE_CHANGED = 2,      
	  EDIT_VALUE_CHANGING = 3,       
	  EDIT_VALUE_CHANGED = 4,        
	  SELECT_SELECTION_CHANGED = 5,  
	  SELECT_STATE_CHANGED = 6,      
	  POPUP_REQUEST   = 7,           
	  POPUP_READY     = 8,           
	  POPUP_DISMISSED = 9,           
	  MENU_ITEM_ACTIVE = 0xA,        
	  MENU_ITEM_CLICK = 0xB,         
	  CONTEXT_MENU_SETUP   = 0xF,    
	  CONTEXT_MENU_REQUEST = 0x10,   
	  VISIUAL_STATUS_CHANGED = 0x11, 
	  DISABLED_STATUS_CHANGED = 0x12,
	  POPUP_DISMISSING = 0x13,       
	  HYPERLINK_CLICK = 0x80,        
	  TABLE_HEADER_CLICK,            
	  TABLE_ROW_CLICK,               
	  TABLE_ROW_DBL_CLICK,           
	  ELEMENT_COLLAPSED = 0x90,      
	  ELEMENT_EXPANDED,              
	  ACTIVATE_CHILD,                
	  DO_SWITCH_TAB = ACTIVATE_CHILD,
	  INIT_DATA_VIEW,                	  
	  ROWS_DATA_REQUEST,             
	  UI_STATE_CHANGED,              
	  FORM_SUBMIT,                   
	  FORM_RESET,                    
	  DOCUMENT_COMPLETE,             
	  HISTORY_PUSH,                  
	  HISTORY_DROP,                     
	  HISTORY_PRIOR,
	  HISTORY_NEXT,
	  HISTORY_STATE_CHANGED,         
	  CLOSE_POPUP,                   
	  REQUEST_TOOLTIP,               
	  ANIMATION         = 0xA0,      
	  FIRST_APPLICATION_EVENT_CODE = 0x100 
  };

  enum
  {
	  BY_MOUSE_CLICK = 0,  
	  BY_KEY_CLICK = 1, 
	  SYNTHESIZED = 2, 
  };

  enum
  {
	  BY_INS_CHAR = 3,  
	  BY_INS_CHARS, 
	  BY_DEL_CHAR,  
	  BY_DEL_CHARS, 
  };
  
	enum 
	{
	   STATE_LINK             = 0x00000001,
	   STATE_HOVER            = 0x00000002,
	   STATE_ACTIVE           = 0x00000004,
	   STATE_FOCUS            = 0x00000008,
	   STATE_VISITED          = 0x00000010,
	   STATE_CURRENT          = 0x00000020,  
	   STATE_CHECKED          = 0x00000040,  
	   STATE_DISABLED         = 0x00000080,  
	   STATE_READONLY         = 0x00000100,  
	   STATE_EXPANDED         = 0x00000200,  
	   STATE_COLLAPSED        = 0x00000400,  
	   STATE_INCOMPLETE       = 0x00000800,  
	   STATE_ANIMATING        = 0x00001000,  
	   STATE_FOCUSABLE        = 0x00002000,  
	   STATE_ANCHOR           = 0x00004000,  
	   STATE_SYNTHETIC        = 0x00008000,  
	   STATE_OWNS_POPUP       = 0x00010000,  
	   STATE_TABFOCUS         = 0x00020000,  
	   STATE_EMPTY            = 0x00040000,  
											 
	   STATE_BUSY             = 0x00080000,  
	   
	   STATE_DRAG_OVER        = 0x00100000,  
	   STATE_DROP_TARGET      = 0x00200000,  
	   STATE_MOVING           = 0x00400000,  
	   STATE_COPYING          = 0x00800000,  
	   STATE_DRAG_SOURCE      = 0x01000000,  
	   STATE_DROP_MARKER      = 0x02000000,  
	   
	   STATE_PRESSED          = 0x04000000,  
											 
	   STATE_POPUP            = 0x08000000,  
	   STATE_IS_LTR           = 0x10000000,  
	   STATE_IS_RTL           = 0x20000000,  

	};  
	  
  
};

typedef int * LPUINT;
typedef int HLDOM_RESULT;
typedef LPVOID HRANGE;
typedef struct hposition { HELEMENT he; INT pos; } HPOSITION;
HLDOM_RESULT  HTMLayout_UseElement(HELEMENT he);
HLDOM_RESULT  HTMLayout_UnuseElement(HELEMENT he);
HLDOM_RESULT  HTMLayoutGetRootElement(HWND hwnd, HELEMENT *phe);
HLDOM_RESULT  HTMLayoutGetFocusElement(HWND hwnd, HELEMENT *phe);
HLDOM_RESULT  HTMLayoutFindElement(HWND hwnd, POINT pt, HELEMENT* phe);
HLDOM_RESULT  HTMLayoutGetChildrenCount(HELEMENT he, UINT* count);
HLDOM_RESULT  HTMLayoutGetNthChild(HELEMENT he, UINT n, HELEMENT* phe);
HLDOM_RESULT  HTMLayoutGetParentElement(HELEMENT he, HELEMENT* p_parent_he);
HLDOM_RESULT  HTMLayoutGetElementText(HELEMENT he, LPWSTR characters, LPUINT length);
HLDOM_RESULT  HTMLayoutGetElementHtml(HELEMENT he, LPBYTE* utf8bytes, BOOL outer);
typedef void  HTMLayoutWriterCallbackB( LPCBYTE utf8, UINT utf8_length, LPVOID param );
HLDOM_RESULT  HTMLayoutGetElementHtmlCB(HELEMENT he, BOOL outer, void* cb, void* cb_param);
HLDOM_RESULT  HTMLayoutGetElementInnerText(HELEMENT he, LPBYTE* utf8bytes);
HLDOM_RESULT  HTMLayoutSetElementInnerText(HELEMENT he, LPCBYTE utf8bytes, UINT length);
HLDOM_RESULT  HTMLayoutGetElementInnerText16(HELEMENT he, LPWSTR* utf16words);
typedef void  HTMLayoutWriterCallbackW( LPCWSTR text, UINT text_length, LPVOID param );
HLDOM_RESULT  HTMLayoutGetElementInnerTextCB(HELEMENT he, void* cb, void* cb_param);
HLDOM_RESULT  HTMLayoutSetElementInnerText16(HELEMENT he, LPCWSTR utf16words, UINT length);
HLDOM_RESULT  HTMLayoutGetAttributeCount(HELEMENT he, LPUINT p_count);
HLDOM_RESULT  HTMLayoutGetNthAttribute(HELEMENT he, UINT n, LPCSTR* p_name, LPCWSTR* p_value);
HLDOM_RESULT  HTMLayoutGetAttributeByName(HELEMENT he, LPCSTR name, LPCWSTR* p_value);
HLDOM_RESULT  HTMLayoutSetAttributeByName(HELEMENT he, LPCSTR name, LPCWSTR value);
HLDOM_RESULT  HTMLayoutClearAttributes(HELEMENT he);
HLDOM_RESULT  HTMLayoutGetElementIndex(HELEMENT he, LPUINT p_index);
HLDOM_RESULT  HTMLayoutGetElementType(HELEMENT he, LPCSTR* p_type);
HLDOM_RESULT  HTMLayoutGetStyleAttribute(HELEMENT he, LPCSTR name, LPCWSTR* p_value);
HLDOM_RESULT  HTMLayoutSetStyleAttribute(HELEMENT he, LPCSTR name, LPCWSTR value);
HLDOM_RESULT  HTMLayoutGetElementLocation(HELEMENT he, LPRECT p_location, UINT areas );
HLDOM_RESULT  HTMLayoutScrollToView(HELEMENT he, UINT flags);
HLDOM_RESULT  HTMLayoutUpdateElement(HELEMENT he, BOOL remeasure);
HLDOM_RESULT  HTMLayoutUpdateElementEx(HELEMENT he, UINT flags);
HLDOM_RESULT  HTMLayoutSetCapture(HELEMENT he);
HLDOM_RESULT  HTMLayoutSetEventRoot(HELEMENT he, HELEMENT *phePrevRoot);
HLDOM_RESULT  HTMLayoutGetElementHwnd(HELEMENT he, HWND* p_hwnd, BOOL rootWindow);
HLDOM_RESULT  HTMLayoutCombineURL(HELEMENT he, LPWSTR szUrlBuffer, DWORD UrlBufferSize);
typedef BOOL  __stdcall HTMLayoutElementCallback( HELEMENT he, LPVOID param );
HLDOM_RESULT  HTMLayoutVisitElements(HELEMENT  he, 
	LPCSTR    tagName,
	LPCSTR    attributeName, 
	LPCWSTR   attributeValue, 
	HTMLayoutElementCallback* 
	callback, 
	LPVOID    param,
	DWORD     depth);
HLDOM_RESULT  HTMLayoutSelectElements(
	HELEMENT  he, 
	LPCSTR    CSS_selectors,
	HTMLayoutElementCallback* callback, 
	LPVOID    param);
HLDOM_RESULT  HTMLayoutSelectElementsW(
	HELEMENT  he, 
	LPCWSTR   CSS_selectors,
	HTMLayoutElementCallback* 
	callback, 
	LPVOID    param);
HLDOM_RESULT  HTMLayoutSelectParent(
	HELEMENT  he, 
	LPCSTR    selector,
	UINT      depth,
	HELEMENT* heFound);
HLDOM_RESULT  HTMLayoutSelectParentW(
	HELEMENT  he, 
	LPCWSTR   selector,
	UINT      depth,
	HELEMENT* heFound);
HLDOM_RESULT  HTMLayoutSetElementHtml(HELEMENT he, LPCBYTE html, DWORD htmlLength, UINT where);
HLDOM_RESULT  HTMLayoutDeleteElement(HELEMENT he);
HLDOM_RESULT  HTMLayoutGetElementUID(HELEMENT he, UINT* puid);
HLDOM_RESULT  HTMLayoutGetElementByUID(HWND hwnd, UINT uid, HELEMENT* phe);
HLDOM_RESULT  HTMLayoutShowPopup(HELEMENT hePopup, HELEMENT heAnchor, UINT placement);
HLDOM_RESULT  HTMLayoutShowPopupAt(HELEMENT hePopup, POINT pos, UINT mode);
HLDOM_RESULT  HTMLayoutTrackPopupAt(HELEMENT hePopup, POINT posRoot, UINT mode, HELEMENT* pheItem);
HLDOM_RESULT  HTMLayoutHidePopup(HELEMENT he);
typedef BOOL  ElementEventProc(LPVOID tag, HELEMENT he, UINT evtg, LPVOID prms );
typedef ElementEventProc* LPELEMENT_EVENT_PROC;
HLDOM_RESULT  HTMLayoutGetElementState( HELEMENT he, UINT* pstateBits);
HLDOM_RESULT  HTMLayoutSetElementState( HELEMENT he, UINT stateBitsToSet, UINT stateBitsToClear, BOOL updateView);
HLDOM_RESULT  HTMLayoutCreateElement( LPCSTR tagname, LPCWSTR textOrNull,  HELEMENT *phe );
HLDOM_RESULT  HTMLayoutCloneElement( HELEMENT he,  HELEMENT *phe );
HLDOM_RESULT  HTMLayoutInsertElement( HELEMENT he, HELEMENT hparent, UINT index );
HLDOM_RESULT  HTMLayoutDetachElement( HELEMENT he );
HLDOM_RESULT  HTMLayoutSetTimer( HELEMENT he, UINT milliseconds );
HLDOM_RESULT  HTMLayoutSetTimerEx( HELEMENT he, UINT milliseconds, UINT_PTR timerId );
HLDOM_RESULT  HTMLayoutAttachEventHandler( HELEMENT he, LPELEMENT_EVENT_PROC pep, LPVOID tag );
HLDOM_RESULT  HTMLayoutDetachEventHandler( HELEMENT he, LPELEMENT_EVENT_PROC pep, LPVOID tag );
HLDOM_RESULT  HTMLayoutAttachEventHandlerEx( HELEMENT he, LPELEMENT_EVENT_PROC pep, LPVOID tag, UINT subscription );
HLDOM_RESULT  HTMLayoutWindowAttachEventHandler( HWND hwndLayout, LPELEMENT_EVENT_PROC pep, LPVOID tag, UINT subscription );
HLDOM_RESULT  HTMLayoutWindowDetachEventHandler( HWND hwndLayout, LPELEMENT_EVENT_PROC pep, LPVOID tag );
HLDOM_RESULT  HTMLayoutSendEvent(HELEMENT he, UINT appEventCode, HELEMENT heSource, UINT_PTR reason,  BOOL* handled);
HLDOM_RESULT  HTMLayoutPostEvent(HELEMENT he, UINT appEventCode, HELEMENT heSource, UINT reason);
typedef struct _METHOD_PARAMS METHOD_PARAMS;
HLDOM_RESULT  HTMLayoutCallBehaviorMethod(HELEMENT he, METHOD_PARAMS* params);
HLDOM_RESULT  HTMLayoutRequestElementData(HELEMENT he, LPCWSTR url, UINT dataType, HELEMENT initiator );
enum REQUEST_TYPE
{
GET_ASYNC,  
POST_ASYNC, 
};
typedef struct { LPCWSTR name; LPCWSTR value; } REQUEST_PARAM;

	HLDOM_RESULT  HTMLayoutHttpRequest( 
	HELEMENT        he,            
	LPCWSTR         url,          
	UINT            dataType,     
	UINT            requestType,  
	REQUEST_PARAM*  requestParams,
	UINT            nParams      
);
HLDOM_RESULT  HTMLayoutGetScrollInfo( HELEMENT he, LPPOINT scrollPos, LPRECT viewRect, LPSIZE contentSize );
HLDOM_RESULT  HTMLayoutSetScrollPos( HELEMENT he, POINT scrollPos, BOOL smooth );
HLDOM_RESULT  HTMLayoutGetElementIntrinsicWidths( HELEMENT he, INT* pMinWidth, INT* pMaxWidth );
HLDOM_RESULT  HTMLayoutGetElementIntrinsicHeight( HELEMENT he, INT forWidth, INT* pHeight );
HLDOM_RESULT  HTMLayoutIsElementVisible( HELEMENT he, BOOL* pVisible);
HLDOM_RESULT  HTMLayoutIsElementEnabled( HELEMENT he, BOOL* pEnabled );
typedef INT ELEMENT_COMPARATOR( HELEMENT he1, HELEMENT he2, LPVOID param );
HLDOM_RESULT  HTMLayoutSortElements( HELEMENT he, UINT firstIndex, UINT lastIndex, ELEMENT_COMPARATOR* cmpFunc, LPVOID cmpFuncParam );
HLDOM_RESULT  HTMLayoutSwapElements( HELEMENT he1, HELEMENT he2 );
HLDOM_RESULT  HTMLayoutTraverseUIEvent( UINT evt, LPVOID eventCtlStruct, LPBOOL bOutProcessed );
HLDOM_RESULT  HTMLayoutProcessUIEvent( HELEMENT he, UINT evt, LPVOID eventCtlStruct, LPBOOL bOutProcessed );
HLDOM_RESULT  HTMLayoutControlGetType( HELEMENT he,  UINT *pType );
HLDOM_RESULT  HTMLayoutControlGetValue( HELEMENT he, VALUE *pVal );
HLDOM_RESULT  HTMLayoutControlSetValue( HELEMENT he, const VALUE *pVal );
typedef BOOL  HTMLayoutEnumerationCallback( LPVOID p, HELEMENT he, int pos, int postype, WCHAR code );
HLDOM_RESULT  HTMLayoutEnumerate( HELEMENT he, HTMLayoutEnumerationCallback* pcb, LPVOID p, BOOL forward );
HLDOM_RESULT  HTMLayoutGetCharacterRect( HELEMENT he, int pos, RECT* outRect );
typedef struct 
{
	INT      rule_type;    
	LPCSTR   file_url;     
	INT      file_line_no; 
	LPCWSTR  selector;     
} HTMLayoutCSSRuleDef;
typedef void HTMLayoutStyleRuleCallback( HTMLayoutCSSRuleDef* pdef, LPVOID callback_prm );
HLDOM_RESULT  HTMLayoutEnumElementStyles( HELEMENT he, HTMLayoutStyleRuleCallback* callback, LPVOID callback_prm );
typedef struct _HTMLayoutElementExpando HTMLayoutElementExpando;
typedef void ExpandoRelease( HTMLayoutElementExpando* pexp, HELEMENT he );
struct _HTMLayoutElementExpando
{
	ExpandoRelease* finalizer; 
};
HLDOM_RESULT  HTMLayoutElementSetExpando( HELEMENT he, HTMLayoutElementExpando* pExpando );
HLDOM_RESULT  HTMLayoutElementGetExpando( HELEMENT he, HTMLayoutElementExpando** ppExpando );
HLDOM_RESULT  HTMLayoutMoveElement( HELEMENT he, INT xView, INT yView);
HLDOM_RESULT  HTMLayoutMoveElementEx( HELEMENT he, INT xView, INT yView,INT width, INT height);
typedef UINT  HTMLayoutElementAnimator( HELEMENT he, UINT step, LPVOID animatorParam );
HLDOM_RESULT  HTMLayoutAnimateElement( HELEMENT he, HTMLayoutElementAnimator* pAnimator, LPVOID animatorParam);
HLDOM_RESULT  HTMLayoutEnqueueMeasure( HELEMENT he);
UINT  HTMLayoutParseValue( LPCWSTR text, UINT textLength, UINT mode, VALUE *pVal );
HLDOM_RESULT  HTMLayoutRangeCreate( HELEMENT he, HRANGE* pRange, BOOL outer );
HLDOM_RESULT  HTMLayoutRangeFromSelection( HELEMENT he, HRANGE* pRange );
HLDOM_RESULT  HTMLayoutRangeFromPositions( HELEMENT he, HPOSITION* pStart, HPOSITION* pEnd );
HLDOM_RESULT  HTMLayoutRangeRelease( HRANGE range );
HLDOM_RESULT  HTMLayoutRangeAdvancePos( HRANGE range, UINT cmd, INT* c, HPOSITION* pPos );
HLDOM_RESULT  HTMLayoutRangeToHtml( HRANGE range, LPBYTE* pHtmlUtf8Bytes, UINT* numBytes );
HLDOM_RESULT  HTMLayoutRangeReplace( HRANGE range, LPBYTE htmlUtf8Bytes, UINT numBytes );
HLDOM_RESULT  HTMLayoutRangeInsertHtml( HPOSITION* pPos, LPBYTE htmlUtf8Bytes, UINT numBytes );
HLDOM_RESULT  HTMLayoutRangeIsEmpty( HRANGE range, BOOL* pResult );

int wcstombs (char* dest, const wchar_t* src, size_t max);
int mbtowc (wchar_t* pwc, const char* pmb, size_t max);

int clock(void);

]]



HTMLayout_C = ffi.load("htmlayout")
html_events = ffi.new('struct html_events')

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


--Stubbed behaviors that the user can redefine                                								  
accesskeys = {}
hyperlink = {}


dispatcher = {}

SIH_REPLACE_CONTENT     = 0 
SIH_INSERT_AT_START     = 1 
SIH_APPEND_AFTER_LAST   = 2 

SOH_REPLACE             = 3 
SOH_INSERT_BEFORE       = 4  
SOH_INSERT_AFTER        = 5  

function WM_NOTIFY_DECODERS.HLN_ATTACH_BEHAVIOR(hdr) 
	local t = ffi.cast('NMHL_ATTACH_BEHAVIOR*', hdr)
	local behavior_name = ffi.string(t.behaviorName) 
	local params
	local point

	if(nil == dispatcher[behavior_name]) then
		dispatcher[behavior_name] = {}
	else
	   return --only allow one element per behavior.
	end

	if(nil == global_space[behavior_name]) then
	   global_space[behavior_name] = {}
	end
    
	global_space[behavior_name].element = t.element  
   
	if(nil ~= global_space[behavior_name].on_key) then
		dispatcher[behavior_name].on_key = function(tag, he, evtg, prms )
		   params = ffi.cast('KEY_PARAMS *',prms)
		   global_space[behavior_name].on_key({cmd = params.cmd, key_code = params.key_code, alt_state = params.alt_state})
		   return 0
		end
		HTMLayout_C.HTMLayoutAttachEventHandlerEx(t.element, dispatcher[behavior_name].on_key,t.elementTag,html_events.HANDLE_KEY)
	end	

	if(nil ~= global_space[behavior_name].on_mouse) then
		dispatcher[behavior_name].on_mouse = function(tag, he, evtg, prms )
		   params = ffi.cast('MOUSE_PARAMS *',prms)

		   global_space[behavior_name].on_mouse(
		      {
			     cmd = params.cmd, 
				 pos = {params.pos.x,params.pos.y},
				 pos_document = {params.pos_document.x,params.pos_document.y},
				 button_state = params.button_state,
				 alt_state = params.alt_state,
				 cursor_type = params.cursor_type,
				 is_on_icon = params.is_on_icon,
				 dragging = params.dragging,
				 dragging_mode = params.dragging_mode				 
			  })
		   return 0
		end
		HTMLayout_C.HTMLayoutAttachEventHandlerEx(t.element, dispatcher[behavior_name].on_mouse,t.elementTag,html_events.HANDLE_MOUSE)
	end		

	if(nil ~= global_space[behavior_name].on_focus) then
		dispatcher[behavior_name].on_focus = function(tag, he, evtg, prms )
		   params = ffi.cast('FOCUS_PARAMS *',prms)

		   global_space[behavior_name].on_focus({cmd = params.cmd, by_mouse_click = params.by_mouse_click, cancel = params.cancel})
		   return 0
		end
		HTMLayout_C.HTMLayoutAttachEventHandlerEx(t.element, dispatcher[behavior_name].on_focus,t.elementTag,html_events.HANDLE_FOCUS)
	end	

	if(nil ~= global_space[behavior_name].on_scroll) then
		dispatcher[behavior_name].on_scroll = function(tag, he, evtg, prms )
		   params = ffi.cast('SCROLL_PARAMS *',prms)

		   global_space[behavior_name].on_scroll({cmd = params.cmd, pos = params.pos, vertical = params.vertical})
		   return 0
		end
		HTMLayout_C.HTMLayoutAttachEventHandlerEx(t.element, dispatcher[behavior_name].on_scroll,t.elementTag,html_events.HANDLE_SCROLL)
	end	

	if(nil ~= global_space[behavior_name].on_exchange) then
		dispatcher[behavior_name].on_exchange = function(tag, he, evtg, prms )
		   params = ffi.cast('EXCHANGE_PARAMS *',prms)

		   
		   global_space[behavior_name].on_exchange({cmd = params.cmd, pos = {params.pos.x,params.pos.y},pos_view = {params.pos_view.x,params.pos_view.y}, data_types = params.data_types, drag_cmd = params.drag_cmd,fetch_data = params.fetch_data})
		   return 0
		end
		HTMLayout_C.HTMLayoutAttachEventHandlerEx(t.element, dispatcher[behavior_name].on_exchange,t.elementTag,html_events.HANDLE_SCROLL)
	end	
	
	if(nil ~= global_space[behavior_name].on_timer) then
		dispatcher[behavior_name].on_timer = function(tag, he, evtg, prms )
		   params = ffi.cast('TIMER_PARAMS *',prms)

		   global_space[behavior_name].on_timer({timerId = params.timerId})
		   return 0
		end
		HTMLayout_C.HTMLayoutAttachEventHandlerEx(t.element, dispatcher[behavior_name].on_timer,t.elementTag,html_events.HANDLE_TIMER)
	end	

	if(nil ~= global_space[behavior_name].on_draw) then
		dispatcher[behavior_name].on_draw = function(tag, he, evtg, prms )
		   params = ffi.cast('DRAW_PARAMS *',prms)

		   global_space[behavior_name].on_draw({cmd = params.cmd, hdc = params.hdc, area = {left = params.area.left, right = params.area.right,top = params.area.top,bottom = params.area.bottom}})
		   return 0
		end
		HTMLayout_C.HTMLayoutAttachEventHandlerEx(t.element, dispatcher[behavior_name].on_draw,t.elementTag,html_events.HANDLE_DRAW)
	end	

	if(nil ~= global_space[behavior_name].on_event) then
		dispatcher[behavior_name].on_event = function(tag, he, evtg, prms )
		   params = ffi.cast('BEHAVIOR_EVENT_PARAMS *',prms)

		   global_space[behavior_name].on_event({cmd = params.cmd, source_element = params.source_element, reason = params.reason,data = params.data})
		   return 0
		end
		HTMLayout_C.HTMLayoutAttachEventHandlerEx(t.element, dispatcher[behavior_name].on_event,t.elementTag,html_events.HANDLE_BEHAVIOR_EVENT)
	end	

	if(nil ~= global_space[behavior_name].on_data_arrived) then
		dispatcher[behavior_name].on_data_arrived = function(tag, he, evtg, prms )
		   params = ffi.cast('DATA_ARRIVED_PARAMS *',prms)

		   global_space[behavior_name].on_data_arrived({initiator = params.initiator, data = params.data, dataSize = params.dataSize,dataType = params.dataType,status = params.status,uri = params.uri})
		   return 0
		end
		HTMLayout_C.HTMLayoutAttachEventHandlerEx(t.element, dispatcher[behavior_name].on_data_arrived,t.elementTag,html_events.HANDLE_DATA_ARRIVED)
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

function HTMLayout:AppendMasterCSS(css_text) 
	HTMLayout_C.HTMLayoutAppendMasterCSS(css_text,css_text:len())
end

DeleteElement = function(element)
  return HTMLayout_C.HTMLayoutDeleteElement(element)									  
end

GetState = function(element)
  local state = ffi.new("unsigned int[1]")

  HTMLayout_C.HTMLayoutGetElementState(element,
									  state) 
  return state[0]										  
  
end  


SelectElements = function(element,css_selectors,callback,param)
	return HTMLayout_C.HTMLayoutSelectElements(element,
									   css_selectors,callback,param)
end



GetOuterHtml = function(element)
  local result_data = ffi.new("unsigned char*[1]")

  HTMLayout_C.HTMLayoutGetElementHtml(element,
									  result_data,
									  true) 
  return ffi.string(result_data[0])										  
  
end

GetInnerHtml = function(element)
  local result_data = ffi.new("unsigned char*[1]")
  HTMLayout_C.HTMLayoutGetElementHtml(element,
									  result_data,
									  false) 								  
  return ffi.string(result_data[0])										  
  
end	   

SetInnerHtml = function(element,html_text)

  HTMLayout_C.HTMLayoutSetElementHtml(element,
									  html_text,
									  #html_text,SIH_REPLACE_CONTENT) 
  
end	   

PrependInnerHtml = function(element,html_text)

  HTMLayout_C.HTMLayoutSetElementHtml(element,
									  html_text,
									  #html_text,SIH_INSERT_AT_START) 
  
end	

AppendInnerHtml = function(element,html_text)
  HTMLayout_C.HTMLayoutSetElementHtml(element,
									  html_text,
									  #html_text,SIH_APPEND_AFTER_LAST) 
  
end	
