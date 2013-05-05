--class/messageloop: the thread message loop function.
setfenv(1, require'winapi_init')
require'winapi_window'
require'winapi_accelerator'
require'winapi_windowclass'

WM_UNREGISTER_CLASS = WM_APP+1 --unregister window class after window destruction

function ProcessMessage(msg)
	local window = Windows.active_window
	if window then
		if window.accelerators.haccel then
			if TranslateAccelerator(window.hwnd, window.accelerators.haccel, msg) then --make hotkeys work
				return
			end
		end
		if IsDialogMessage(window.hwnd, msg) then --make tab and arrow keys work with controls
			return
		end
	end
	TranslateMessage(msg) --make keyboard work
	DispatchMessage(msg) --make everything else work
end

function MessageLoop() --you can do os.exit(MessageLoop())
	local msg = types.MSG()
	local ret
	while true do
		ret = GetMessage(nil, 0, 0, msg)
		if ret == 0 then break end
		ProcessMessage(msg)
		if msg.message == WM_UNREGISTER_CLASS then
			UnregisterClass(msg.wParam)
		end
	end
	return msg.signed_wParam --WM_QUIT returns 0 and an int exit code in wParam
end

function ProcessMessages()
	while true do
		local ok, msg = PeekMessage(nil, 0, 0, PM_REMOVE)
		if not ok then return end
		ProcessMessage(msg)
	end
end

