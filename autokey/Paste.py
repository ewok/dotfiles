if window.get_active_class() != 'termite.Termite':
    keyboard.send_keys("<ctrl>+v")
else:
    keyboard.send_keys("<shift>+<insert>")

