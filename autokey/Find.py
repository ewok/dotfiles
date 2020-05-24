if window.get_active_class() != 'termite.Termite':
    keyboard.send_keys("<ctrl>+f")
else:
    keyboard.send_keys("<ctrl>+<shift>+f")
