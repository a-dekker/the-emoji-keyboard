/*
 * Copyright (C) 2014 Janne Edelman.
 * Contact: Janne Edelman <janne.edelman@gmail.com>
 */

import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: emojiKeyBackspace
    width: shiftKeyWidth
    height: keyHeight
    Image {
        source: "image://theme/icon-m-backspace"
        anchors.centerIn: parent
    }
}
