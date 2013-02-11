if !has('python')
  finish
endif

python << endpython
import vim
import re

def run_tmux_ocaml_command(lines):
  """
  Joins the list of strings lines by new lines and sends them to the tmux
  window using Vimux.
  """
  # Send lines to ocaml using Vimux
  lines_str = "\n".join(lines) + "\n"
  vim.command(':call VimuxRunCommand("%s", 0)' % lines_str.replace('"', '\\"'))

def run_tmux_ocaml_chunk():
  """
  Sends the current selected visible range to tmux.
  """
  r = vim.current.range
  run_tmux_ocaml_command(vim.current.buffer[r.start:r.end+1])

  # Move cursor to the end of the selection
  vim.current.window.cursor=(r.end+1, 0)

def run_tmux_ocaml_cell():
  """
  Tries to find the ocaml top level expression that's currently under the
  cursor. It uses the following heuristic:

  Going up from the current line, start at the first line that doesn't start
  with a blank. Going down from the current line, stop at the first line that
  contains a ';;' in it.
  """
  cur_line = int(vim.eval('line(".")')) - 1
  buff = vim.current.buffer

  # Get range
  start = cur_line
  while start != 0 and re.match(r" ", buff[start]):
    start -= 1

  end = cur_line
  while end != len(buff)-1 and not re.search(r";;", buff[end]):
    end += 1

  run_tmux_ocaml_command(buff[start:end+1])

endpython

" Key Mappings
vmap <silent> <C-c> :python run_tmux_ocaml_chunk()<CR>
noremap <silent> <C-g> :python run_tmux_ocaml_cell()<CR>
