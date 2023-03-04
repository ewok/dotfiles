config.unbind("d", mode="normal")
config.unbind("r", mode="normal")
config.unbind("<Ctrl-w>", mode="normal")

config.set("content.javascript.enabled", True, "chrome://*/*")
config.set("content.javascript.enabled", True, "file://*")
config.set("content.javascript.enabled", True, "qute://*/*")
config.load_autoconfig(False)

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

c.editor.command = ["{{@@ terminal @@}}", "-e", "nvim", "{}"]
c.editor.encoding = "utf-8"

c.aliases = {
    "jsd": "set content.javascript.enabled false",
    "jse": "set content.javascript.enabled true",
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
c.content.cache.appcache = True
c.content.cache.size = 5242880
c.content.canvas_reading = True
c.content.cookies.store = True
c.content.geolocation = "ask"
c.content.javascript.enabled = True
c.content.mute = True
c.content.notifications.enabled = True
c.content.pdfjs = True
c.content.plugins = True
c.content.proxy = "none"
c.content.register_protocol_handler = True
c.content.tls.certificate_errors = "block"
c.content.webgl = True

c.downloads.location.directory = "~/Downloads"
c.downloads.location.prompt = False
c.downloads.location.remember = True
c.downloads.location.suggestion = "both"

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
    "DEFAULT": "https://www.google.com/search?q={}",
    "d": "https://duckduckgo.com/?q={}",
    "n": "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&query={}",
    "y": "https://www.youtube.com/results?search_query={}",
    "w": "https://www.merriam-webster.com/dictionary/{}",
    "aur": "https://aur.archlinux.org/packages/?O=0&K={}",
}

c.bindings.default = {}

c.bindings.commands = {
    "normal": {
        # Extra
        "<space>c": "clear-messages",
        "<space>gm": "open https://mail.google.com",
        "<space>gc": "open https://calendar.google.com",
        "<space>gy": "open https://youtube.com",
        "<space>gg": "open https://google.com",
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
        "/": "set-cmd-text /",
        "?": "set-cmd-text ?",
        ":": "set-cmd-text :",
        "i": "mode-enter insert",
        "v": "mode-enter caret",
        "V": "mode-enter caret ;; selection-toggle --line",
        "`": "mode-enter set_mark",
        "'": "mode-enter jump_mark",
        "<Ctrl-V>": "mode-enter passthrough",
        # "<Ctrl-Q>": "quit",
        "ZQ": "quit",
        "ZZ": "quit --save",
        "<Ctrl-h>": "home",
        "<Ctrl-s>": "stop",
        "<Return>": "selection-follow",
        "<Ctrl-Return>": "selection-follow -t",
        ".": "repeat-command",
        "q": "macro-record",
        "@": "macro-run",

        # GoTo
        "gs": "view-source",
        "gh": "history",

        # Opening
        "oo": "set-cmd-text -s :open",
        "oO": "set-cmd-text :open {url:pretty}",
        "ot": "set-cmd-text -s :open -t",
        "oT": "set-cmd-text :open -t -r {url:pretty}",
        "ob": "set-cmd-text -s :open -b",
        "oB": "set-cmd-text :open -b -r {url:pretty}",
        "ow": "set-cmd-text -s :open -w",
        "oW": "set-cmd-text :open -w {url:pretty}",

        # Tabs
        "tt": "config-cycle tabs.show multiple never",
        "tn": "open -t",
        "to": "tab-only",
        "tk": "tab-move -",
        "tj": "tab-move +",
        "J": "tab-next",
        "K": "tab-prev",
        "tC": "tab-clone",
        ## Navigation
        "th": "back -t",
        "tl": "forward -t",
        "tf": "set-cmd-text -s :tab-select",
        "t1": "tab-focus 1",
        "t2": "tab-focus 2",
        "t3": "tab-focus 3",
        "t4": "tab-focus 4",
        "t5": "tab-focus 5",
        "t6": "tab-focus 6",
        "t7": "tab-focus 7",
        "t8": "tab-focus 8",
        "t9": "tab-focus -1",
        "tp": "tab-pin",
        "tm": "tab-mute",

        "tB": "tab-give",
        "tT": "set-cmd-text -s :tab-take",

        # Deleting
        # "dd": "tab-close",
        "x": "tab-close",

        # Windows
        "wn": "open -w",
        "wP": "open -p",
        ## Navigation
        "wh": "back -w",
        "wl": "forward -w",
        "wc": "close",
        "wq": "close",
        "<Ctrl-W>c": "close",
        "<Ctrl-W>q": "close",

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
        "[[": "navigate prev",
        "]]": "navigate next",
        "{{": "navigate prev -t",
        "}}": "navigate next -t",
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
        "ff": "hint",
        "fF": "hint links fill :open {hint-url}",
        "ft": "hint all tab",
        "fT": "hint links fill :open -t -r {hint-url}",
        "fw": "hint all window",
        "fW": "hint links fill :open -w -r {hint-url}",

        "fh": "hint all hover",
        "fI": "hint images",
        "fy": "hint links yank",
        "fr": "hint --rapid links tab-bg",

        "fd": "hint links download",

        "fi": "hint inputs",
        "gi": "hint inputs --first",

        # Yanking
        "yy": "yank",
        "yt": "yank title",
        "yh": "yank domain",
        "yp": "yank pretty-url",
        "ym": "yank inline [{title}]({url})",
        "yd": "yank inline {url:host}",

        "pp": "open -- {clipboard}",
        "pt": "open -t -- {clipboard}",
        "pw": "open -w -- {clipboard}",
        # "pw": "spawn --userscript qute_1pass --cache-session fill_credentials",

        # Bookmarks
        "bs": "quickmark-save",
        "bl": "bookmark-list -t",
        "bb": "set-cmd-text -s :quickmark-load",
        "bt": "set-cmd-text -s :quickmark-load -t",
        "bw": "set-cmd-text -s :quickmark-load -w",
        "BS": "bookmark-add",
        "BL": "bookmark-list -t",
        "BB": "set-cmd-text -s :bookmark-load",
        "BT": "set-cmd-text -s :bookmark-load -t",
        "BW": "set-cmd-text -s :bookmark-load -w",


        # Devtools
        "II": "devtools",
        "IH": "devtools left",
        "IJ": "devtools bottom",
        "IK": "devtools top",
        "IL": "devtools right",
        "IW": "devtools window",
        "IF": "devtools-focus",

        # Downloads
        "dd": "hint links download",
        "dD": "set-cmd-text :download {url:pretty}",
        "do": "download-open",
        "dc": "download-cancel",
        "dC": "download-clear",
        "dr": "download-retry",

        # Toggler
        "Ts": "config-cycle -p -t -u {url} content.javascript.enabled ;; reload",
        "Tp": "config-cycle -p -t -u {url} content.plugins ;; reload",
        "Ti": "config-cycle -p -t -u {url} content.images ;; reload",
        "Tc": "config-cycle -p -t -u {url} content.cookies.accept all no-3rdparty never ;; reload",
        "TI": "config-cycle -p -t -u *://{url:host}/* content.tls.certificate_errors load-insecurely block ;; reload",
    },
    "insert": {
        "<Ctrl-E>": "edit-text",
        "<Shift-Ins>": "insert-text -- {primary}",
        "<Escape>": "mode-leave",
        "<Shift-Escape>": "fake-key <Escape>",
        "<Ctrl-y>": "insert-text -- {clipboard}",
        # "<Alt-Shift-u>": "spawn --userscript qute_1pass --cache-session fill_username",
        # "<Alt-Shift-p>": "spawn --userscript qute_1pass --cache-session fill_password",
        "<Alt-Shift-t>": "spawn ykman-otp",
        # "<Alt-Shift-t>" = "spawn --userscript qute_1pass --cache-session fill_totp";
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

c.fonts.completion.entry = "{{@@ monospace_font_size @@}}px {{@@ monospace_font @@}}"
c.fonts.completion.category = "{{@@ monospace_font_size @@}}px {{@@ monospace_font @@}}"
c.fonts.debug_console = "{{@@ monospace_font_size @@}}px {{@@ monospace_font @@}}"
c.fonts.downloads = "{{@@ monospace_font_size @@}}px {{@@ monospace_font @@}}"
c.fonts.hints = "{{@@ monospace_font_size @@}}px {{@@ monospace_font @@}}"
c.fonts.keyhint = "{{@@ monospace_font_size @@}}px {{@@ monospace_font @@}}"
c.fonts.messages.info = "{{@@ monospace_font_size @@}}px {{@@ monospace_font @@}}"
c.fonts.messages.error = "{{@@ monospace_font_size @@}}px {{@@ monospace_font @@}}"
c.fonts.prompts = "{{@@ monospace_font_size @@}}px {{@@ monospace_font @@}}"
c.fonts.statusbar = "{{@@ monospace_font_size @@}}px {{@@ monospace_font @@}}"

# base16-qutebrowser (https://github.com/theova/base16-qutebrowser)
# Base16 qutebrowser template by theova
# OneDark scheme by Lalit Magant (http://github.com/tilal6991)

base00 = "#{{@@ colors.base00 @@}}"
base01 = "#{{@@ colors.base01 @@}}"
base02 = "#{{@@ colors.base02 @@}}"
base03 = "#{{@@ colors.base03 @@}}"
base04 = "#{{@@ colors.base04 @@}}"
base05 = "#{{@@ colors.base05 @@}}"
base06 = "#{{@@ colors.base06 @@}}"
base07 = "#{{@@ colors.base07 @@}}"
base08 = "#{{@@ colors.base08 @@}}"
base09 = "#{{@@ colors.base09 @@}}"
base0A = "#{{@@ colors.base0A @@}}"
base0B = "#{{@@ colors.base0B @@}}"
base0C = "#{{@@ colors.base0C @@}}"
base0D = "#{{@@ colors.base0D @@}}"
base0E = "#{{@@ colors.base0E @@}}"
base0F = "#{{@@ colors.base0F @@}}"

# set qutebrowser colors

c.colors.webpage.preferred_color_scheme = "dark"
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.policy.images = "never"
c.colors.webpage.darkmode.algorithm = "lightness-cielab"

c.colors.tabs.even.bg = base04
c.colors.tabs.even.fg = base0D
c.colors.tabs.odd.bg = base01
c.colors.tabs.odd.fg = c.colors.tabs.even.fg
c.colors.tabs.bar.bg = base02

# Text color of the completion widget. May be a single color to use for
# all columns or a list of three colors, one for each column.
c.colors.completion.fg = base05

# Background color of the completion widget for odd rows.
c.colors.completion.odd.bg = base01

# Background color of the completion widget for even rows.
c.colors.completion.even.bg = base00

# Foreground color of completion widget category headers.
c.colors.completion.category.fg = base0A

# Background color of the completion widget category headers.
c.colors.completion.category.bg = base00

# Top border color of the completion widget category headers.
c.colors.completion.category.border.top = base00

# Bottom border color of the completion widget category headers.
c.colors.completion.category.border.bottom = base00

# Foreground color of the selected completion item.
c.colors.completion.item.selected.fg = base05

# Background color of the selected completion item.
c.colors.completion.item.selected.bg = base02

# Top border color of the selected completion item.
c.colors.completion.item.selected.border.top = base02

# Bottom border color of the selected completion item.
c.colors.completion.item.selected.border.bottom = base02

# Foreground color of the matched text in the selected completion item.
c.colors.completion.item.selected.match.fg = base0B

# Foreground color of the matched text in the completion.
c.colors.completion.match.fg = base0B

# Color of the scrollbar handle in the completion view.
c.colors.completion.scrollbar.fg = base05

# Color of the scrollbar in the completion view.
c.colors.completion.scrollbar.bg = base00

# Background color of disabled items in the context menu.
c.colors.contextmenu.disabled.bg = base01

# Foreground color of disabled items in the context menu.
c.colors.contextmenu.disabled.fg = base04

# Background color of the context menu. If set to null, the Qt default is used.
c.colors.contextmenu.menu.bg = base00

# Foreground color of the context menu. If set to null, the Qt default is used.
c.colors.contextmenu.menu.fg = base05

# Background color of the context menu’s selected item. If set to null, the Qt default is used.
c.colors.contextmenu.selected.bg = base02

# Foreground color of the context menu’s selected item. If set to null, the Qt default is used.
c.colors.contextmenu.selected.fg = base05

# Background color for the download bar.
c.colors.downloads.bar.bg = base00

# Color gradient start for download text.
c.colors.downloads.start.fg = base00

# Color gradient start for download backgrounds.
c.colors.downloads.start.bg = base0D

# Color gradient end for download text.
c.colors.downloads.stop.fg = base00

# Color gradient stop for download backgrounds.
c.colors.downloads.stop.bg = base0C

# Foreground color for downloads with errors.
c.colors.downloads.error.fg = base08

# Font color for hints.
c.colors.hints.fg = base00

# Background color for hints. Note that you can use a `rgba(...)` value
# for transparency.
c.colors.hints.bg = base0A

# Font color for the matched part of hints.
c.colors.hints.match.fg = base05

# Text color for the keyhint widget.
c.colors.keyhint.fg = base05

# Highlight color for keys to complete the current keychain.
c.colors.keyhint.suffix.fg = base05

# Background color of the keyhint widget.
c.colors.keyhint.bg = base00

# Foreground color of an error message.
c.colors.messages.error.fg = base00

# Background color of an error message.
c.colors.messages.error.bg = base08

# Border color of an error message.
c.colors.messages.error.border = base08

# Foreground color of a warning message.
c.colors.messages.warning.fg = base00

# Background color of a warning message.
c.colors.messages.warning.bg = base0E

# Border color of a warning message.
c.colors.messages.warning.border = base0E

# Foreground color of an info message.
c.colors.messages.info.fg = base05

# Background color of an info message.
c.colors.messages.info.bg = base00

# Border color of an info message.
c.colors.messages.info.border = base00

# Foreground color for prompts.
c.colors.prompts.fg = base05

# Border used around UI elements in prompts.
c.colors.prompts.border = base00

# Background color for prompts.
c.colors.prompts.bg = base00

# Background color for the selected item in filename prompts.
c.colors.prompts.selected.bg = base02

# Foreground color of the statusbar.
c.colors.statusbar.normal.fg = base0B

# Background color of the statusbar.
c.colors.statusbar.normal.bg = base00

# Foreground color of the statusbar in insert mode.
c.colors.statusbar.insert.fg = base00

# Background color of the statusbar in insert mode.
c.colors.statusbar.insert.bg = base0D

# Foreground color of the statusbar in passthrough mode.
c.colors.statusbar.passthrough.fg = base00

# Background color of the statusbar in passthrough mode.
c.colors.statusbar.passthrough.bg = base0C

# Foreground color of the statusbar in private browsing mode.
c.colors.statusbar.private.fg = base00

# Background color of the statusbar in private browsing mode.
c.colors.statusbar.private.bg = base01

# Foreground color of the statusbar in command mode.
c.colors.statusbar.command.fg = base05

# Background color of the statusbar in command mode.
c.colors.statusbar.command.bg = base00

# Foreground color of the statusbar in private browsing + command mode.
c.colors.statusbar.command.private.fg = base05

# Background color of the statusbar in private browsing + command mode.
c.colors.statusbar.command.private.bg = base00

# Foreground color of the statusbar in caret mode.
c.colors.statusbar.caret.fg = base00

# Background color of the statusbar in caret mode.
c.colors.statusbar.caret.bg = base0E

# Foreground color of the statusbar in caret mode with a selection.
c.colors.statusbar.caret.selection.fg = base00

# Background color of the statusbar in caret mode with a selection.
c.colors.statusbar.caret.selection.bg = base0D

# Background color of the progress bar.
c.colors.statusbar.progress.bg = base0D

# Default foreground color of the URL in the statusbar.
c.colors.statusbar.url.fg = base05

# Foreground color of the URL in the statusbar on error.
c.colors.statusbar.url.error.fg = base08

# Foreground color of the URL in the statusbar for hovered links.
c.colors.statusbar.url.hover.fg = base05

# Foreground color of the URL in the statusbar on successful load
# (http).
c.colors.statusbar.url.success.http.fg = base0C

# Foreground color of the URL in the statusbar on successful load
# (https).
c.colors.statusbar.url.success.https.fg = base0B

# Foreground color of the URL in the statusbar when there's a warning.
c.colors.statusbar.url.warn.fg = base0E

# Background color of the tab bar.
c.colors.tabs.bar.bg = base00

# Color gradient start for the tab indicator.
c.colors.tabs.indicator.start = base0D

# Color gradient end for the tab indicator.
c.colors.tabs.indicator.stop = base0C

# Color for the tab indicator on errors.
c.colors.tabs.indicator.error = base08

# Foreground color of unselected odd tabs.
c.colors.tabs.odd.fg = base05

# Background color of unselected odd tabs.
c.colors.tabs.odd.bg = base01

# Foreground color of unselected even tabs.
c.colors.tabs.even.fg = base05

# Background color of unselected even tabs.
c.colors.tabs.even.bg = base00

# Background color of pinned unselected even tabs.
c.colors.tabs.pinned.even.bg = base0C

# Foreground color of pinned unselected even tabs.
c.colors.tabs.pinned.even.fg = base07

# Background color of pinned unselected odd tabs.
c.colors.tabs.pinned.odd.bg = base0B

# Foreground color of pinned unselected odd tabs.
c.colors.tabs.pinned.odd.fg = base07

# Background color of pinned selected even tabs.
c.colors.tabs.pinned.selected.even.bg = base02

# Foreground color of pinned selected even tabs.
c.colors.tabs.pinned.selected.even.fg = base05

# Background color of pinned selected odd tabs.
c.colors.tabs.pinned.selected.odd.bg = base02

# Foreground color of pinned selected odd tabs.
c.colors.tabs.pinned.selected.odd.fg = base05

# Foreground color of selected odd tabs.
c.colors.tabs.selected.odd.fg = base05

# Background color of selected odd tabs.
c.colors.tabs.selected.odd.bg = base02

# Foreground color of selected even tabs.
c.colors.tabs.selected.even.fg = base05

# Background color of selected even tabs.
c.colors.tabs.selected.even.bg = base02

# Background color for webpages if unset (or empty to use the theme's
# color).
# c.colors.webpage.bg = base00
