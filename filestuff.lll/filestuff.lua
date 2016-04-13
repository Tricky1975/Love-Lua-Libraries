--[[
  filestuff.lua
  filestuff
  version: 16.04.02
  Copyright (C) 2016 Jeroen P. Broks
  This software is provided 'as-is', without any express or implied
  warranty.  In no event will the authors be held liable for any damages
  arising from the use of this software.
  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:
  1. The origin of this software must not be misrepresented; you must not
     claim that you wrote the original software. If you use this software
     in a product, an acknowledgment in the product documentation would be
     appreciated but is not required.
  2. Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.
  3. This notice may not be removed or altered from any source distribution.
]]

function stripdir(a)
	local ret = ""
	local c
	for i=#a,1,-1 do
	    c = mid(a,i,1)
	    if c=="/" or c=="\\" then return ret end
	    ret = c .. ret	    
	end
	return ret    
end

function extractdir(a)
	local c
	for i=#a,1,-1 do
	    c = mid(a,i,1)
	    if c=="/" or c=="\\" then return left(a,i-1) end
	end
return ""	
end


function stripext(a)
	local ret = ""
	local c
	for i=1,#a,1 do
	    c = mid(a,i,1)
	    if c=="." then return ret end
	    ret = ret .. c	    
	end
	return ret    
end