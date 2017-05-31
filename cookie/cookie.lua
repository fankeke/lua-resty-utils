local sub = string.sub


local function fetch_cookie_table(self)
    local cookie = self.cookie
    if not cookie then
        return nil
    end

    if type(cookie) ~= "string" then
        ngx.log(ngx.ERR, "invalid cookie find")
        return nil
    end

    local cookie_len = #cookie
    local i, j = 1, 1

    local EXPECT_KEY = 1
    local EXPECT_VALUE = 2
    local state = EXPECT_KEY
    local hit

    local cookie_table = {}
    local key, value

    while i <= cookie_len  and j <= cookie_len do
        if state == EXPECT_KEY then
            if sub(cookie, j, j) == "=" then
                key = sub(cookie, i, j - 1)
                --print("key: ", key)
                i = j + 1
                j = i
                state = EXPECT_VALUE
                hit = true
            end
        elseif state == EXPECT_VALUE then
            if sub(cookie, j, j) == ";" then
                value = sub(cookie, i, j - 1)
                --print("value: ", value)
                cookie_table[key] = value
                i = j + 1
                j = i
                state = EXPECT_KEY
                hit = true
            end
        end
        if not hit then
            j = j + 1
        end

        hit = false

        --ngx.sleep(0.1)
        --ngx.log(ngx.ERR, "i: ", i, " j: ", j)
    end

    if state == EXPECT_VALUE then
        cookie_table[key] = sub(cookie, i, -1)
    end
                
    return cookie_table
end
                

local _M = {}
_M._VERSION = "0.0.1"


local mt = {
    __index = _M
}


function _M.new(self)
    local cookie = ngx.var.http_cookie
    if not cookie then
        return nil, "not found any cookie"
    end

    local ll = {
        cookie = cookie,
    }

    return setmetatable(ll, mt)
end


function _M.get_all(self)
    if not self.cookie_table then
        self.cookie_table = fetch_cookie_table(self)
    end
    
    return self.cookie_table

end


function _M.get(self, key)
    if not self.cookie_table then
        self.cookie_table = fetch_cookie_table(self)
    end

    return self.cookie_table[key]
end



return _M
