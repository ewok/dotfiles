function kubectl_status
  [ -z "$KUBECTL_PROMPT_ICON" ]; and set -l KUBECTL_PROMPT_ICON "⎈"
  [ -z "$KUBECTL_PROMPT_SEPARATOR" ]; and set -l KUBECTL_PROMPT_SEPARATOR "/"
  set -l config $KUBECONFIG
  [ -z "$config" ]; and set -l config "$HOME/.kube/config"
  if [ ! -f $config ]
    echo (set_color red)$KUBECTL_PROMPT_ICON" "(set_color white)"no config"
    return
  end

  set -l ctx (kubectl config current-context 2>/dev/null)
  if [ $status -ne 0 ]
    echo (set_color red)$KUBECTL_PROMPT_ICON" "(set_color white)"no context"
    return
  end

  set -l ns (kubectl config view -o "jsonpath={.contexts[?(@.name==\"$ctx\")].context.namespace}")
  [ -z $ns ]; and set -l ns 'default'

  set -l width (math -s0 (tput cols) \* 0.3)
  set -l half_width (math -s0 $width / 2)

  set -l color (echo $ctx | grep -q "prod"; and echo "red"; or echo "white")

  if test (echo $ctx$KUBECTL_PROMPT_SEPARATOR$ns | string length) -ge $width
      set -l ctx_tr (echo "$ctx" | string sub -l $half_width)
      set -l ctx_tr_end (echo "$ctx" | string sub -s -$half_width)
      echo (set_color cyan)$KUBECTL_PROMPT_ICON" "(set_color $color)"($ctx_tr..$ctx_tr_end$KUBECTL_PROMPT_SEPARATOR$ns)"
  else
      echo (set_color cyan)$KUBECTL_PROMPT_ICON" "(set_color $color)"($ctx$KUBECTL_PROMPT_SEPARATOR$ns)"
  end
end

function fish_right_prompt
  echo (kubectl_status)
end
