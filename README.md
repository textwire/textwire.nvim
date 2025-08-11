# Textwire Neovim Plugin
Neovim plugin for Textwire syntax highlighting support.

> [!NOTE] Give us a Star
> Hopefully support for this parser will be upstreamed by editors soon. At the moment, it must be integrated manually. In the future we'll not need this block when this plugin will be a part Mason. **We need at least 100 starts** on [Textwire](https://github.com/textwire/textwire) repository to contribute to Mason

## Installation
### [lazy.nvim](https://github.com/folke/lazy.nvim)

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

## Enable Syntax Highlighting
After installing the plugin, you can open any Textwire file and write the command `:TSInstall textwire` to install query files.

## Contributing
When you are contributing to this plugin, please make sure that you are running the `cmd/download` bash script that will download LSP binaries and treesitter highlights into `bin` and `queries` directories. You can run it with the following command:

```bash
./cmd/download
```

Don't forget to make this file executable if needed.
