--[[
  multidim.lua
  Multidimensional arrays for Lua
  version: 16.05.27
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

-- Ugly version. I'm not proud of it, but Lua refuses to do it right otherwise.

-- -- *import quickmath

mkl.version("Love Lua Libraries (LLL) - multidim.lua","16.05.27")
mkl.lic    ("Love Lua Libraries (LLL) - multidim.lua","ZLib License")



function declaremultidim(dimensions)
assert(type(dimensions)=='table',"I can only a table for the dimension defintion. Not a "..type(dimensions))
assert(#dimensions,"Illegal number of dimensions")
local slots = 1
for k,i in pairs(dimensions) do
    slots = slots * i
    assert(slots>1,"Illegal slots number. Probably caused by too many dimension possibities. ("..slots..")") 
    assert(i>1,"Illegal dimension maximum") 
    end
local ret    
ret = {
         array = {},
         dims = dimensions,
         
         indexfromslot= function(self,t)
         --[[
         local ret=1
         assert(#t==#self.dims,"Incorrect number of dimensions (I have "..#self.dims..", I was asked for "..#t)
         for k,i in ipairs(t) do          
                -- print("k = "..strval(k).."; i = "..strval(i).."; ret = "..valstr(ret).."; dimvalue = "..valstr(self.dims[k]))
                ret = ret + (self.dims[k]*i)
                assert(i>=1 and i<=self.dims[k],"Multiarray index out of range") 
             end
             return ret         
         ]]
             local ret
             assert(#t==#self.dims,"Incorrect number of dimensions (I have "..#self.dims..", I was asked for "..#t)
             for k,i in ipairs(t) do
                 if ret then ret = ret ..":" end
                 assert(type(i)=='number',"Invalid index on "..k)
                 ret = (ret or ">")..i
                 end   
             return ret.."<"    
         end,

         def = function (self,index,value)
            local i = self.indexfromslot(self,index)
            self.array[i] = value
         end,
         
         get = function (self,index)
            local i = self.indexfromslot(self,index)
            return self.array[i]
            end,
            
         --each = function(self) return each(self.array) end, -- (won't work any more)
         truepairs = function(self) return spairs(self.array) end,
         pairs = function(self,pstart)
                   local ak={}
                   local value
                   local start = pstart or {} 
                   for i=1,#self.dims do ak[i]=1 start[i]=start[i] or 1 end
                   ak[1]=start[1]-1
                   return function()
                     local i=1
                     --repeat
                      ak[1]=ak[1]+1
                      while ak[i]>self.dims[i] do
                         ak[i]=start[i]
                         i=i+1
                         if i>#self.dims then return nil end
                         ak[i]=ak[i]+1
                       end
                       value = self.get(self,ak)
                       --until value
                     return ak,value
                   end  
                 end
      }  
return ret        
end


function table2multidim(table,dimensions)
local ret = declaremultidim(dimensions)
assert(type(table)=='table',"Why are you giving me a "..type(table).." when I need a table?")
ret.array=table
return ret
end


--[[

   An important note before using this module.
   It's handy to have multiple dimensions, but don't overdo it. 
   Lua's capacity is limited *AND* the more dimensions you add, the slower your program can become.
   In other words..... use with care!
   
   usage:
   a = declaremultdim({4,4})
   a:def({3,2},"Hello")
   print(a:get({3,2})) -- prints "Hello"
   
   
 
]]

return true
