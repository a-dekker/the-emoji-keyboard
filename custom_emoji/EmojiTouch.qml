/*
 * Copyright (C) 2014 Janne Edelman.
 * Contact: Janne Edelman <janne.edelman@gmail.com>
 */

import QtQuick 2.0
import com.jolla.keyboard 1.0
import Sailfish.Silica 1.0
import "../touchpointarray.js" as ActivePoints
import ".."

Item {
    id: emojiTouch
    width: emojiKeyboard.width
    height: 0.01
    signal swipeLeft
    signal swipeRight
    signal swipeUp

    MultiPointTouchArea {
        x: 0
        y: -emojiKeyboard.height + parent.height
        width: emojiKeyboard.width
        height: emojiKeyboard.height

        onPressed: keyboard.handlePressed(touchPoints)
        onUpdated: emojiHandleUpdated(touchPoints)
        onReleased: keyboard.handleReleased(touchPoints)
        onCanceled: keyboard.handleCanceled(touchPoints)
    }

    function emojiHandleUpdated(touchPoints) {
        console.log("emojiHandleUpdated", touchPoints.length)
        console.log("emojiKeyboard.languageSelectPressed",
                    emojiKeyboard.languageSelectPressed)
        if (!emojiKeyboard.languageSelectPressed) {
            //!keyboard.languageSelectionPopup.visible) {
            console.log("True")
            if (touchPoints.length === 1) {
                console.log("ONLY ONE TOUCHPOINT - TIME TO SWIPE")
            }
            var point = touchPoints[0]
            console.log("point.pointId: " + point.pointId + " startX: "
                        + point.startX + " x: " + point.x)
            console.log("point", point)
            if (point === null) {
                console.log("touchpoint lost")
            } else {
                if (true) {
                    if ((point.x - point.startX) > (keyboard.width * 0.3)) {
                        console.log("Swipe Right")
                        swipeRight()
                    } else if ((point.startX - point.x) > (keyboard.width * 0.3)) {
                        console.log("Swipe Left")
                        swipeLeft()
                    } else if ((point.startY - point.y) > (keyboard.height * 0.3)) {
                        console.log("Swipe Up")
                        swipeUp()
                    }
                    if (point.pressedKey) {
                        console.log("pressed key found")
                        inputHandler._handleKeyRelease()
                        point.pressedKey.pressed = false
                    } else {
                        console.log("NO KEY FOUND")
                    }
                    touchPoints.splice(0, 1)
                    console.log("touchPoints.length", touchPoints.length)
                    keyboard.lastPressedKey = null
                    //                    keyboard.pressTimer.stop()
                    //                    keyboard.languageSwitchTimer.stop()
                    return
                }
            }
        }
        keyboard.handleUpdated(touchPoints)
    }
}
