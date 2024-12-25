# uwaterloo-nvim
A Simple nvim config for student servers

Instructions:
Execute following commands:
cd ~
git clone https://github.com/neovim/neovim
cd neovim
git checkout tags/0.10.3
make CMAKE_BUILD_TYPE=Release
make install


Now change the name of the source-built executable to avoid conflicts with pre-existing nvim:
cd ~/neovim/bin/
mv nvim SOMEOTHERNAME

Add the executable to your bashrc:
Execute command:
vim ~/.bashrc

And add the following to the bottom of this file:
export PATH="$HOME/neovim/bin:$PATH"

Then add the contents of the provided init.lua file to path:
~/.config/nvim/init.lua

