local case = arg[1]
local cwd = arg[2]

local taohua = require("taohua")

local tomlfile = vim.fs.joinpath(cwd, "tests", "fixtures", case .. ".toml")
local expectedfile = vim.fs.joinpath(cwd, "tests", "expected", case .. ".lua")
local ret = taohua.parse_toml(tomlfile)
assert(ret.ok, "PARSE FAILED: " .. tostring(ret.error))
local expected_tbl = assert(dofile(expectedfile), "DOFILE FAILED")
assert(vim.deep_equal(ret.value, expected_tbl))
