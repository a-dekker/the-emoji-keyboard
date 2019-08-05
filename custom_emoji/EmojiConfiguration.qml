

/*
 * Copyright (C) 2014 Janne Edelman.
 * Contact: Janne Edelman <janne.edelman@gmail.com>
 */
import QtQuick 2.0
import Sailfish.Silica 1.0

EmojiConfigSwipeArea {
    id: page
    preventStealing: true
    propagateComposedEvents: false
    width: parent.width
    height: parent.height
    anchors.fill: parent

    PageHeader {
        id: title
        title: "Emoji Keyboard Settings"
    }

    function resetFlick() {
        flickArea.contentX = 0
        flickArea.contentY = 0
    }

    Item {
        width: parent.width
        height: parent.height - title.height
        x: 0
        y: title.height
        z: -1

        SilicaFlickable {
            id: flickArea
            width: parent.width
            height: parent.height
            anchors.fill: parent
            contentHeight: column.height
            flickableDirection: Flickable.VerticalFlick
            boundsBehavior: Flickable.DragAndOvershootBounds
            clip: true
            pressDelay: 400

            EmojiConfigSwipeArea {
                id: mouseFlickable
                preventStealing: true
                propagateComposedEvents: false
            }

            Column {
                id: column
                width: parent.width
                spacing: Theme.paddingSmall

                Label {
                    width: parent.width
                    anchors {
                        left: parent.left
                        right: parent.right
                        margins: Theme.paddingLarge
                    }
                    color: Theme.highlightColor
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: Theme.fontSizeMedium
                    text: "Version " + emojiKeyboard.appVersion
                }

                Label {
                    width: parent.width
                    anchors {
                        left: parent.left
                        right: parent.right
                        margins: Theme.paddingLarge
                    }
                    color: Theme.highlightColor
                    font.pixelSize: Theme.fontSizeSmall
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    text: "You may personalize The Emoji Keyboard by altering settings below. When finished you can exit the settings by swiping from left to right or use the Close button below."
                }

                SectionHeader {
                    text: "Selection Key Row"
                }

                TextSwitch {
                    id: styleApple
                    automaticCheck: false
                    checked: (emojiKeyboard.keyboardSelectRow === 'Apple')
                    onClicked: {
                        if (!checked) {
                            checked = true
                            styleKurosh.checked = false
                            emojiKeyboard.keyboardSelectRow = 'Apple'
                            emojiKeyboard.saveSetting(
                                        'KeyboardSelectRow',
                                        emojiKeyboard.keyboardSelectRow)
                        }
                    }
                    Row {
                        scale: 0.85
                        x: Theme.iconSizeSmall
                        EmojiCfgKbdSelector {
                        }
                        EmojiCfgSetSelector {
                            textSelector: emojiChar[5][5][1]
                        }
                        EmojiCfgSetSelector {
                            textSelector: emojiChar[1][0][0]
                        }
                        EmojiCfgSetSelector {
                            textSelector: emojiChar[2][2][4]
                        }
                        EmojiCfgSetSelector {
                            textSelector: emojiChar[3][1][12]
                        }
                        EmojiCfgSetSelector {
                            textSelector: emojiChar[4][1][27]
                        }
                        EmojiCfgSetSelector {
                            textSelector: "!?#"
                        }
                        EmojiCfgKeyBackspace {
                        }
                        EmojiCfgKeyEnter {
                        }
                    }
                }
                TextSwitch {
                    id: styleKurosh
                    automaticCheck: false
                    checked: (emojiKeyboard.keyboardSelectRow === 'Kurosh')
                    onClicked: {
                        if (!checked) {
                            checked = true
                            styleApple.checked = false
                            emojiKeyboard.keyboardSelectRow = 'Kurosh'
                            emojiKeyboard.saveSetting(
                                        'KeyboardSelectRow',
                                        emojiKeyboard.keyboardSelectRow)
                        }
                    }
                    Row {
                        scale: 0.85
                        x: Theme.iconSizeSmall
                        EmojiCfgSetSelector {
                            textSelector: emojiChar[5][5][1]
                        }
                        EmojiCfgSetSelector {
                            textSelector: emojiChar[1][0][0]
                        }
                        EmojiCfgSetSelector {
                            textSelector: emojiChar[2][2][4]
                        }
                        EmojiCfgSetSelector {
                            textSelector: emojiChar[3][1][12]
                        }
                        EmojiCfgSetSelector {
                            textSelector: emojiChar[4][1][27]
                        }
                        EmojiCfgSetSelector {
                            textSelector: "!?#"
                        }
                        EmojiCfgKbdSelector {
                        }
                        EmojiCfgKeyBackspace {
                        }
                        EmojiCfgKeyEnter {
                        }
                    }
                }

                SectionHeader {
                    text: "Keyboard Switch Key Click Action"
                }

                TextSwitch {
                    id: spaceBar
                    automaticCheck: false
                    checked: (emojiKeyboard.keySpace != 0)
                    text: "Spacebar"
                    description: "Type space character when clicked"
                    onClicked: {
                        if (!checked) {
                            checked = true
                            spaceNone.checked = false
                            emojiKeyboard.keySpace = 1
                            emojiKeyboard.saveSetting('KeySpace',
                                                      emojiKeyboard.keySpace)
                        }
                    }
                }
                TextSwitch {
                    id: spaceNone
                    automaticCheck: false
                    checked: (emojiKeyboard.keySpace == 0)
                    text: "None"
                    description: "No action"
                    onClicked: {
                        if (!checked) {
                            checked = true
                            spaceBar.checked = false
                            emojiKeyboard.keySpace = 0
                            emojiKeyboard.saveSetting('KeySpace',
                                                      emojiKeyboard.keySpace)
                        }
                    }
                }


                /*      SectionHeader {
                     text: "Language Selection Delay"
                 }

                 Slider {
                     id: langSwitchDelay
                     width: parent.width
                     minimumValue: 300
                     maximumValue: 800
                     stepSize: 100
                     label: "Language switch key delay\n(NOT EFFECTIVE)"
                     value: 800
                     valueText: value/1000 + " s"
                     onValueChanged: {
                     }
                 }
                 */
                SectionHeader {
                    text: "Keyboard Emoji display"
                }
                TextSwitch {
                    checked: (emojiKeyboard.useColor === 1)
                    text: "Use color"
                    description: "Display emojis in full color"
                    onClicked: {
                        if (checked) {
                            emojiKeyboard.useColor = 1
                        } else {
                            emojiKeyboard.useColor = 0
                        }
                        emojiKeyboard.saveSetting('UseColor',
                                                  emojiKeyboard.useColor)
                    }
                }

                SectionHeader {
                    text: "Favorites "
                }

                Label {
                    id: favorites
                    property int count: (emojiChar[0][0].indexOf(
                                             "") < 0) ? 30 : emojiChar[0][0].indexOf(
                                                            "")
                    width: parent.width
                    anchors {
                        left: parent.left
                        right: parent.right
                        margins: Theme.paddingLarge
                    }
                    color: Theme.highlightColor
                    text: (count > 0) ? "Favorites set has " + count
                                        + " symbols:" : "Favorites set is empty"
                }

                Rectangle {
                    width: keyboardImageFavorites.width + Theme.paddingSmall * 2
                    height: childrenRect.height + Theme.paddingSmall * 2
                    radius: geometry.popperRadius
                    anchors.margins: Theme.paddingSmall
                    anchors.horizontalCenter: parent.horizontalCenter
                    border {
                        color: Theme.highlightColor
                        width: 1
                    }
                    color: "transparent"
                    Column {
                        id: keyboardImageFavorites
                        anchors.horizontalCenter: parent.horizontalCenter
                        Row {
                            anchors.horizontalCenter: parent.horizontalCenter
                            EmojiCfgSymbolKey {
                                caption: emojiChar[0][0][0]
                            }
                            EmojiCfgSymbolKey {
                                caption: emojiChar[0][0][1]
                            }
                            EmojiCfgSymbolKey {
                                caption: emojiChar[0][0][2]
                            }
                            EmojiCfgSymbolKey {
                                caption: emojiChar[0][0][3]
                            }
                            EmojiCfgSymbolKey {
                                caption: emojiChar[0][0][4]
                            }
                            EmojiCfgSymbolKey {
                                caption: emojiChar[0][0][5]
                            }
                            EmojiCfgSymbolKey {
                                caption: emojiChar[0][0][6]
                            }
                            EmojiCfgSymbolKey {
                                caption: emojiChar[0][0][7]
                            }
                            EmojiCfgSymbolKey {
                                caption: emojiChar[0][0][8]
                            }
                            EmojiCfgSymbolKey {
                                caption: emojiChar[0][0][9]
                            }
                            EmojiCfgSymbolKey {
                                caption: emojiChar[0][0][10]
                            }
                        }
                        Row {
                            anchors.horizontalCenter: parent.horizontalCenter
                            EmojiCfgSymbolKey {
                                caption: emojiChar[0][0][11]
                            }
                            EmojiCfgSymbolKey {
                                caption: emojiChar[0][0][12]
                            }
                            EmojiCfgSymbolKey {
                                caption: emojiChar[0][0][13]
                            }
                            EmojiCfgSymbolKey {
                                caption: emojiChar[0][0][14]
                            }
                            EmojiCfgSymbolKey {
                                caption: emojiChar[0][0][15]
                            }
                            EmojiCfgSymbolKey {
                                caption: emojiChar[0][0][16]
                            }
                            EmojiCfgSymbolKey {
                                caption: emojiChar[0][0][17]
                            }
                            EmojiCfgSymbolKey {
                                caption: emojiChar[0][0][18]
                            }
                            EmojiCfgSymbolKey {
                                caption: emojiChar[0][0][19]
                            }
                            EmojiCfgSymbolKey {
                                caption: emojiChar[0][0][20]
                            }
                            EmojiCfgSymbolKey {
                                caption: emojiChar[0][0][21]
                            }
                        }

                        Row {
                            anchors.horizontalCenter: parent.horizontalCenter
                            EmojiCfgSymbolKey {
                                caption: emojiChar[0][0][22]
                            }
                            EmojiCfgSymbolKey {
                                caption: emojiChar[0][0][23]
                            }
                            EmojiCfgSymbolKey {
                                caption: emojiChar[0][0][24]
                            }
                            EmojiCfgSymbolKey {
                                caption: emojiChar[0][0][25]
                            }
                            EmojiCfgSymbolKey {
                                caption: emojiChar[0][0][26]
                            }
                            EmojiCfgSymbolKey {
                                caption: emojiChar[0][0][27]
                            }
                            EmojiCfgSymbolKey {
                                caption: emojiChar[0][0][28]
                            }
                            EmojiCfgSymbolKey {
                                caption: emojiChar[0][0][29]
                            }
                        }
                    }
                }

                BackgroundItem {
                    width: parent.width
                    visible: (favorites.count > 0)
                    Button {
                        id: resetFavorites
                        visible: (remorseReset.visible) ? false : true
                        text: "Reset favorites"
                        anchors.horizontalCenter: parent.horizontalCenter
                        onClicked: {
                            remorseReset.show("Reset favorite symbols",
                                              null, 5000)
                        }
                    }
                    EmojiRemorse {
                        id: remorseReset
                        onTriggered: {
                            var temp = emojiChar
                            temp[0][0] = emptySet
                            emojiChar = temp
                            saveSetting("Favorite",
                                        JSON.stringify(emojiChar[0][0]))
                        }
                    }
                }

                SectionHeader {
                    text: "Copyright"
                }

                Label {
                    width: parent.width
                    anchors {
                        left: parent.left
                        right: parent.right
                        margins: Theme.paddingLarge
                    }
                    color: Theme.highlightColor
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: Theme.fontSizeSmall
                    text: "Copyright © 2014 Janne Edelman\nTwitter: @JanneEdelman\n<janne.edelman@gmail.com>\n\nPortions copyright © 2012-2013 Jolla Ltd.\nPortions copyright © 2011 Nokia Corporation"
                }

                Button {
                    text: "Close"
                    anchors.horizontalCenter: parent.horizontalCenter
                    onClicked: {
                        config.openConfig = !config.openConfig
                        configRow.configVisible = config.openConfig ? true : false
                        emojiConfiguration.resetFlick()
                    }
                }

                Item {
                    width: parent.width
                    height: Theme.itemSizeSmall
                }
            }
            ScrollDecorator {
                flickable: flickArea
            }
        }
    }
}
