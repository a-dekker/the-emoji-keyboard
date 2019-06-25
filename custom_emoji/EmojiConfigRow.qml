

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
    // z: -1 // Make config button to hide below popper; broken as of 2019-04-20, causes config button not to be triggered properly
    /* Configuration button */
    Item {
        id: config
        property bool pressed: false
        property bool openConfig: false
        x: emojiKeyboard.width - config.width - Theme.paddingMedium
        // It is tricky to determine the correct vertical position, because parent.height and configRow.height (which should be equal) seem to stay 0 rsp. false,
        // even if the configRow is visible (e.g., because configVisible seems to stay false; have not checked this theory though).
        // Furthermore emojiKeyboard.height includes the real configRow.height (= Theme.itemSizeSmall) on SFOS 3.0.2, but excludes it on SFOS 2.2.1
        y: portraitMode ? -emojiKeyboard.height - parent.height
                          + Theme.paddingMedium : parent.height - Theme.paddingMedium - config.width
        width: configImage.width + Theme.paddingMedium * 2
        height: configImage.height + Theme.paddingMedium * 2
        visible: !config.openConfig
        Image {
            id: configImage
            source: "image://theme/icon-s-setting"
            anchors.centerIn: parent
            opacity: 0.6
        }
        // Button background
        Rectangle {
            id: configButton
            width: parent.width
            height: parent.height
            color: config.pressed ? Theme.highlightBackgroundColor : Theme.primaryColor
            opacity: config.pressed ? 0.3 : 0.07
            radius: geometry.popperRadius
            anchors.margins: Theme.paddingMedium
        }
        // Border
        Rectangle {
            width: parent.width
            height: parent.height
            radius: geometry.popperRadius
            anchors.margins: Theme.paddingMedium
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
