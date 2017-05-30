local concat = table.concat

--local succ, err = pcall(ngx.worker.id)
--if not succ then
--    ngx.worker.id = ngx.worker.pid
--end

local _M = {}
_M._VERSION = "0.0.1"

local function log_str(...)
    --local info = { ... }
    --local str = concat(info, " ") -- boolean type not work with this

    --[[
    ngx.log(ngx.ERR, "[==worker_id: ", ngx.worker.id(), "==]", ...)
    --]]
    
    print(...)
end


local log_tab
log_tab = function(tab)
    for k, v in pairs (tab) do
        if type(v) == "table" then
            log_str(k, "---> table")
            log_tab(v)

        else
            if type(v) == "function"then
                log_str(k, "---> function")
            else
                log_str(k, "---> ", v)
            end
        end
    end
end


function _M.dd(...)
    local args = { ... }

    for _, v in pairs(args) do  
        if type(v) == 'table' then
            log_tab(v)
        else
            log_str(v)
        end
    end
end

return _M




