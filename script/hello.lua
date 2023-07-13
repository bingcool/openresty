local redis = require('resty.redis');
local red = redis:new()

local name = os.getenv('name');

local openssl = require('resty.openssl')

local mytable = {
    name='bingcool',
    sex='1'
}

print("openssl-version:"..openssl._VERSION)
print(mytable['name'])