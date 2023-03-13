set -gx EDITOR "vim";
set -gx VISUAL "vim";
set -gx GUI_EDITOR "vim";
# if command -vq -- fish_add_path
if builtin functions -q fish_add_path
  fish_add_path --path -a ~/.local/share/nvim/lazy/vim-iced/bin
  # fish_add_path --path -p ~/.local/share/nvim/mason/bin
end
