My (Thingus)'s neovim config. Mainly keeping this here so I can grab it whenever I move to a new work environment.
You should just be able to pull this into `~/.config/nvim` and it'll setup itself on first invocation.
Plugins are managed by Lazy, which is bootstrapped in `config/lazy.lua` After that, everything in `plugins/setup_by_hand.lua` should get grabbed; see that file for the comprehensive list.
The other file that really matters is `keymaps.lua`; this is where I keep bindings and other flow stuff
There's a couple external requirements; you need Jupyter for Moten to run, and I think you also need Cargo/Rustup for rust_analyzer. (you should have been keeping this updated as you go along, Thing @_@)
Also, system needs Lazygit installed for `<leader>gg` to work
