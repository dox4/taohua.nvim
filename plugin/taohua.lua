local plugin_root_dir = vim.fn.expand("<sfile>:p:h:h")

--- get lib extension (copied from blink.cmp)
--- @return string
local function get_lib_extension()
	if jit.os:lower() == "mac" or jit.os:lower() == "osx" then
		return ".dylib"
	end
	if jit.os:lower() == "windows" then
		return ".dll"
	end
	return ".so"
end

local ext = get_lib_extension()
local target = plugin_root_dir .. "/target/release/?" .. ext
local target_lib = plugin_root_dir .. "/target/release/lib?" .. ext

package.cpath = package.cpath .. ";" .. target .. ";" .. target_lib
