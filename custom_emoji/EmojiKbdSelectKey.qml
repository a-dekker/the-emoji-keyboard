/*
 * Copyright (C) 2014 Janne Edelman.
 * Contact: Janne Edelman <janne.edelman@gmail.com>
 * Portions copyright (C) 2013 Jolla Ltd.
 */

import QtQuick 2.0
import Sailfish.Silica 1.0
import com.jolla.keyboard 1.0
import ".."

CharacterKey {
    caption: spaceChar[emojiKeyboard.keySpace];
    captionShifted: caption
    showPopper: false
    separator: SeparatorState.VisibleSeparator
    property bool implicitSeparator: true // set by layouting
    showHighlight: false
    key: Qt.Key_Space
    implicitWidth: emojiGeometry.languageSelectKeyWidth
    fixedWidth: true

    onPressedChanged: {
    emojiKeyboard.languageSelectPressed = pressed
    }

    Text {
        width: parent.width
        height: parent.height
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: "🌐"
        color: parent.pressed ? Theme.highlightColor : Theme.primaryColor
        font.pixelSize: Theme.fontSizeSmall
    }

    Rectangle {
        color: parent.pressed ? Theme.highlightBackgroundColor : Theme.primaryColor
        opacity: parent.pressed ? 0.6 : 0.07
        radius: geometry.keyRadius

        anchors.fill: parent
        anchors.margins: Theme.paddingSmall
    }
}
