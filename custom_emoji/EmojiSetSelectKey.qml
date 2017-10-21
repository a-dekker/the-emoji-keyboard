/*
 * Copyright (C) 2014 Janne Edelman.
 * Contact: Janne Edelman <janne.edelman@gmail.com>
 * Portions copyright (C) 2013 Jolla Ltd.
 */

import QtQuick 2.0
import com.jolla.keyboard 1.0
import Sailfish.Silica 1.0
import ".."

FunctionKey {
    id: selectEmojiSet
    property bool selected: false
    property string symbol: "X"
    property int targetSet
    property int targetPage: -1
    caption: ""
    text: ""
    repeat: false
    key: Qt.Key_unknown
    implicitWidth: emojiGeometry.setSelectKeyWidth
    keyType: KeyType.DeadKey

    onClicked: {
        saveSetting('emojiPage' + emojiSet, emojiPage)
        // If targetPage defined select it
        // Else if target set already selected then jump to page 0
        // except if already on page 0 then jump to last page
        var clickPage = emojiPage
        emojiPage = (targetPage > -1) ? targetPage : ((targetSet == emojiSet) ? ((emojiPage === 0) ? emojiChar[emojiSet].length - 1 : 0) : getSetting('emojiPage' + targetSet, emojiPage))
        emojiSet = targetSet
        saveSetting('emojiSet', emojiSet)
        if (emojiPage !== clickPage) {
            saveSetting('emojiPage' + emojiSet, emojiPage)
        }
        canvas.updateIMArea()
    }

    Text {
        id: text
        width: parent.implicitWidth
        height: parent.height
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: parent.symbol
        color: selected ? Theme.highlightColor : Theme.primaryColor
        font.pixelSize: Theme.fontSizeMedium
    }

    Rectangle {
        width: parent.implicitWidth
        color: pressed ? Theme.highlightBackgroundColor : Theme.primaryColor
        opacity: pressed ? 0.6 : (selected ? 0.17 : 0.07)
        radius: geometry.keyRadius
        anchors.fill: parent
        anchors.topMargin: Theme.paddingSmall
        anchors.bottomMargin: Theme.paddingSmall
        anchors.leftMargin: 1
        anchors.rightMargin: 1
    }
}
