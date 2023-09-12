if builtin functions -q fish_add_path
  if command -vq -- tfenv
    fish_add_path --path -p $HOME/.tfenv/bin
  end
end

export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
