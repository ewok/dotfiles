if window.get_active_class() != 'termite.Termite':
    keyboard.send_keys("<ctrl>+c")
else:
    keyboard.send_keys("<ctrl>+<insert>")