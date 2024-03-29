import os

from qutebrowser.config.configfiles import ConfigAPI
from qutebrowser.config.config import ConfigContainer
config: ConfigAPI = config
c: ConfigContainer = c

config.unbind("d", mode="normal")
config.unbind("r", mode="normal")
config.unbind("<Ctrl-w>", mode="normal")

config.set("content.javascript.enabled", True, "chrome://*/*")
config.set("content.javascript.enabled", True, "file://*")
config.set("content.javascript.enabled", True, "qute://*/*")
config.load_autoconfig(False)

session_name = os.environ.get('SESSION_NAME')

# Support for Russian layout
c.bindings.key_mappings = {
    "<Ctrl-[>": "<Escape>",
    "<Ctrl-6>": "<Ctrl-^>",
    "<Ctrl-M>": "<Return>",
    "<Ctrl-I>": "<Tab>",
    "<Shift-Return>": "<Return>",
    "<Enter>": "<Return>",
    "<Shift-Enter>": "<Return>",
    "<Ctrl-Enter>": "<Ctrl-Return>",
    "Й": "Q",
    "й": "q",
    "Ц": "W",
    "ц": "w",
    "У": "E",
    "у": "e",
    "К": "R",
    "к": "r",
    "Е": "T",
    "е": "t",
    "Н": "Y",
    "н": "y",
    "Г": "U",
    "г": "u",
    "Ш": "I",
    "ш": "i",
    "Щ": "O",
    "щ": "o",
    "З": "P",
    "з": "p",
    "Х": "{",
    "х": "[",
    "Ъ": "}",
    "ъ": "]",
    "Ф": "A",
    "ф": "a",
    "Ы": "S",
    "ы": "s",
    "В": "D",
    "в": "d",
    "А": "F",
    "а": "f",
    "П": "G",
    "п": "g",
    "Р": "H",
    "р": "h",
    "О": "J",
    "о": "j",
    "Л": "K",
    "л": "k",
    "Д": "L",
    "д": "l",
    "Ж": ":",
    "ж": ";",
    "Э": '"',
    "э": "\\",
    "Я": "Z",
    "я": "z",
    "Ч": "X",
    "ч": "x",
    "С": "C",
    "с": "c",
    "М": "V",
    "м": "v",
    "И": "B",
    "и": "b",
    "Т": "N",
    "т": "n",
    "Ь": "M",
    "ь": "m",
    "Б": "<",
    "б": ",",
    "Ю": ">",
    "ю": ".",
    ",": "?",
    ".": "/",
}

c.qt.force_software_rendering = "chromium"

c.editor.command = ["{{ conf.terminal }}", "-e", "nvim", "{}"]
c.editor.encoding = "utf-8"

c.aliases = {
    "proxym": "set content.proxy http://127.0.0.1:8080/",
    "noproxym": "set content.proxy system",
}

c.auto_save.session = True
c.auto_save.interval = 15000
c.zoom.default = "100%"
c.zoom.levels = [
    "25%",
    "33%",
    "50%",
    "67%",
    "75%",
    "90%",
    "100%",
    "110%",
    "125%",
    "140%",
    "150%",
    "175%",
    "200%",
    "250%",
    "300%",
    "400%",
    "500%",
]

c.completion.height = "20%"
c.completion.quick = False
c.completion.show = "auto"
c.completion.shrink = True
c.completion.timestamp_format = "%d-%m-%Y"
c.completion.use_best_match = False

c.confirm_quit = ["downloads"]

c.content.autoplay = False
c.content.blocking.method = "both"
c.content.cache.appcache = True
c.content.cache.size = 5242880
c.content.canvas_reading = True
c.content.cookies.store = True
c.content.geolocation = "ask"
c.content.javascript.enabled = True
c.content.mute = True
c.content.notifications.enabled = True
c.content.pdfjs = False
c.content.plugins = True
c.content.proxy = "none"
c.content.register_protocol_handler = True
c.content.tls.certificate_errors = "block"
c.content.webgl = True

c.downloads.location.directory = "~/Downloads"
c.downloads.location.prompt = False
c.downloads.location.remember = True
c.downloads.location.suggestion = "both"

c.hints.chars = "qwertyuiopasdfghjklzxcvbnm"
# c.hints.chars = "sdhjkrlba"
c.history_gap_interval = 30

c.input.insert_mode.auto_leave = True
c.input.insert_mode.auto_load = False
c.input.insert_mode.plugins = False
c.input.links_included_in_focus_chain = True
c.input.partial_timeout = 10000
c.input.spatial_navigation = False

c.keyhint.delay = 20

c.new_instance_open_target = "tab"
c.new_instance_open_target_window = "last-focused"

c.prompt.filebrowser = True

c.scrolling.bar = "always"
c.scrolling.smooth = True

c.search.ignore_case = "smart"

c.session.lazy_restore = True

c.statusbar.widgets = ["keypress", "url", "history", "tabs", "progress"]

c.tabs.background = True
c.tabs.last_close = "close"
c.tabs.new_position.related = "next"
c.tabs.new_position.unrelated = "last"
c.tabs.position = "left"
c.tabs.select_on_remove = "next"
c.tabs.show = "multiple"
c.tabs.tabs_are_windows = False
c.tabs.title.format = "{audio}{current_title}"
c.tabs.title.format_pinned = "{audio}"

c.url.auto_search = "dns"
c.url.default_page = "about:blank"
c.url.incdec_segments = ["path", "query"]
c.url.yank_ignored_parameters = [
    "ref",
    "utm_source",
    "utm_medium",
    "utm_campaign",
    "utm_term",
    "utm_content",
]
c.url.start_pages = ["about:blank"]

c.window.title_format = (
    "{private}{perc}{current_title}{title_sep}qutebrowser | {current_url}"
)

c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "g": "https://www.google.com/search?q={}",
    "y": "https://www.youtube.com/results?search_query={}",
    "aur": "https://aur.archlinux.org/packages/?O=0&K={}",
    "l": "https://www.ldoceonline.com/dictionary/{}",
    "w": "https://www.merriam-webster.com/dictionary/{}",
    "spell": "https://www.ldoceonline.com/spellcheck/english/?q={}",
    "t": "https://www.reverso.net/text-translation#sl=eng&tl=rus&text={}",
    "tr": "https://www.reverso.net/text-translation#tl=eng&sl=rus&text={}",
    "c": "https://context.reverso.net/translation/english-russian/{}",
    "cr": "https://context.reverso.net/translation/russian-english/{}",
    "j": "https://{{ conf.jira.company }}.atlassian.net/browse/{}",
}

c.bindings.default = {}

c.bindings.commands = {
    "normal": {
        # Extra
        "<space>c": "clear-messages",
        "<space>y": "open https://www.youtube.com/feed/subscriptions",
        "<space>g": "open https://github.com",
        "<space>pr": "proxym",
        "<space>ps": "noproxym",
        # Sessions
        "ss": "session-save -c",
        "sc": "set-cmd-text -s :session-save",
        "so": "session-save -c ;; set-cmd-text -s :session-load -c",
        "sd": "session-save -c ;; set-cmd-text -s :session-delete",
        "sq": "quit --save",
        # Default
        "<Escape>": "clear-keychain ;; search ;; fullscreen --leave",
        "<Ctrl-[>": "fake-key <Escape>",
        "/": "set-cmd-text /",
        "?": "set-cmd-text ?",
        ":": "set-cmd-text :",
        "i": "mode-enter insert",
        "<Ctrl-m>": "mode-enter insert",
        "v": "mode-enter caret",
        "V": "mode-enter caret ;; selection-toggle --line",
        "`": "mode-enter set_mark",
        "'": "mode-enter jump_mark",
        "<Ctrl-V>": "mode-enter passthrough",
        # "<Ctrl-Q>": "quit",
        "ZQ": "quit",
        "ZZ": "quit --save",
        "<Ctrl-c>": "stop",
        "<Return>": "selection-follow",
        "<Ctrl-Return>": "selection-follow -t",
        ".": "repeat-command",
        "q": "macro-record",
        "@": "macro-run",
        # GoTo
        "gs": "view-source",
        "gH": "history",
        "gB": "bookmark-list -t",
        # Goto-Tab
        "gt": "set-cmd-text -s :tab-select",
        # Opening
        # Open here
        "o": "set-cmd-text -s :open",
        "go": "set-cmd-text :open {url:pretty}",
        # Open in a new tab
        "O": "set-cmd-text -s :open -t",
        "gO": "set-cmd-text :open -t {url:pretty}",
        # Tabs
        "J": "tab-next",
        "K": "tab-prev",
        "t1": "tab-focus 1",
        "t2": "tab-focus 2",
        "t3": "tab-focus 3",
        "t4": "tab-focus 4",
        "t5": "tab-focus 5",
        "t6": "tab-focus 6",
        "t7": "tab-focus 7",
        "t8": "tab-focus 8",
        "t9": "tab-focus -1",
        "tB": "tab-give",
        "tC": "tab-clone",
        "tT": "set-cmd-text -s :tab-take",
        "tc": "tab-close",
        "th": "back -t",
        "tj": "tab-move +",
        "tk": "tab-move -",
        "tl": "forward -t",
        "tm": "tab-mute",
        "tn": "open -t",
        "to": "tab-only",
        "tp": "tab-pin",
        "tt": "config-cycle tabs.show multiple never",
        # Tabs-From
        "tf": "hint --rapid links tab-bg",
        # Deleting
        # "dd": "tab-close",
        "x": "tab-close",
        # Windows
        "wC": "open -w {url:pretty}",
        "wc": "close",
        "wh": "back -w",
        "wl": "forward -w",
        "wn": "open -w",
        "wo": "window-only",
        "wP": "open -p",
        "wb": "set-cmd-text -s :quickmark-load -w",
        "wp": "open -w -- {clipboard}",
        # Window-from
        "wf": "hint all window",
        # Reload
        "r": "reload",
        "R": "reload -f",
        # Navigation
        "H": "back",
        "<Ctrl-O>": "back",
        "<back>": "back",
        "L": "forward",
        "<forward>": "forward",
        "<Ctrl-I>": "forward",
        "h": "scroll left",
        "j": "scroll down",
        "k": "scroll up",
        "l": "scroll right",
        "u": "undo",
        "U": "undo -w",
        "gg": "scroll-to-perc 0",
        "G": "scroll-to-perc",
        "n": "search-next",
        "N": "search-prev",
        "-": "zoom-out",
        "+": "zoom-in",
        "=": "zoom",
# {% raw %}
        "[[": "navigate prev",
        "]]": "navigate next",
        "{{": "navigate prev -t",
        "}}": "navigate next -t",
# {% endraw %}
        "gu": "navigate up",
        "gU": "navigate up -t",
        "<Ctrl-A>": "navigate increment",
        "<Ctrl-X>": "navigate decrement",
        "<Ctrl-F>": "scroll-page 0 1",
        "<Ctrl-B>": "scroll-page 0 -1",
        "<Ctrl-D>": "scroll-page 0 0.5",
        "<Ctrl-U>": "scroll-page 0 -0.5",
        "<Ctrl-e>": "scroll-px 0 20",
        "<Ctrl-y>": "scroll-px 0 -20",
        # Hinting
        "f": "hint",
        "F": "hint all tab",
        "gh": "hint all hover",
        "gi": "hint inputs --first",
        "gI": "hint inputs",
        # Yanking
        "yy": "yank",
        "yt": "yank title",
        "yh": "yank domain",
        "yp": "yank pretty-url",
        "ym": "yank inline [{title}]({url})",
        "yd": "yank inline {url:host}",
        # Yank-from
        "yf": "hint links yank",
        "p": "open -- {clipboard}",
        "P": "open -t -- {clipboard}",
        "<space>pi": "spawn --userscript {{ conf.folders.bin }}/qute-bitwarden -d 'rofi_run -dmenu -i -p Bitwarden' --auto-lock 28800",
        "<space>pu": "spawn --userscript {{ conf.folders.bin }}/qute-bitwarden -d 'rofi_run -dmenu -i -p Bitwarden' -e --auto-lock 28800",
        "<space>pp": "spawn --userscript {{ conf.folders.bin }}/qute-bitwarden -d 'rofi_run -dmenu -i -p Bitwarden' -w --auto-lock 28800",
        "<space>pt": "spawn --userscript {{ conf.folders.bin }}/qute-bitwarden -d 'rofi_run -dmenu -i -p Bitwarden' -T --auto-lock 28800",
        "<space>pu": "spawn {{ conf.folders.bin }}/qb-bw sync",
        # "pw": "spawn --userscript qute_1pass --cache-session fill_credentials",
        # Bookmarks
        "m": "quickmark-save",
        "M": "bookmark-add",
        "b": "set-cmd-text -s :quickmark-load",
        "gb": "set-cmd-text -s :bookmark-load",
        "B": "set-cmd-text -s :quickmark-load -t",
        "gB": "set-cmd-text -s :bookmark-load -t",
        "bd": "set-cmd-text -s :quickmark-del",
        # Devtools
        "<space>ii": "devtools",
        "<space>ih": "devtools left",
        "<space>ij": "devtools bottom",
        "<space>ik": "devtools top",
        "<space>il": "devtools right",
        "<space>iw": "devtools window",
        "<space>if": "devtools-focus",
        # Downloads
        # Download-from
        "df": "hint links download",
        "dd": "set-cmd-text :download {url:pretty}",
        "do": "download-open",
        "dc": "download-cancel",
        "dC": "download-clear",
        "dr": "download-retry",
        # Toggler
        "<space>tj": "config-cycle -p -t -u {url} content.javascript.enabled ;; reload",
        "<space>tp": "config-cycle -p -t -u {url} content.plugins ;; reload",
        "<space>ti": "config-cycle -p -t -u {url} content.images ;; reload",
        "<space>tc": "config-cycle -p -t -u {url} content.cookies.accept all no-3rdparty never ;; reload",
        "<space>tI": "config-cycle -p -t -u *://{url:host}/* content.tls.certificate_errors load-insecurely block ;; reload",
        "<space>ts": "config-cycle -p -t colors.webpage.darkmode.enabled ;; reload",
    },
    "insert": {
        "<Ctrl-E>": "edit-text",
        "<Shift-Ins>": "insert-text -- {primary}",
        "<Escape>": "mode-leave",
        "<Shift-Escape>": "fake-key <Escape>",
        "<Ctrl-y>": "insert-text -- {clipboard}",
        "<Ctrl-W>": "fake-key <Ctrl-Backspace>",
        "<Ctrl-H>": "fake-key <Backspace>",
        "<Ctrl-A>": "fake-key <Home>",
        "<Ctrl-E>": "fake-key <End>",
        "<Alt-B>": "fake-key <Ctrl-Left>",
        "<Alt-F>": "fake-key <Ctrl-Right>",
        "<Ctrl-B>": "fake-key <Left>",
        "<Ctrl-F>": "fake-key <Right>",
        "<Ctrl-M>": "fake-key <Return>",
        "<Ctrl-J>": "fake-key <Down>",
        "<Ctrl-K>": "fake-key <Up>",
        "<Alt-Shift-u>": "spawn --userscript {{ conf.folders.bin }}/qute-bitwarden -d 'rofi_run -dmenu -i -l 20 -p Bitwarden' -n -e --auto-lock 28800",
        "<Alt-Shift-p>": "spawn --userscript {{ conf.folders.bin }}/qute-bitwarden -d 'rofi_run -dmenu -i -l 20 -p Bitwarden' -n -w --auto-lock 28800",
        "<Alt-Shift-t>": "spawn --userscript {{ conf.folders.bin }}/qute-bitwarden -d 'rofi_run -dmenu -i -l 20 -p Bitwarden' -n -T --auto-lock 28800",
        "<Alt-Shift-i>": "spawn --userscript {{ conf.folders.bin }}/qute-bitwarden -d 'rofi_run -dmenu -i -l 20 -p Bitwarden' -n --auto-lock 28800",
    },
    "hint": {
        "<Return>": "hint-follow",
        "<Ctrl-R>": "hint --rapid links tab-bg",
        "<Ctrl-F>": "hint links",
        "<Ctrl-B>": "hint all tab-bg",
        "<Escape>": "mode-leave",
    },
    "passthrough": {"<Shift-Escape>": "mode-leave"},
    "command": {
        "<Ctrl-j>": "completion-item-focus --history next",
        "<Ctrl-k>": "completion-item-focus --history prev",
        "<Ctrl-m>": "command-accept",
        "<Ctrl-P>": "command-history-prev",
        "<Ctrl-N>": "command-history-next",
        "<Up>": "completion-item-focus --history prev",
        "<Down>": "completion-item-focus --history next",
        "<Shift-Tab>": "completion-item-focus prev",
        "<Tab>": "completion-item-focus next",
        "<Ctrl-Tab>": "completion-item-focus next-category",
        "<Ctrl-Shift-Tab>": "completion-item-focus prev-category",
        "<PgDown>": "completion-item-focus next-page",
        "<PgUp>": "completion-item-focus prev-page",
        "<Ctrl-D>": "completion-item-del",
        "<Shift-Delete>": "completion-item-del",
        "<Ctrl-C>": "completion-item-yank",
        "<Ctrl-Shift-C>": "completion-item-yank --sel",
        "<Return>": "command-accept",
        "<Ctrl-Return>": "command-accept --rapid",
        "<Ctrl-B>": "rl-backward-char",
        "<Ctrl-F>": "rl-forward-char",
        "<Alt-B>": "rl-backward-word",
        "<Alt-F>": "rl-forward-word",
        "<Ctrl-A>": "rl-beginning-of-line",
        "<Ctrl-E>": "rl-end-of-line",
        "<Ctrl-U>": "rl-unix-line-discard",
        "<Alt-D>": "rl-kill-word",
        "<Ctrl-W>": 'rl-rubout " "',
        "<Ctrl-Shift-W>": "rl-filename-rubout",
        "<Alt-Backspace>": "rl-backward-kill-word",
        "<Ctrl-Y>": "rl-yank",
        "<Ctrl-?>": "rl-delete-char",
        "<Ctrl-H>": "rl-backward-delete-char",
        "<Escape>": "mode-leave",
    },
    "prompt": {
        "<Ctrl-K>": "prompt-item-focus prev",
        "<Ctrl-J>": "prompt-item-focus next",
        "<Ctrl-M>": "prompt-accept",
        "<Return>": "prompt-accept",
        "<Ctrl-X>": "prompt-open-download",
        "<Ctrl-P>": "prompt-open-download --pdfjs",
        "<Shift-Tab>": "prompt-item-focus prev",
        "<Up>": "prompt-item-focus prev",
        "<Tab>": "prompt-item-focus next",
        "<Down>": "prompt-item-focus next",
        "<Alt-Y>": "prompt-yank",
        "<Alt-Shift-Y>": "prompt-yank --sel",
        "<Ctrl-B>": "rl-backward-char",
        "<Ctrl-F>": "rl-forward-char",
        "<Alt-B>": "rl-backward-word",
        "<Alt-F>": "rl-forward-word",
        "<Ctrl-A>": "rl-beginning-of-line",
        "<Ctrl-E>": "rl-end-of-line",
        "<Ctrl-U>": "rl-unix-line-discard",
        "<Alt-D>": "rl-kill-word",
        "<Ctrl-W>": 'rl-rubout " "',
        "<Ctrl-Shift-W>": "rl-filename-rubout",
        "<Alt-Backspace>": "rl-backward-kill-word",
        "<Ctrl-?>": "rl-delete-char",
        "<Ctrl-H>": "rl-backward-delete-char",
        "<Ctrl-Y>": "rl-yank",
        "<Escape>": "mode-leave",
    },
    "yesno": {
        "<Ctrl-m>": "prompt-accept",
        "<Return>": "prompt-accept",
        "y": "prompt-accept yes",
        "n": "prompt-accept no",
        "Y": "prompt-accept --save yes",
        "N": "prompt-accept --save no",
        "<Alt-Y>": "prompt-yank",
        "<Alt-Shift-Y>": "prompt-yank --sel",
        "<Escape>": "mode-leave",
    },
    "caret": {
        "v": "selection-toggle",
        "V": "selection-toggle --line",
        "<Space>": "selection-toggle",
        "<Ctrl-Space>": "selection-drop",
        "c": "mode-enter normal",
        "j": "move-to-next-line",
        "k": "move-to-prev-line",
        "l": "move-to-next-char",
        "h": "move-to-prev-char",
        "e": "move-to-end-of-word",
        "w": "move-to-next-word",
        "b": "move-to-prev-word",
        "o": "selection-reverse",
        "]": "move-to-start-of-next-block",
        "[": "move-to-start-of-prev-block",
        "}": "move-to-end-of-next-block",
        "{": "move-to-end-of-prev-block",
        "0": "move-to-start-of-line",
        "$": "move-to-end-of-line",
        "gg": "move-to-start-of-document",
        "G": "move-to-end-of-document",
        "Y": "yank selection -s",
        "y": "yank selection",
        "<Return>": "yank selection",
        "H": "scroll left",
        "J": "scroll down",
        "K": "scroll up",
        "L": "scroll right",
        "<Escape>": "mode-leave",
    },
    "register": {"<Escape>": "mode-leave"},
}

# Fonts

c.fonts.completion.entry = "{{ conf.theme.monospace_font_size }}px {{ conf.theme.monospace_font }}"
c.fonts.completion.category = "{{ conf.theme.monospace_font_size }}px {{ conf.theme.monospace_font }}"
c.fonts.debug_console = "{{ conf.theme.monospace_font_size }}px {{ conf.theme.monospace_font }}"
c.fonts.downloads = "{{ conf.theme.monospace_font_size }}px {{ conf.theme.monospace_font }}"
c.fonts.hints = "{{ conf.theme.monospace_font_size }}px {{ conf.theme.monospace_font }}"
c.fonts.keyhint = "{{ conf.theme.monospace_font_size }}px {{ conf.theme.monospace_font }}"
c.fonts.messages.info = "{{ conf.theme.monospace_font_size }}px {{ conf.theme.monospace_font }}"
c.fonts.messages.error = "{{ conf.theme.monospace_font_size }}px {{ conf.theme.monospace_font }}"
c.fonts.prompts = "{{ conf.theme.monospace_font_size }}px {{ conf.theme.monospace_font }}"
c.fonts.statusbar = "{{ conf.theme.monospace_font_size }}px {{ conf.theme.monospace_font }}"

# base16-qutebrowser (https://github.com/theova/base16-qutebrowser)
# Base16 qutebrowser template by theova
# OneDark scheme by Lalit Magant (http://github.com/tilal6991)

base00 = "#{{ conf.colors.base00 }}"
base01 = "#{{ conf.colors.base01 }}"
base02 = "#{{ conf.colors.base02 }}"
base03 = "#{{ conf.colors.base03 }}"
base04 = "#{{ conf.colors.base04 }}"
base05 = "#{{ conf.colors.base05 }}"
base06 = "#{{ conf.colors.base06 }}"
base07 = "#{{ conf.colors.base07 }}"
base08 = "#{{ conf.colors.base08 }}"
base09 = "#{{ conf.colors.base09 }}"
base0A = "#{{ conf.colors.base0A }}"
base0B = "#{{ conf.colors.base0B }}"
base0C = "#{{ conf.colors.base0C }}"
base0D = "#{{ conf.colors.base0D }}"
base0E = "#{{ conf.colors.base0E }}"
base0F = "#{{ conf.colors.base0F }}"

# set qutebrowser colors

c.colors.webpage.preferred_color_scheme = "dark"
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.policy.images = "never"
c.colors.webpage.darkmode.algorithm = "lightness-cielab"
c.colors.webpage.darkmode.contrast = 0.2

# Text color of the completion widget. May be a single color to use for
# all columns or a list of three colors, one for each column.
c.colors.completion.fg = base05
c.colors.completion.odd.bg = base01
c.colors.completion.even.bg = base00
c.colors.completion.category.fg = base0A
c.colors.completion.category.bg = base00
c.colors.completion.category.border.top = base00
c.colors.completion.category.border.bottom = base00
c.colors.completion.item.selected.fg = base05
c.colors.completion.item.selected.bg = base02
c.colors.completion.item.selected.border.top = base02
c.colors.completion.item.selected.border.bottom = base02
c.colors.completion.item.selected.match.fg = base0B
c.colors.completion.match.fg = base0B
c.colors.completion.scrollbar.fg = base05
c.colors.completion.scrollbar.bg = base00
c.colors.contextmenu.disabled.bg = base01
c.colors.contextmenu.disabled.fg = base04
c.colors.contextmenu.menu.bg = base00
c.colors.contextmenu.menu.fg = base05
c.colors.contextmenu.selected.bg = base02
c.colors.contextmenu.selected.fg = base05
c.colors.downloads.bar.bg = base00
c.colors.downloads.start.fg = base00
c.colors.downloads.start.bg = base0D
c.colors.downloads.stop.fg = base00
c.colors.downloads.stop.bg = base0C
c.colors.downloads.error.fg = base08
c.colors.hints.fg = base00
c.colors.hints.bg = base0A
c.colors.hints.match.fg = base05
c.colors.keyhint.fg = base05
c.colors.keyhint.suffix.fg = base05
c.colors.keyhint.bg = base00
c.colors.messages.error.fg = base00
c.colors.messages.error.bg = base08
c.colors.messages.error.border = base08
c.colors.messages.warning.fg = base00
c.colors.messages.warning.bg = base0E
c.colors.messages.warning.border = base0E
c.colors.messages.info.fg = base05
c.colors.messages.info.bg = base00
c.colors.messages.info.border = base00
c.colors.prompts.fg = base05
c.colors.prompts.border = base00
c.colors.prompts.bg = base00
c.colors.prompts.selected.bg = base02

c.colors.statusbar.normal.fg = base0B
c.colors.statusbar.normal.bg = base00
c.colors.statusbar.insert.fg = base00
c.colors.statusbar.insert.bg = base0D
c.colors.statusbar.passthrough.fg = base00
c.colors.statusbar.passthrough.bg = base0C
c.colors.statusbar.private.fg = base00
c.colors.statusbar.private.bg = base02
c.colors.statusbar.command.fg = base05
c.colors.statusbar.command.bg = base00
c.colors.statusbar.command.private.fg = base05
c.colors.statusbar.command.private.bg = base00
c.colors.statusbar.caret.fg = base00
c.colors.statusbar.caret.bg = base0E
c.colors.statusbar.caret.selection.fg = base00
c.colors.statusbar.caret.selection.bg = base0D
c.colors.statusbar.progress.bg = base0D
c.colors.statusbar.url.fg = base05
c.colors.statusbar.url.error.fg = base08
c.colors.statusbar.url.hover.fg = base05
c.colors.statusbar.url.success.http.fg = base0C
c.colors.statusbar.url.success.https.fg = base0B
c.colors.statusbar.url.warn.fg = base0E
c.colors.tabs.bar.bg = base00
c.colors.tabs.indicator.start = base0D
c.colors.tabs.indicator.stop = base0C
c.colors.tabs.indicator.error = base08

if session_name == "work":
    c.colors.tabs.odd.fg = base00
    c.colors.tabs.odd.bg = base08
    c.colors.tabs.even.fg = base00
    c.colors.tabs.even.bg = base0F
    c.colors.tabs.pinned.even.bg = base0F
    c.colors.tabs.pinned.even.fg = base00
    c.colors.tabs.pinned.odd.bg = base0F
    c.colors.tabs.pinned.odd.fg = base00
else:
    c.colors.tabs.odd.fg = base05
    c.colors.tabs.odd.bg = base01
    c.colors.tabs.even.fg = base05
    c.colors.tabs.even.bg = base00
    c.colors.tabs.pinned.even.bg = base03
    c.colors.tabs.pinned.even.fg = base00
    c.colors.tabs.pinned.odd.bg = base03
    c.colors.tabs.pinned.odd.fg = base00

c.colors.tabs.pinned.selected.even.bg = base0E
c.colors.tabs.pinned.selected.even.fg = base00
c.colors.tabs.pinned.selected.odd.bg = base0E
c.colors.tabs.pinned.selected.odd.fg = base00
c.colors.tabs.selected.odd.fg = base00
c.colors.tabs.selected.odd.bg = base0E
c.colors.tabs.selected.even.fg = base00
c.colors.tabs.selected.even.bg = base0E

# Background color for webpages if unset (or empty to use the theme's
# color).
# c.colors.webpage.bg = base00
