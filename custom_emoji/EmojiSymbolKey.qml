
/*
 * Copyright (C) 2014 Janne Edelman.
 * Contact: Janne Edelman <janne.edelman@gmail.com>
 * Portions copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies). All rights reserved.
 * Portions copyright (C) 2012-2013 Jolla Ltd.
 *
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice, this list
 * of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list
 * of conditions and the following disclaimer in the documentation and/or other materials
 * provided with the distribution.
 * Neither the name of Nokia Corporation nor the names of its contributors may be
 * used to endorse or promote products derived from this software without specific
 * prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
 * THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */

import QtQuick 2.0
import com.jolla.keyboard 1.0
import Sailfish.Silica 1.0
import ".."

KeyBase {
    id: aEmojiSymbolKey

    property string captionShifted: caption
    // symView property is needed to make KeyboardRow to recognice EmojiSymbolKey
    // as BasicButton and thus scale keypad properly
    property string symView
    property bool separator: (caption == "") ? false : true
    property bool implicitSeparator: true // set by layouting
    property bool showHighlight: true
    property bool showPopper: false // system keyboard popper can't handle over two byte long Unicode characters and must be disabled
    property bool fixedWidth
    // property alias useBoldFont: keyText.font.bold
    // property alias _keyText: caption

    keyType: KeyType.CharacterKey
    text: caption
    enabled: (caption == "") ? false : true

    Loader{
        sourceComponent: aEmojiSymbolKey.enabled ? iconComponent : keyTextComponent
        anchors.centerIn: parent
    }

    Component{
        id: keyTextComponent
        Text {
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: (leftPadding - rightPadding) / 2
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: Theme.fontFamily
            font.pixelSize: (Theme.fontSizeMedium * 2 + Theme.fontSizeLarge) / 3
            color: pressed ? Theme.highlightColor : Theme.primaryColor
            text: caption
        }
    }

    Component{
        id: iconComponent
        Image {
            id: icon
            asynchronous: true
            visible: caption && caption != "" && typeof caption != "undefined"
            width: Theme.itemSizeSmall/2
            height: Theme.itemSizeSmall/2
            anchors.centerIn: parent
            source: "emoji/" + caption + ".gif"
            anchors.horizontalCenterOffset: (leftPadding - rightPadding) / 2
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    Image {
        source: "../graphic-keyboard-highlight-top.png"
        anchors.right: parent.right
        visible: separator
    }

    Rectangle {
        anchors.fill: parent
        z: -1
        color: Theme.highlightBackgroundColor
        opacity: 0.5
        visible: pressed && showHighlight
    }

    /* Stock keyboard popper can't handle more than two byte long Unicode  *
     * character codes and thus we need own popper.                        */
    Rectangle {
        id: popper
        opacity: 1
        color: Qt.darker(Theme.highlightBackgroundColor, 1.2)
        height: geometry.popperHeight
        width: Math.ceil(geometry.popperWidth / 2.0) * 2
        radius: geometry.popperRadius
        visible: parent.pressed
        x: {
            var pos = (parent.width - popper.width) / 2
            var margin = geometry.popperMargin
            return (parent.x === 0) ? margin : (((parent.x + pos + popper.width)
                                                 >= emojiKeyboard.width) ? (parent.width - popper.width - margin) : pos)
        }
        y: parent.y - popper.height + Theme.paddingSmall
        Text {
            id: popperText
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: Theme.fontFamily
            font.pixelSize: geometry.popperFontSize
            color: Theme.primaryColor
            text: popper.parent.caption
        }
    }

    /* Save favorites */
    onClicked: {
        var index, lindex, temp = emojiChar
        var temp1 = [], temp2 = []
        temp[0][0].unshift(caption)
        index = temp[0][0].lastIndexOf(caption)
        if (index > 0) {
            temp[0][0].splice(index, 1)
        }
        temp[0][0] = temp[0][0].slice(0, 30)
        emojiChar = temp
        saveSetting("Favorite", JSON.stringify(emojiChar[0][0]))
    }
}
