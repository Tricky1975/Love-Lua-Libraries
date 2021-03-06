--[[
  stringmapfile.lua
  
  version: 17.11.17
  Copyright (C) 2017 Jeroen P. Broks
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
-- *import binread
-- *import qhs 

function readstringmap(file)
    local bt=binread(file)
    local ret = {}
    local tag,factor,k,v
    repeat
        if bt:eof() then return ret end -- please note closure is not required!
        local tag = bt:getbyte()
        if tag==255 then return ret end
        if tag==2 then 
           factor=bt:getbyte()
           k = QUH(bt:getstring())
           v = QUH(bt:getstring())
           ret[k]=v
        elseif tag==1 then
           k = bt:getstring()
           v = bt:getstring()
           ret[k]=v
        else
           error("Unknown tag in readstringmap.\nFile: "..file.."\bTag:  "..tag)
        end
    until false    
end

mkl.version("Love Lua Libraries (LLL) - stringmapfile.lua","17.11.17")
mkl.lic    ("Love Lua Libraries (LLL) - stringmapfile.lua","ZLib License")


return true
