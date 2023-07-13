local ngx = ngx
local delay = 10
local handler

handler = function()
    -- do something
    -- 定时从redis中获取灰度的user_id
    local user_table_list = {100, 200, 999}

    local user_table = ngx.shared.user_tables

    -- 循环设置user_id到全局的内存表，其他worker可以取到里面值
    for _, v in pairs(user_table_list) do
        -- ngx.log(ngx.INFO, 'user_id_set_table=', v)
        user_table:set(v, 1)
    end

    ngx.timer.at(delay, handler)
end

-- nginx worker等于0的定时拉取灰度的user_id
if ngx.worker.id() == 0 then
    local ok, err = ngx.timer.at(delay, handler)
end
