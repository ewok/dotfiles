if window.get_active_class() == 'Navigator.firefox':
    keyboard.send_keys("<ctrl>+w")
elif window.get_active_class() == 'termite.Termite':
    keyboard.send_keys("<ctrl>+d")