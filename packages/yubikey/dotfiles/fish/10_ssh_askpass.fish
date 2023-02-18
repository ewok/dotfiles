if test -z $TB
  set -gx SSH_ASKPASS /usr/lib/seahorse/ssh-askpass
  set -gx SSH_ASKPASS_REQUIRE prefer
end

