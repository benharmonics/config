# config
My personal configuration files for programs like Neovim, zsh, etc. I try to keep it somewhat minimal, but I do a lot of development using Neovim so this configuration is a little bloated...

I use a slightly different .zshrc for work (on MacOS). The one included in this repository is what I use on WSL2. I'll probably include the one I use for work at some point but it's not really a huge difference.

## Tools to install

You should install [Zoxide](https://github.com/ajeetdsouza/zoxide) (to use instead of `cd`), [Starship](https://starship.rs/installing/) (for a pretty neat prompt), and [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions). zsh-autosuggestions needs to be installed manually; I would suggest `git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh` (you may need to create this directory).

Maybe it's obvious, but you need to install [Rust and Cargo](https://doc.rust-lang.org/cargo/getting-started/installation.html), Neovim, and zsh. Less obviously, you need to install [Node.js and npm](https://www.npmjs.com/), and [pyright](https://pypi.org/project/pyright/) should be installed via npm (i.e. `npm i -g pyright`). Some other must-haves for me would be [fd-find](https://github.com/sharkdp/fd) and [ripgrep](https://github.com/BurntSushi/ripgrep).
