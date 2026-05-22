local case = arg[1]
local cwd = arg[2]

local taohua = require("taohua")

local tomlfile = vim.fs.joinpath(cwd, "tests", "fixtures", case .. ".toml")
local expectedfile = vim.fs.joinpath(cwd, "tests", "expected", case .. ".lua")
local ret = taohua.parse_toml(tomlfile)
local expected_tbl = assert(dofile(expectedfile), "DOFILE FAILED")

if expected_tbl.ok then
	assert(ret.ok, "PARSE FAILED: " .. tostring(ret.error))
	assert(vim.deep_equal(ret.value, expected_tbl.value), "PARSE RESULT MISMATCH")
	return
end

assert(not ret.ok, "EXPECTED PARSE FAILURE")
assert(type(ret.error) == "string", "EXPECTED ERROR STRING")

if expected_tbl.error_contains ~= nil then
	assert(string.find(ret.error, expected_tbl.error_contains, 1, true) ~= nil, "ERROR MISMATCH: " .. ret.error)
end
