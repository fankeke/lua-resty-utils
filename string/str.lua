---string manipulation

local sub = string.sub
local len = string.len
local gmatch = string.gmatch
local find = string.find
local tab_insert = table.insert



local _M = {}
_M._VERSION = "0.0.1"


function _M.str_trim_prefix(str, prefix)
    if _M.str_startwith(str, prefix) then
        return sub(str, len(prefix) + 1, -1)
    end
    return str
end    

function _M.str_split(str, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}; i = 1
    for str in gmatch (str, "([^" .. sep .. "]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end


function _M.str_startwith(str, prefix)
    return sub(str, 1, len(prefix)) == prefix
end


return _M
