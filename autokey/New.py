if window.get_active_class() != 'termite.Termite':
    keyboard.send_keys("<ctrl>+<shift>+n")
else:
    keyboard.send_keys("<super>+<enter>")