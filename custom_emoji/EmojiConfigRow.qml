

/*
 * Copyright (C) 2014 Janne Edelman.
 * Contact: Janne Edelman <janne.edelman@gmail.com>
 */
import QtQuick 2.0
import com.jolla.keyboard 1.0
import Sailfish.Silica 1.0
import ".."

Item {
    id: configRow
    property bool configVisible: false
    // Easiest way to get correct width for keyboard is to use actual keyboard width
    width: emojiKeyboard.width
    // Height of non-visible configRow must be positive or otherwise anchor will be lost.
    // Using visible attribute would prevent configuration button to show
    height: (configVisible) ? ((MInputMethodQuick.appOrientation % 180
                                === 0) ? Screen.height : Screen.width) : 0.01
    z: -1 // Make config button to hide below popper

    /* Configuration button */
    Item {
        id: config
        property bool pressed: false
        property bool openConfig: false
        x: emojiKeyboard.width - config.width - Theme.paddingMedium
        y: -emojiKeyboard.height - parent.height - Theme.itemSizeSmall + Theme.paddingSmall + Theme.paddingLarge * 4
        width: configImage.width + Theme.paddingSmall * 2
        height: Theme.itemSizeSmall - Theme.paddingSmall
        Image {
            id: configImage
            source: "image://theme/icon-s-setting"
            anchors.centerIn: parent
            opacity: 0.6
            visible: true
        }
        // Button background
        Rectangle {
            id: configButton
            width: parent.width
            height: parent.height
            color: config.pressed ? Theme.highlightBackgroundColor : Theme.primaryColor
            opacity: config.pressed ? 0.3 : 0.07
            radius: geometry.popperRadius
            anchors.margins: Theme.paddingSmall
        }
        // Border
        Rectangle {
            width: parent.width
            height: parent.height
            radius: geometry.popperRadius
            anchors.margins: Theme.paddingSmall
            border {
                color: Theme.primaryColor
                width: 1
            }
            color: "transparent"
            opacity: config.pressed ? 0.6 : 0.3
        }
        // Make it behave like a button
        MouseArea {
            anchors.fill: parent
            preventStealing: true
            onPressed: {
                config.pressed = true
            }
            onReleased: {
                config.pressed = false
            }
            onPressAndHold: {
                config.openConfig = !config.openConfig
                configRow.configVisible = config.openConfig ? true : false
                emojiConfiguration.resetFlick()
            }
        }
    }
    EmojiConfiguration {
        id: emojiConfiguration
    }
}
