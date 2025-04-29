# Textwire Neovim Plugin
Neovis plugin for Textwire syntax highlighting support.

> [!NOTE]
Hopefully support for this parser will be upstreamed by editors soon. At the moment, it must be integrated manually.

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
        require("textwire").build()
    end,
}
```

> [!TIP]
> The `build` hook that loads highlights is needed to update highlights each time when we update the plugin. In the future we'll not need this block when this plugin will be a part Mason. We need at least 100 starts on [Textwire](https://github.com/textwire/textwire) repo to contribute to Mason

## Troubleshootings
### Plugin is not updating
If you already installed `textwire.nvim` plugin before `March 30 2025`, please add `branch = "master"` to your `textwire.lua` file and run `:Lazy sync textwire.nvim` and `:Lazy update textwire.nvim` commands to update the plugin. It will fix the issue.

After that, you can remove `branch = "master"` from your `textwire.lua` file and next updates will be done automatically.
