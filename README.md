vimux-ocaml
===========

Enables you to send OCaml statements from vim to a tmux window running ocaml.

Prerequisites
-------------

* [tmux](http://wiki.ubuntuusers.de/tmux)
* vim compiled with python and ruby (for vimux) support.
* [vimux](https://github.com/benmills/vimux/)

Installation
------------

Installation using [pathogen](https://github.com/tpope/vim-pathogen):

1. Go to your `~/.vim/bundle/` directory:

   `$ cd ~/.vim/bundle/`

2. Clone the repositoty:

   `$ git clone git://github.com/themoritz/vimux-ocaml.git`

   This will create a directory named `vimux-ocaml` in your `bundle` directory.

Usage
-----

Start a tmux session and open any OCaml document in vim. Then type `:VimuxPromptCommand` and type `ocaml` when prompted. This will open a tmux window just below the window where vim is running.

Now there are two ways to send OCaml code to the ocaml toplevel:

1. Visually select a range of your code (blocks). Then hit `C-c`. This will send exactly the code in your visual range to the toplevel.
2. Place the cursor inside some statement and hit `C-g`. This will send the smallest set of lines to the toplevel, such that (a) the cursor is in the set, (b) the first line in the set does not start with a blank and (c) the last line contains `;;`. So this effectively sends the statement currently under the cursor to ocaml.

Configuration
-------------

To change the key-mappings, edit `ftplugin/ocaml.vim` and change the last two lines. You can also put these lines in your `~/.vimrc` file.
