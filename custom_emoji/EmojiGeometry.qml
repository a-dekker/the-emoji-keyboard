

/*
 * Copyright (C) 2014 Janne Edelman.
 * Contact: Janne Edelman <janne.edelman@gmail.com>
 */
import QtQuick 2.0
import Sailfish.Silica 1.0

QtObject {
    property bool largeScreen: Screen.sizeCategory === Screen.Large
                               || Screen.sizeCategory === Screen.ExtraLarge
    // Trying to adapt to different screen sizes
    property real widthCorrection: keyboard.width / (portraitMode ? Screen.width : Screen.height)
    property int languageSelectKeyWidth: (portraitMode ? 66 : 100)
                                         * geometry.scaleRatio * widthCorrection
    // page key width set by icon width. width correction makes row to break after rotation to landscape
    // property int setPageKeyWidth: (portraitMode ? 72 : 72 ) * geometry.scaleRatio * widthCorrection
    property int setSelectKeyWidth: (portraitMode ? (largeScreen ? 61 : 44) : (largeScreen ? 75 : 88))
                                    * geometry.scaleRatio * widthCorrection
    property int configKeyWidth: (portraitMode ? 40 : 40) * geometry.scaleRatio * widthCorrection
}
