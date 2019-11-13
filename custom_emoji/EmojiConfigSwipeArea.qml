

/*
 * Copyright (C) 2014 Janne Edelman.
 * Contact: Janne Edelman <janne.edelman@gmail.com>
 */
import QtQuick 2.2

SwipeArea {
    id: mouse
    anchors.fill: parent
    preventStealing: false
    propagateComposedEvents: true
    drag.axis: Drag.XAxis
    onSwipe: {
        switch (direction) {
        case "right":
        {
            config.openConfig = !config.openConfig
            configRow.configVisible = config.openConfig ? true : false
        }
        }
    }
}
