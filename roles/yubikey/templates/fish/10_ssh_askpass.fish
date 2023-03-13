if test -z $TB
  {% if ansible_distribution == "Void" %}
  set -gx SSH_ASKPASS /usr/libexec/seahorse/ssh-askpass
  {% else %}
  set -gx SSH_ASKPASS /usr/lib/seahorse/ssh-askpass
  {% endif %}
  set -gx SSH_ASKPASS_REQUIRE prefer
end

