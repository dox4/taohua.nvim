# taohua.nvim

A Neovim plugin written in Rust (via `nvim-oxi`) for parsing TOML files.

## Install and Usage

Use with `lazy.nvim`:

```lua
{
  "dox4/taohua.nvim",
  build = "make",
  -- use cargo build --release on Windows without make
  -- build = "cargo build --release",
}
```

Then require the module in Lua:

```lua
local taohua = require("taohua")
local ret = taohua.parse_toml("/path/to/file.toml")

if ret.ok then
  print(vim.inspect(ret.value))
else
  print(ret.error)
end
```

## API

`parse_toml(path)` returns one of these shapes:

- success: `{ ok = true, value = <parsed_table> }`
- failure: `{ ok = false, error = <message> }`

## Development

Build plugin artifact:

```bash
make build-plugin
```

or just:

```bash
make
```

Run tests:

```bash
make test
```

The test target builds first, then runs headless Neovim integration tests.
