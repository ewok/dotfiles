if status --is-interactive; or status --is-login
  if command -vq -- direnv
    direnv hook fish | source
    function __direnv_export_eval --on-event fish_prompt;
        begin;
            begin;
                "/usr/bin/direnv" export fish
            end 1>| source
        end 2>| grep -E -v -e "^direnv: export"
    end;
  end
end
