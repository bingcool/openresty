local ngx = ngx

-- 从全局内存表了里面获取设置的设置的灰度user_id table
local user_table = ngx.shared.user_tables

-- 解析token，获取UID，比如是999
local uid = ngx.req.get_uri_args()['uid']

-- 判断该客户是灰度的话，重置灰度环境server变量
ngx.log(ngx.INFO, 'uid=', user_table:get(uid))

-- for k,_ in pairs(user_table) do
--     ngx.log(ngx.INFO, 'get_user_id=', k)
-- end

if uid then
    uid = tonumber(uid, 10)
    if user_table:get(uid) then
        ngx.var.server = 'gray.server'
    end
end

-- 另外还可以生成traceId,并设置在请求头
local uuid = require('uuid')
uuid.seed()
local uuidStr = uuid.generate_v4()
ngx.req.set_header('trace-id', uuidStr)
ngx.req.set_header('request-time', tostring(ngx.now()))
