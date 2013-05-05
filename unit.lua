glue = require'glue'
local pf = require'pformat'

local function tostr(s)
	return pf.pformat(tostring(s))
end

function _test(t1, t2, prefix, level)
	if type(t1)=='table' and type(t2)=='table' then
		--for k,v in pairs(t1) do print('>t1',k,v) end
		--for k,v in pairs(t2) do print('>t2',k,v) end
		for k,v in pairs(t1) do
			_test(t2[k], v, prefix .. '.' .. tostr(k), level + 1)
		end
		for k,v in pairs(t2) do
			_test(t1[k], v, prefix .. '.' .. tostr(k), level + 1)
		end
	else
		if (t1 == t1 and t1 ~= t2) or (t1 ~= t1 and t2 == t2) then
			error(tostr(t1) .. " ~= " .. tostr(t2) ..
								" [" .. prefix .. "]", level)
		end
	end
end

function test(t1, t2)
	return _test(t1, t2, 't', 3)
end

function testmatch(s, pat)
	if not s:match(pat) then
		error("'" .. s .. "'" .. " not matching '" .. pat .. "'", 2)
	end
end

function ptest(t1,t2)
	print(t1)
	test(t1,t2,nil,3)
end

local ffi = require'ffi'
ffi.cdef'uint32_t GetTickCount();'

local last_time
function timediff()
	local time = ffi.C.GetTickCount()
	local d = last_time and (time - last_time)/1000 or 0
	last_time = time
	return d
end

function fps(n)
	return last_time and (n / (ffi.C.GetTickCount() - last_time) * 1000) or 0
end

function dir(d)
	local f = io.popen('ls -1 '..d)
	return glue.collect(f:lines())
end
