# taohua.nvim

A Neovim plugin written in Rust (via `nvim-oxi`) for parsing TOML files.

## Build

```bash
make build-plugin
```

This builds the plugin artifact with Cargo.

## Test

```bash
make test
```

The test target builds first, then runs headless Neovim integration tests.

## Usage

Add this project to `runtimepath`, then require the module in Lua:

```lua
local taohua = require("taohua")
local ret = taohua.parse_toml("/path/to/file.toml")

if ret.ok then
  print(vim.inspect(ret.value))
else
  print(ret.error)
end
```

`parse_toml` returns a table with one of these shapes:

- success: `{ ok = true, value = <parsed_table> }`
- failure: `{ ok = false, error = <message> }`
