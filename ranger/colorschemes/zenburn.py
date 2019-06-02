# Ivaylo Kuzev <ivkuzev@gmail.com>, 2014
# Zenburn like colorscheme for https://github.com/hut/ranger .

# default colorscheme.
# Copyright (C) 2009-2013  Roman Zimbelmann <hut@lepus.uberspace.de>
# This software is distributed under the terms of the GNU GPL version 3.

from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import *

class Zenburn(ColorScheme):
    progress_bar_color = 108

    def use(self, context):
        fg, bg, attr = default_colors

        bg = 237

        if context.reset:
            return default_colors

        elif context.in_browser:

            if context.selected:
                return 223, 235, attr
            else:
                attr = normal

            if context.empty or context.error:
                fg = 174

            if context.border:
                fg = 235

            if context.image:
                fg = 34

            if context.video:
                fg = 34

            if context.audio:
                fg = 35

            if context.document:
                fg = 30

            if context.container:
                attr |= bold
                fg = 247

            if context.directory:
                attr |= bold
                fg = 108
                # bg = 237

            elif context.executable and not \
                    any((context.media, context.container,
                       context.fifo, context.socket)):
                attr |= bold
                fg = 172

            if context.socket:
                fg = 110
                attr |= bold

            if context.fifo or context.device:
                fg = 109
                # bg = 237
                if context.device:
                    fg = 228
                    attr |= bold

            if context.link:
                fg = context.good and 142 or 174

            if context.bad:
                fg = 142

            if context.tag_marker and not context.selected:
                attr |= bold
                if fg in (174, 95):
                    fg = 248
                else:
                    fg = 174

            if not context.selected and (context.cut or context.copied):
                fg = 116
                bg = 238

            if context.main_column:
                if context.selected:
                    attr |= bold
                if context.marked:
                    attr |= bold
                    fg = 223

            if context.badinfo:
                if attr & reverse:
                    bg = 95
                else:
                    fg = 95

        elif context.in_titlebar:
            attr |= bold
            bg = 235
            if context.hostname:
                fg = context.bad and 174 or 180
            elif context.directory:
                fg = 223
            elif context.tab:
                if context.good:
                    bg = 180
            elif context.link:
                fg = 116

        elif context.in_statusbar:
            bg = 236
            if context.permissions:
                if context.good:
                    fg = 108
                elif context.bad:
                    fg = 174
            if context.marked:
                attr |= bold | reverse
                fg = 223
            if context.message:
                if context.bad:
                    attr |= bold
                    fg = 174
            if context.loaded:
                bg = self.progress_bar_color
            if context.vcsinfo:
                fg = 116
                attr &= ~bold
            if context.vcscommit:
                fg = 144
                attr &= ~bold


        if context.text:
            # bg = 237
            if context.highlight:
                attr |= reverse

        if context.in_taskview:
            # bg = 237
            if context.title:
                fg = 116

            if context.selected:
                attr |= reverse

            if context.loaded:
                if context.selected:
                    fg = self.progress_bar_color
                else:
                    bg = self.progress_bar_color


        if context.vcsfile and not context.selected:
            # bg = 237
            attr &= ~bold
            if context.vcsconflict:
                fg = 95
            elif context.vcschanged:
                fg = 174
            elif context.vcsunknown:
                fg = 174
            elif context.vcsstaged:
                fg = 108
            elif context.vcssync:
                fg = 108
            elif context.vcsignored:
                fg = default

        elif context.vcsremote and not context.selected:
            # bg = 237
            attr &= ~bold
            if context.vcssync:
                fg = 108
            elif context.vcsbehind:
                fg = 174
            elif context.vcsahead:
                fg = 116
            elif context.vcsdiverged:
                fg = 95
            elif context.vcsunknown:
                fg = 174

        return fg, bg, attr
