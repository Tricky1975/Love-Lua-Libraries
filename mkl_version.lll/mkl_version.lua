--[[
  mkl_version.lua
  mkl_version
  version: 16.03.26
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

local ret = {}

     ret.data = {}
     
     ret.version = function (file,version)
                    ret.data[file]=ret.data[file] or {}
                    ret.data[file].version = version
               end
               
     ret.lic    = function (file,version)
                    ret.data[file]=ret.data[file] or {}
                    ret.data[file].license = version
               end
               
     



local function me(mkl)
mkl.version("","")
mkl.lic    ("","")
end; me(ret)

mkl = ret
return ret
