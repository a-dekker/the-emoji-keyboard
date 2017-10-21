/*
 * Copyright (C) 2014 Janne Edelman.
 * Contact: Janne Edelman <janne.edelman@gmail.com>
 */


import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: emojiSetSelector
    property string textSelector: ""
    width: emojiGeometry.setSelectKeyWidth
    height: keyHeight
    Text {
        anchors.centerIn: parent
        text: textSelector
        color: Theme.primaryColor
        font.pixelSize: Theme.fontSizeSmall
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
