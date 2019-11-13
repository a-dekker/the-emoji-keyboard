/*
 * Copyright (C) 2014 Janne Edelman.
 * Contact: Janne Edelman <janne.edelman@gmail.com>
 */

import QtQuick 2.2
import Sailfish.Silica 1.0

Item {
    id: emojiKeyEnter
    width: shiftKeyWidth
    height: keyHeight
    Image {
        source: MInputMethodQuick.actionKeyOverride.icon
        anchors.centerIn: parent
    }
    Rectangle {
        color: Theme.primaryColor
        opacity: 0.17
        radius: geometry.keyRadius
        anchors.fill: parent
        anchors.topMargin: Theme.paddingMedium
        anchors.bottomMargin: Theme.paddingMedium
        anchors.leftMargin: Theme.paddingSmall
        anchors.rightMargin: Theme.paddingSmall
    }
}
