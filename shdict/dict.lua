local str_utils = require "string.str"
local tab_insert = table.insert

local _M = {}
_M._VERSION = "0.0.1"


function _M.dict_safe_incr(dict, key, step)
    local ok, newval, err

    if not (dict and key and value) then
        err = "failed to found dict or key or step"
        return nil, err
    end

    if type(step) ~= "number" then
        err = "step should be number"
        return nil, err
    end

    newval, err = dict:incr(key, step)
    if not newval and err == "not found" then
        ok, err = dict:safe_add(key, 0)
        if err == "exists" then
            dict:incr(key, step)

        elseif err == "no memory" then
            err = "no memory for dict to store"
            return nil, err
        end

    end

    return true
end    


--blooding implmetation
function _M.dict_get_keys(dict, prefix)
    if not prefix then
        prefix = ""
    end

    if not dict then
        ngx.log(ngx.ERR, "faild to find dict")
        return nil
    end

    --by default only 1024 items return
    local keys = dict:get_keys(0)
    local res = {}

    for _, k in pairs(keys) do
        if str_utils.str_startwith(k, prefix) then
            tab_insert(res, k)
        end
    end

    return res
end

return _M
