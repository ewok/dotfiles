import os
from datetime import datetime
from ranger.ext.human_readable import human_readable

terminal=terminal=os.getenv('TERM')
if terminal != 'linux':
  import ranger.api
  from ranger.core.linemode import LinemodeBase
  from devicons import *

  @ranger.api.register_linemode
  class DevIconsLinemode(LinemodeBase):
    name = "devicons"

    uses_metadata = False

    def filetitle(self, file, metadata):
      return devicon(file) + ' ' + file.relative_path

    def infostring(self, fobj, metadata):

        try:
            stat=fobj.get_permission_string()
        except Exception as e:
            stat='!---------'

        try:
            date=datetime.fromtimestamp(fobj.stat.st_mtime).strftime("%Y-%m-%d %H:%M")
        except Exception as e:
            date='XXXX-XX-XX XX:XX:XX'

        return "{size} {stat} {user:>6} {group:>6} {date}".format(
            stat=stat,
            user=fobj.user,
            group=fobj.group,
            date=date,
            size=human_readable(fobj.size))


  @ranger.api.register_linemode
  class DevIconsLinemodeFile(LinemodeBase):
    name = "filename"

    def filetitle(self, file, metadata):
      return devicon(file) + ' ' + file.relative_path
