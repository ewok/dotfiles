from ranger.api.commands import Command

class paste_as_root(Command):
	def execute(self):
		if self.fm.do_cut:
			self.fm.execute_console('shell sudo mv %c .')
		else:
			self.fm.execute_console('shell sudo cp -r %c .')

class fzf_select(Command):
    """
    :fzf_select

    Find a file using fzf.

    With a prefix argument select only directories.

    See: https://github.com/junegunn/fzf
    """
    def execute(self):
        import subprocess
        import os.path
        if self.quantifier:
            # match only directories
            command="find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune \
            -o -type d -print 2> /dev/null | sed 1d | cut -b3- | fzf +m --reverse --header='Jump to file'"
        else:
            # match files and directories
            command="find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune \
            -o -print 2> /dev/null | sed 1d | cut -b3- | fzf +m --reverse --header='Jump to filemap <C-f> fzf_select'"
        fzf = self.fm.execute_command(command, universal_newlines=True, stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.rstrip('\n'))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)

class zip(Command):
    def execute(self):
        # Run a shell command.
        for f in self.fm.thistab.get_selection():
            self.fm.run(['zip', '-r', ".".join([f.basename,'zip']), f.relative_path])

class zipto(Command):
    def execute(self):
        if not self.arg(1):
            self.fm.notify('Wrong number of arguments', bad=True)
            return
        # First argument. 0 is the command name.
        # self.fm.notify(self.arg(1))

        for f in self.fm.thistab.get_selection():
            self.fm.notify("Working on {0}".format(self.arg(1)))
            self.fm.run(['zip', '-r', ".".join([self.arg(1),'zip']), f.relative_path])
        # # Run a shell command.
        # self.fm.run(['zip', '-r', ".".join([self.arg(1),'zip']), " ".join([f.relative_path for f in self.fm.thistab.get_selection()]), '>debug'])

