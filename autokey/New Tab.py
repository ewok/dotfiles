if window.get_active_class() == 'Navigator.firefox':
    keyboard.send_keys("<ctrl>+t")
elif window.get_active_class() == 'termite.Termite':
    keyboard.send_keys("`c")
