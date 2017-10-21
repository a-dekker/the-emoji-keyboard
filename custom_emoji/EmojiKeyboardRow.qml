// Copyright (C) 2013 Jolla Ltd.
// Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>
//
// Imported from Sailfish 1.1.2.16 to get Emoji Keyboard back working.
// Need to find out why new ../KeyboardRow.qml breaks the selection row on landscape and rotate

import QtQuick 2.0

Row {
    property int basicButtonSize

    // calculates maximum width for a "basic" button
    function maximumBasicButtonWidth(shareableWidth) {
        var basicButtonCount = 0
        var originalWidth = shareableWidth

        var i
        for (i = 0; i < children.length; ++i) {
            var child = children[i]

            if (isBasicButton(child)) {
                basicButtonCount++
            } else {
                shareableWidth -= child.width
            }
        }

        return basicButtonCount !== 0 ? shareableWidth / basicButtonCount
                                      : originalWidth
    }

    function relayout() {
        var shareableWidth = width
        var child
        var i

        for (i = 0; i < children.length; ++i) {
            child = children[i]

            child.height = parent.keyHeight

            if (isBasicButton(child)) {
                child.width = basicButtonSize
                shareableWidth -= basicButtonSize
            } else {
                shareableWidth -= child.width
            }
        }

        // handle first and last basic button separately
        for (i = 0; i < children.length; ++i) {
            child = children[i]
            if (isBasicButton(child)) {
                child.width = basicButtonSize + (shareableWidth / 2)
                child.leftPadding = shareableWidth / 2
                break
            }
        }

        for (i = children.length - 1; i >= 0; --i) {
            child = children[i]
            if (isBasicButton(child)) {
                child.separator = false
                child.width = basicButtonSize + (shareableWidth / 2)
                child.rightPadding = shareableWidth / 2
                break
            }
        }
    }

    function isBasicButton(item) {
        // Hack: relying on property
        return item.hasOwnProperty("symView") && !item.fixedWidth
    }
}
