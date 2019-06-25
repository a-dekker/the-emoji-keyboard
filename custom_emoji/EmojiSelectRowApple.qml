

/*
 * Copyright (C) 2014 Janne Edelman.
 * Contact: Janne Edelman <janne.edelman@gmail.com>
 */
import QtQuick 2.0
import Sailfish.Silica 1.0
import com.jolla.keyboard 1.0
import ".."

EmojiKeyboardRow {
    EmojiKbdSelectKey {
    }
    EmojiSetSelectKey {
        symbol: emojiChar[5][5][1]
        selected: (emojiSet == 0) ? true : false
        enabled: (emojiChar[0][0][0] !== "") ? true : false
        targetSet: 0
        targetPage: 0
    }
    EmojiSetSelectKey {
        symbol: emojiChar[1][0][0]
        selected: (emojiSet == 1) ? true : false
        targetSet: 1
    }
    EmojiSetSelectKey {
        symbol: emojiChar[2][2][4]
        selected: (emojiSet == 2) ? true : false
        targetSet: 2
    }
    EmojiSetSelectKey {
        symbol: emojiChar[3][1][12]
        selected: (emojiSet == 3) ? true : false
        targetSet: 3
    }
    EmojiSetSelectKey {
        symbol: emojiChar[4][1][27]
        selected: (emojiSet == 4) ? true : false
        targetSet: 4
    }
    EmojiSetSelectKey {
        symbol: "!?#"
        selected: (emojiSet == 5) ? true : false
        targetSet: 5
    }
    BackspaceKey {
    }
    EmojiEnterKey {
    }
}
