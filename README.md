# Textwire Neovim Plugin
Neovim plugin for Textwire syntax highlighting support and autocompletions

> Hopefully support for this parser will be upstreamed by editors soon. At the moment, it must be integrated manually.

## Installation
### [lazy.nvim](https://github.com/folke/lazy.nvim)
Create a file `textwire.lua` in your `/lua/plugins` directory inside neovim configurations:

```lua
return {
    "textwire/textwire.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    build = function()
        require("textwire").load_highlights()
    end,
}
```
