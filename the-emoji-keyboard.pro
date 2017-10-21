TEMPLATE = aux

NAME=Sailfish_the-emoji-keyboard

OTHER_FILES = \
        layouts/* \
        custom_emoji/* \
        fonts/* \
        rpm/* \
        README.md

layouts.files = layouts/*
layouts.path = /usr/share/maliit/plugins/com/jolla/layouts/

custom_emoji.files = custom_emoji/*
custom_emoji.path = /usr/share/maliit/plugins/com/jolla/custom_emoji/

fonts.files = fonts/*
fonts.path = /usr/share/fonts/custom/

INSTALLS += \
        layouts \
        custom_emoji \
        fonts
