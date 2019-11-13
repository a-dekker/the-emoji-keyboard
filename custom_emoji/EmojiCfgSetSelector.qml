

/*
 * Copyright (C) 2014 Janne Edelman.
 * Contact: Janne Edelman <janne.edelman@gmail.com>
 */
import QtQuick 2.2
import Sailfish.Silica 1.0

Item {
    id: emojiSetSelector
    property string textSelector: ""
    width: emojiGeometry.setSelectKeyWidth
    height: keyHeight
    Loader {
        sourceComponent: textSelector != "" && keyTextComponent
        anchors.centerIn: parent
    }
    Component {
        id: keyTextComponent
        Text {
            anchors.centerIn: parent
            text: textSelector
            color: Theme.primaryColor
            font.pixelSize: Theme.fontSizeSmall
        }
    }
    Component {
        id: iconComponent
        Image {
            asynchronous: true
            width: Theme.itemSizeSmall / 2
            height: Theme.itemSizeSmall / 2
            anchors.centerIn: parent
            source: "emoji/" + textSelector + ".gif"
        }
    }

    Rectangle {
        color: Theme.primaryColor
        opacity: 0.17
        radius: geometry.keyRadius
        anchors.fill: parent
        anchors.topMargin: Theme.paddingMedium
        anchors.bottomMargin: Theme.paddingMedium
        anchors.leftMargin: 1
        anchors.rightMargin: 1
    }
}
