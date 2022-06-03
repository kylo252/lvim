-- basic autoloaded snippet example
local ls = require "luasnip"
return {
  ls.parser.parse_snippet("trig", "loaded!!"),
}
