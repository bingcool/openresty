-- JSON module
local json = require('cjson')

-- cookie module
local ck = require('resty.cookie')
local ngx = ngx

-- user_agent
local user_agent = ngx.var.http_user_agent
ngx.log(ngx.INFO, 'http_user_agent: ', user_agent)

-- get params
local get_args = ngx.req.get_uri_args()
ngx.log(ngx.INFO, 'get-params: ', json.encode(get_args))

-- post params
local post_args = ngx.req.get_post_args()
ngx.log(ngx.INFO, 'post-params: ', json.encode(post_args))

-- req header
local headers = ngx.req.get_headers()
ngx.log(ngx.INFO, 'req-header: ', json.encode(headers))

-- req cookie
local cookies = ngx.var.http_cookie
-- 此处获取的是原始的cookie字符串，eg:"token=wefrghjkjkk; x-k=defgbjj"
ngx.log(ngx.INFO, 'req-cookie: ', json.encode(cookies))

local cookie, err = ck:new()
if not cookie then
    ngx.log(ngx.ERR, 'cookie err: ', err)
    return
end

-- cookie token
local token = cookie:get('token')
ngx.log(ngx.INFO, 'cookie token: ', token)

ngx.say('hello word')
