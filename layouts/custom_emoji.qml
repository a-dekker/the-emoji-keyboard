

/*
 * Copyright (C) 2014 Janne Edelman.
 * Contact: Janne Edelman <janne.edelman@gmail.com>
 */
import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import Sailfish.Silica 1.0
import com.jolla.keyboard 1.0
import "../custom_emoji"
import ".."

KeyboardLayout {
    id: emojiKeyboard
    splitSupported: true

    // FIXME: There should be a proper way to disable text prediction
    //        although this seems to do it
    type: "emoji"
    property string appVersion: "0.4.4"

    EmojiGeometry {
        id: emojiGeometry
    }
    EmojiLibrary {
        id: emojiLibrary
    }

    property alias emptySet: emojiLibrary.emptySet
    property alias emojiChar: emojiLibrary.emojiChar
    property alias spaceChar: emojiLibrary.spaceChar

    property var db: null
    property int dberror: 0

    property int emojiSet: 0
    property int emojiPage: 0
    property bool prevPage: (emojiPage > 0) ? true : false
    property bool nextPage: (emojiPage < (emojiChar[emojiSet].length - 1)) ? true : false

    property string keyboardSelectRow: 'Apple'
    property int keySpace: 1
    property bool languageSelectPressed

    // Storage functions
    function openDB() {
        if (db !== null)
            return

        // db = LocalStorage.openDatabaseSync(identifier, version, description, estimated_size, callback(db))
        db = LocalStorage.openDatabaseSync("keyboard-custom-emoji", "0.1",
                                           "The Emoji Keyboard", 100000)

        try {
            db.transaction(function (tx) {
                tx.executeSql(
                            'CREATE TABLE IF NOT EXISTS settings(key TEXT UNIQUE, value TEXT)')
                var table = tx.executeSql("SELECT * FROM settings")
                // Setup the settings table with default values
                if (table.rows.length === 0) {
                    tx.executeSql('INSERT INTO settings VALUES(?, ?)',
                                  ['emojiSet', "0"])
                    tx.executeSql('INSERT INTO settings VALUES(?, ?)',
                                  ['emojiPage0', '0'])
                    tx.executeSql('INSERT INTO settings VALUES(?, ?)',
                                  ['emojiPage1', '0'])
                    tx.executeSql('INSERT INTO settings VALUES(?, ?)',
                                  ['emojiPage2', '0'])
                    tx.executeSql('INSERT INTO settings VALUES(?, ?)',
                                  ['emojiPage3', '0'])
                    tx.executeSql('INSERT INTO settings VALUES(?, ?)',
                                  ['emojiPage4', '0'])
                    tx.executeSql('INSERT INTO settings VALUES(?, ?)',
                                  ['emojiPage5', '0'])
                    tx.executeSql('INSERT INTO settings VALUES(?, ?)',
                                  ['Favorite', JSON.stringify(emptySet)])
                }
                ;
            })
        } catch (err) {
            return err
        }
        ;
    }

    function saveSetting(key, value) {
        openDB()
        db.transaction(function (tx) {
            tx.executeSql('INSERT OR REPLACE INTO settings VALUES(?, ?)',
                          [key, value])
        })
    }

    function getSetting(key, defvalue) {
        openDB()
        var res = null
        db.transaction(function (tx) {
            var rs = tx.executeSql('SELECT value FROM settings WHERE key=?;',
                                   [key])
            res = rs.rows.item(0).value
        })
        return ((typeof (res) == 'undefined')
                || (res === null)) ? defvalue : res
    }

    Component.onCompleted: {
        // emojiKeyboard setup
        var temp = emojiChar, s
        emojiSet = getSetting('emojiSet', emojiSet)
        console.log("emojiKeyboard.emojiSet", emojiSet)
        emojiPage = getSetting('emojiPage' + emojiSet, emojiPage)
        console.log("emojiKeyboard.emojiPage" + emojiSet, emojiPage)
        s = getSetting('Favorite')
        if (s !== '') {
            temp[0][0] = JSON.parse(s)
            emojiSet = (temp[0][0][0] !== "") ? emojiSet : ((emojiSet == 0) ? 1 : emojiSet)
        } else {
            temp[0][0] = emptySet
            emojiSet = 1
        }
        emojiChar = temp
        // Get keyboard selection row style
        keyboardSelectRow = getSetting('KeyboardSelectRow', keyboardSelectRow)
        console.log("emojiKeyboard.keyboardSelectRow", keyboardSelectRow)
        // Keyboard select key click behavior
        keySpace = getSetting('KeySpace', keySpace)
        console.log("emojiKeyboard.keySpace", keySpace)
    }

    /* DEBUG */
    Row {
        id: debugRow
        visible: false
        Text {
            color: "red"
            font.pixelSize: 26
            text: "DEBUG ROW"
        }
    }

    Row {
        id: indicatorRow
        property int shareableWidth: width
        property int incidatorWidth: 20
        property int spacingWidth: 6
        property int paddingWidth: (shareableWidth / 2) - (emojiChar[emojiSet].length
                                                           * (incidatorWidth + spacingWidth) / 2)

        spacing: spacingWidth
        Rectangle {
            color: "transparent"
            opacity: 0
            width: parent.paddingWidth
            height: 3
        }
        Repeater {
            model: emojiChar[emojiSet].length
            Rectangle {
                color: (emojiPage == index) ? "white" : Theme.highlightColor
                opacity: (emojiSet == 0) ? 0 : 0.9
                width: indicatorRow.incidatorWidth
                height: 2
            }
        }
    }

    KeyboardRow {
        EmojiSymbolKey {
            caption: emojiChar[emojiSet][emojiPage][0]
        }
        EmojiSymbolKey {
            caption: emojiChar[emojiSet][emojiPage][1]
        }
        EmojiSymbolKey {
            caption: emojiChar[emojiSet][emojiPage][2]
        }
        EmojiSymbolKey {
            caption: emojiChar[emojiSet][emojiPage][3]
        }
        EmojiSymbolKey {
            caption: emojiChar[emojiSet][emojiPage][4]
        }
        EmojiSymbolKey {
            caption: emojiChar[emojiSet][emojiPage][5]
        }
        EmojiSymbolKey {
            caption: emojiChar[emojiSet][emojiPage][6]
        }
        EmojiSymbolKey {
            caption: emojiChar[emojiSet][emojiPage][7]
        }
        EmojiSymbolKey {
            caption: emojiChar[emojiSet][emojiPage][8]
        }
        EmojiSymbolKey {
            caption: emojiChar[emojiSet][emojiPage][9]
        }
        EmojiSymbolKey {
            caption: emojiChar[emojiSet][emojiPage][10]
        }
    }

    KeyboardRow {
        EmojiSymbolKey {
            caption: emojiChar[emojiSet][emojiPage][11]
        }
        EmojiSymbolKey {
            caption: emojiChar[emojiSet][emojiPage][12]
        }
        EmojiSymbolKey {
            caption: emojiChar[emojiSet][emojiPage][13]
        }
        EmojiSymbolKey {
            caption: emojiChar[emojiSet][emojiPage][14]
        }
        EmojiSymbolKey {
            caption: emojiChar[emojiSet][emojiPage][15]
        }
        EmojiSymbolKey {
            caption: emojiChar[emojiSet][emojiPage][16]
        }
        EmojiSymbolKey {
            caption: emojiChar[emojiSet][emojiPage][17]
        }
        EmojiSymbolKey {
            caption: emojiChar[emojiSet][emojiPage][18]
        }
        EmojiSymbolKey {
            caption: emojiChar[emojiSet][emojiPage][19]
        }
        EmojiSymbolKey {
            caption: emojiChar[emojiSet][emojiPage][20]
        }
        EmojiSymbolKey {
            caption: emojiChar[emojiSet][emojiPage][21]
        }
    }

    KeyboardRow {
        FunctionKey {
            icon.source: "image://theme/icon-m-left" + (pressed ? ("?" + Theme.highlightColor) : "")
            opacity: 0.6
            implicitWidth: icon.width + Theme.paddingSmall * 2
            background.visible: false
            onClicked: {
                emojiPage = prevPage ? (emojiPage - 1) : emojiChar[emojiSet].length - 1
                saveSetting('emojiPage' + emojiSet, emojiPage)
                canvas.updateIMArea()
            }
        }

        //  EmojiPageKey { pageDir: -1 }
        EmojiSymbolKey {
            caption: emojiChar[emojiSet][emojiPage][22]
        }
        EmojiSymbolKey {
            caption: emojiChar[emojiSet][emojiPage][23]
        }
        EmojiSymbolKey {
            caption: emojiChar[emojiSet][emojiPage][24]
        }
        EmojiSymbolKey {
            caption: emojiChar[emojiSet][emojiPage][25]
        }
        EmojiSymbolKey {
            caption: emojiChar[emojiSet][emojiPage][26]
        }
        EmojiSymbolKey {
            caption: emojiChar[emojiSet][emojiPage][27]
        }
        EmojiSymbolKey {
            caption: emojiChar[emojiSet][emojiPage][28]
        }
        EmojiSymbolKey {
            caption: emojiChar[emojiSet][emojiPage][29]
        }
        FunctionKey {
            icon.source: "image://theme/icon-m-right"
                         + (pressed ? ("?" + Theme.highlightColor) : "")
            opacity: 0.6
            implicitWidth: icon.width + Theme.paddingSmall * 2
            background.visible: false
            onClicked: {
                emojiPage = nextPage ? (emojiPage + 1) : 0
                saveSetting('emojiPage' + emojiSet, emojiPage)
                canvas.updateIMArea()
            }
        }
    }

    // Alternative Select Key Rows
    EmojiSelectRowApple {
        visible: (keyboardSelectRow === 'Apple') ? true : false
    }
    EmojiSelectRowKurosh {
        visible: (keyboardSelectRow === 'Kurosh') ? true : false
    }

    EmojiConfigRow {
    }
    //EmojiTouch { id: emojiTouch }
}
