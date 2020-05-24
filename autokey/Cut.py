if window.get_active_class() != 'termite.Termite':
    keyboard.send_keys("<ctrl>+x")
else:
    keyboard.send_keys("<shift>+<delete>")
