# Config example

local_vars.yaml:

```yaml
variables:
  user: "user-name"
  bin: "{{@@ env['HOME'] @@}}/.local/bin"
  pm: "yay -S --needed --nocleanmenu --nodiffmenu --noconfirm --noeditmenu --nouseask --noupgrademenu"
  accounts_home_path: "/"
  accounts_home_email: "my@home.email"
  accounts_work_path: "~/work/"
  accounts_work_email: "my@work.email"
  terminal: "alacritty"
  full_name: "Anonymous User"
  weather_api_token: "my-api-token"
  weather_city: "London"
  weather_city_id: "2643743"
  separator_left: ""
  separator_right: ""
  alt_separator_left: ""
  alt_separator_right: ""
  theme: "onedark" # "dracula", "nord", "tokyonight"
  colors:

    # # Dracula
    # base00: "282936"
    # base01: "3a3c4e"
    # base02: "4d4f68"
    # base03: "626483"
    # base04: "62d6e8"
    # base05: "e9e9f4"
    # base06: "f1f2f8"
    # base07: "f7f7fb"
    # base08: "ea51b2"
    # base09: "b45bcf"
    # base0A: "00f769"
    # base0B: "ebff87"
    # base0C: "a1efe4"
    # base0D: "62d6e8"
    # base0E: "b45bcf"
    # base0F: "00f769"

    # # Nord
    # base00: "2E3440"
    # base01: "3B4252"
    # base02: "434C5E"
    # base03: "4C566A"
    # base04: "D8DEE9"
    # base05: "E5E9F0"
    # base06: "ECEFF4"
    # base07: "8FBCBB"
    # base08: "88C0D0"
    # base09: "81A1C1"
    # base0A: "5E81AC"
    # base0B: "BF616A"
    # base0C: "D08770"
    # base0D: "EBCB8B"
    # base0E: "A3BE8C"
    # base0F: "B48EAD"

    # # Tokyo Night
    # base00: "24283b"
    # base01: "1f2335"
    # base02: "292e42"
    # base03: "565f89"
    # base04: "a9b1d6"
    # base05: "c0caf5"
    # base06: "c0caf5"
    # base07: "c0caf5"
    # base08: "f7768e"
    # base09: "ff9e64"
    # base0A: "e0af68"
    # base0B: "9ece6a"
    # base0C: "1abc9c"
    # base0D: "41a6b5"
    # base0E: "bb9af7"
    # base0F: "ff007c"

    # Onedark
    base00: "282c34"  # #282c34
    base01: "353b45"  # #353b45
    base02: "3e4451"  # #3e4451
    base03: "545862"  # #545862
    base04: "565c64"  # #565c64
    base05: "abb2bf"  # #abb2bf
    base06: "b6bdca"  # #b6bdca
    base07: "c8ccd4"  # #c8ccd4
    base08: "e06c75"  # #e06c75
    base09: "d19a66"  # #d19a66
    base0A: "e5c07b"  # #e5c07b
    base0B: "98c379"  # #98c379
    base0C: "56b6c2"  # #56b6c2
    base0D: "61afef"  # #61afef
    base0E: "c678dd"  # #c678dd
    base0F: "be5046"  # #be5046

  regular_font: "FiraMono Nerd Font"
  regular_font_size: 10
  monospace_font: "FiraMono Nerd Font Mono"
  monospace_font_size: 10
  licenses:
    cryptomator: "my-cryptomator-license"
  rslsync:
    user: "user"
    password: "password"
  backup:
    repo: "rclone:backup:share/workstations"
    paths:
      - "/etc"
      - "/home/{{@@ user @@}}/.aws"
      - "/home/{{@@ user @@}}/.gnupg"
      - "/home/{{@@ user @@}}/.ssh"
      - "/home/{{@@ user @@}}/.subversion"
      - "/home/{{@@ user @@}}/Desktop"
      - "/home/{{@@ user @@}}/Documents"
  ssh:
    - name: github
      hostname: "github.com"
      identity_file: "~/.ssh/id_rsa"
    - name: gate
      hostname: "192.168.1.1"
      user: "root"
    - name: "*+*"
      proxy_command: |
        ssh -W (echo %h | sed 's/^.*+//;s/^\([^:]*$\)/\1:22/') (echo %h | sed 's/+[^+]*$//;s/\([^+%%]*\)%%\([^+]*\)$/\2 -l \1/;s/:\([^:+]*\)$/ -p \1/')
      control_path: "/tmp/%h"
      control_master: "yes"
    - name: ip-10-*.eu-west-1.compute.internal 10.*
      user: ubuntu
      identity_file: ~/.ssh/work.pem
      extra: |
        PubkeyAcceptedKeyTypes=+ssh-rsa
        HostKeyAlgorithms=+ssh-rsa
    - name: ip-172-*.eu-west-1.compute.internal 172.*
      user: ec2-user
      identity_file: ~/.ssh/work.pem
      extra: |
        PubkeyAcceptedKeyTypes=+ssh-rsa
        HostKeyAlgorithms=+ssh-rsa
```
