# Personal NvChad configuration

Personal Neovim set-up built on top of [NvChad](https://github.com/NvChad/NvChad).

This repo can be used as

- a **drop-in `~/.config/nvim` folder** (clone it and run `nvim`), or
- a reference to cherry-pick ideas, plugins or key-maps for your own config.

It tries to stay reasonably close to upstream NvChad while adding quality-of-life tweaks, language tooling, a well-curated plugin collection and opinionated UX defaults.

---

## Quick start

```bash
# back-up existing config first
mv ~/.config/nvim ~/.config/nvim.bak

# clone with submodules & lazy-lock file
git clone --depth 1 https://github.com/chicha09/nvim ~/.config/nvim

# start Neovim –  NvChad + lazy.nvim will take care of the rest
nvim
```

All plugins are lazy-loaded. The first start will take a minute to install
parsers, LSPs, DAP adapters, etc. Afterwards everything should feel snappy.

> Tip: run `:Lazy` at any time to see plugin status.

---

## At a glance

• **Colour scheme** `tokyonight` (via NvChad base46)

• **Plugin manager** [lazy.nvim](https://github.com/folke/lazy.nvim) (handled by NvChad)

• **Formatter / Linter** [conform.nvim](https://github.com/stevearc/conform.nvim) & [lint.nvim](https://github.com/mfussenegger/nvim-lint) with automatic installation through Mason

• **LSP** `mason-lspconfig` + lots of hand-picked servers (Lua, Go, Rust, Ruby, JS/TS, Terraform, …)

• **DAP** `nvim-dap` + UI, virtual-text & VS Code JS adapter – installed automatically by `mason-nvim-dap`

• **Completion** `nvim-cmp` + `copilot-cmp` + custom sources & icons (lspkind)

• **Treesitter** Full parser line-up, text-objects & `endwise` / `autotag` extensions

• **Snippets** LuaSnip – VSCode & project snippets are lazy-loaded (`./snippets`)

---

## Plugin highlights

Below is a non-exhaustive list grouped by category. See `lua/plugins/*.lua` for the exact specs.

### Git / Version control

- `gitsigns.nvim` – sign column & hunk actions
- `neogit` + `lazygit.nvim` – two excellent Git UIs
- `gitlinker.nvim` & `advanced-git-search` – open/blob/search in browser

### Navigation & Motion

- `flash.nvim` – jump anywhere with <kbd>s</kbd>
- `harpoon` – quickly mark & switch between files
- `neoscroll` – smooth scrolling
- `sort-motion`, `tiny-glimmer`, `tabout` – misc movement goodies

### IDE features

- `lspsaga`, `lsp_signature`, `outline.nvim`, `trouble.nvim`
- `nvim-dap`, `nvim-dap-ui`, `nvim-dap-virtual-text`, `nvim-dap-vscode-js`
- `neotest` – run tests with output & summary view

### Editing UX

- `nvim-surround`, `nvim-autopairs`, `nvim-ts-autotag`
- `indent-blankline`, `todo-comments`, `text-case.nvim`
- `noice.nvim` – overhauled command-line & notifications
- `zen-mode`, `image.nvim`, `render-markdown` – focus & markdown goodies

### AI / Copilot / GPT

- `copilot.lua` + `copilot-cmp` integration
- `gp.nvim` & `augmentcode` – ChatGPT powered actions

### Miscellaneous fun

- `vim-be-good` – game to practise Vim
- `cellular-automaton` – because why not

---

## Key-map cheatsheet (leader = <kbd>SPACE</kbd>)

| Mode | Keys                | Action                                       |
| ---- | ------------------- | -------------------------------------------- |
| n    | `;`                 | Enter command-line (like `:` but closer)     |
| n    | `<C-d> / <C-u>`     | Scroll half-page **and keep cursor centred** |
| n    | `n` / `N`           | Next/previous search hit & centre cursor     |
| n    | `<leader>fc`        | Telescope **file-context** picker            |
| n    | `<leader>fp`        | Telescope **projects** picker                |
| n    | `<M-n> / <M-p>`     | Next / prev quick-fix entry                  |
| i,s  | `<Tab>` / `<S-Tab>` | LuaSnip jump next / previous                 |
| i    | `<C-j>` / `<C-k>`   | nvim-cmp next / previous completion item     |

You can discover the full mapping list with `:Telescope keymaps` or by reading `lua/mappings.lua`.

---

## Autocommands & file-type tweaks

- Custom file-types for Hyprland, Kitty, Rasi (rofi/wofi) scripts, Waybar, etc.
- Treesitter language remaps (e.g. use `bash` parser for Kitty conf files).
- Undercurl terminal support and global statusline enabled.

All of this lives in `lua/options.lua` and `lua/autocmds.lua`.

---

## Formatters, linters & language servers

This config relies heavily on the _Mason_ ecosystem – servers are installed
on-demand the first time you open a matching file type.

### Conform (formatting)

| Language | Formatter        |
| -------- | ---------------- |
| Lua      | `stylua`         |
| Go       | `goimports`      |
| Rust     | `rustfmt`        |
| Ruby     | `rubocop`        |
| …        | _plus many more_ |

### nvim-lint (diagnostics)

Lint sources are registered in `lua/configs/lint.lua` – they mirror the above
formatters when sensible.

### LSP servers

Initial set-up includes (but is not limited to): `lua_ls`, `gopls`, `rust_analyzer`,
`ruby_ls`, `tsserver`, `jsonls`, `yamlls`, `terraformls`, `bashls`, `marksman`,
`clangd`, `pyright` …

You can add or blacklist servers in `lua/configs/mason-lspconfig.lua`.

### Rust-specific features

Enhanced Rust development with:

- **rustaceanvim**: Supercharged Rust experience with advanced LSP features
- **rust-analyzer**: Language Server Protocol with inlay hints and diagnostics
- **crates.nvim**: Dependency management for `Cargo.toml`
- **rustfmt**: Code formatting
- **clippy**: Linting and code analysis
- **Key features**:
  - Code actions, hover actions, runnables, debuggables
  - Expand macros, move items, structural search/replace
  - View HIR/MIR, syntax tree, explain errors
- **Rust keymaps**: `<leader>ra` (code actions), `<leader>rr` (runnables), `<leader>rt` (testables), `<leader>rd` (debuggables), `K` (hover actions)
- **Crates keymaps**: `<leader>ct` (toggle), `<leader>cu` (update), `<leader>cU` (upgrade)

---

## Screenshots

<details>
<summary>Click to expand</summary>

![nvchad-dashboard](https://user-images.githubusercontent.com/0/placeholder-dashboard.png)

![coding-view](https://user-images.githubusercontent.com/0/placeholder-code.png)

</details>

---

## Structure overview

```
~/.config/nvim
├── init.lua            # boots NvChad
├── lazy-lock.json      # pinned plugin versions (lazy.nvim)
├── lua
│   ├── chadrc.lua      # top-level NvChad overrides (theme, plugins)
│   ├── options.lua     # vim.opt tweaks & file-type detection
│   ├── mappings.lua    # key-maps (wrapped helper)
│   ├── autocmds.lua    # misc autocmds
│   ├── plugins/        # one file per plugin spec (lazy.nvim format)
│   └── configs/        # bigger plugin configs split out for clarity
└── snippets/           # extra VSCode-style snippets (LuaSnip)
```

---

## Acknowledgements

- Huge thanks to the [NvChad](https://github.com/NvChad/NvChad) team – this
  config is only possible because of their work.
- Inspiration & bits of code from
  [LazyVim](https://github.com/LazyVim/LazyVim),
  [craftzdog/dotfiles-public](https://github.com/craftzdog/dotfiles-public)
  and many single-purpose repos.

---

Happy hacking! – _chicha09_
