--[[
  phantasar.lua
  Phantasar Load Screen
  version: 16.03.28
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

--[[ Please note that the Phantasar Productions logo is property of Jeroen Petrus Broks.
     If you use this library, please use your own logo in stead! ]]

-- *import chain
-- *import qgfx
-- *import audio

-- *undef dev_screen
-- *define dev_shownum

mkl.version("Love Lua Libraries (LLL) - phantasar.lua","16.03.28")
mkl.lic    ("Love Lua Libraries (LLL) - phantasar.lua","ZLib License")


local r ={}
local mylogo = LoadImage("$$mydir$$/LOGO.PNG")-- love.graphics.newImage("$$mydir$$/LOGO.PNG")

local retdata

function r.draw()
local ww --= love.window.getWidth()
local wh --= love.window.getHeight()
local wf
ww,wh,wf = love.window.getMode()
local cx = ww/2
local cy = wh/2
local iw = mylogo.image:getWidth()
local ih = mylogo.image:getHeight()
local dx = cx - (iw/2)
local dy = cy - (ih/2)
CLS()
DrawImage(mylogo,dx,dy) -- old love.graphics.draw(mylogo,dx,dy)
Color(50,50,50)
Rect(50,wh-50,ww-100,25)
Color(r.barcol[1],r.barcol[2],r.barcol[3])
Rect(51,(wh-50)+1,r.barsize,23)
Color(255,255,255)
love.graphics.print(r.procent.."%",ww/2,wh-45)
-- *if dev_screen
love.graphics.print("Screen Size: "..ww.."x"..wh,0,0)
-- *if dev_shownum
love.graphics.print("Processing: "..r.process.." of "..r.total,0,15)
-- *fi 
end

function r.update()
local ww --= love.window.getWidth()
local wh --= love.window.getHeight()
local wf
ww,wh,wf = love.window.getMode()
if r.process>=r.total then
   chain.go(r.chainto) 
   return 
   end
r.process = r.process + 1
r.rawprog = (r.process/r.total)
r.procent = math.floor(r.rawprog*100)
r.barsize = math.floor(r.rawprog*(ww-102))
local croll = r.roll[r.process]
;(({
      image = function()
              r.retdata[croll[2]] = LoadImage(croll[3])
              end,
      audio = function()
              r.retdata[croll[2]] = LoadSound(croll[3],croll[4],croll[5])       
              end          
      
   })[croll[1]] or function() error("Unknown asset type: "..croll[1]) end)()
end


function r.init(assetlist,chainto,barcol)
chain.go(r)
r.chainto = chainto
r.retdata = {}
r.total = 0
r.process = 0
r.roll = {}
r.barcol = r.barcol or {255,180,0}
for k,v in pairs(assetlist) do for k2,v2 in pairs(v) do r.total=r.total+1 r.roll[#r.roll+1] = { k,k2,v2 } end end
return r.retdata
end

return r