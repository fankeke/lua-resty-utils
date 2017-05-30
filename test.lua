local str_util = require "string.str"
local debug_util = require "debug.log"

local dd = debug_util.dd

local str = "hello,world,o ojid, jiadej,,, jidjie, jiajd, jiejd ,,jjie"

--[[str_trim_prefix
local res = str_util.str_trim_prefix(str, "hello")
dd(res)
local res = str_util.str_trim_prefix(str, "")
dd(res)
--]]


--[[str_startwith
local res = str_util.str_startwith(str, "hello")
debug_util.dd(res)
local res = str_util.str_startwith(str, "ello")
dd(res)
--]]


--split
--[[
local str = string.rep(str, 100)
local res
for i = 1, 10, 1 do     
    res = str_util.str_split(str, ",")
    dd(res)
end
--]]

