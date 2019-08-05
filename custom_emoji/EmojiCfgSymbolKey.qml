
/*
 * Copyright (C) 2014 Janne Edelman.
 * Contact: Janne Edelman <janne.edelman@gmail.com>
 */
import QtQuick 2.0
import com.jolla.keyboard 1.0
import Sailfish.Silica 1.0
import ".."

Item {
    id: emojiCfgSymbolKey
    property string caption
    property bool separator: (caption == "") ? false : true
    width: emojiGeometry.setSelectKeyWidth * .85
    height: keyHeight * .85

    Loader {
        sourceComponent: emojiCfgSymbolKey.separator
                         && emojiKeyboard.useColor === 1 ? iconComponent : keyTextComponent
        anchors.centerIn: parent
    }
    Component {
        id: keyTextComponent
        Text {
            id: keyText
            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSizeMedium
            color: Theme.primaryColor
            text: caption
        }
    }
    Component {
        id: iconComponent
        Image {
            id: icon
            asynchronous: true
            width: Theme.itemSizeSmall / 2
            height: Theme.itemSizeSmall / 2
            anchors.centerIn: parent
            source: "emoji/" + caption + ".gif"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
    Image {
        source: "../graphic-keyboard-highlight-top.png"
        anchors.right: parent.right
        visible: separator
    }
}
