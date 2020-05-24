if window.get_active_class() != 'termite.Termite':
    keyboard.send_keys("<ctrl>+a")
else:
    keyboard.send_keys("<ctrl>+<shift>+a")
