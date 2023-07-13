local ngx = ngx
-- cookie module
local ck = require('resty.cookie')
local cookie = ck:new()

-- 从全局内存表了里面获取设置的设置的灰度user_id table
local user_table = ngx.shared.user_tables

-- cookie中获取token
local token = cookie:get('token')
-- 解析token，获取UID，比如是999
local uid = 999

-- 判断该客户是灰度的话，重置灰度环境server变量
if user_table:get(uid) then
    ngx.var.server = 'gray.server'
end

-- 另外还可以生成traceId,并设置在请求头
local uuid = require('uuid')
uuid.seed()
local uuidStr = uuid.generate_v4()
ngx.req.set_header('trace-id', uuidStr)
ngx.req.set_header('request-time', tostring(ngx.now()))
