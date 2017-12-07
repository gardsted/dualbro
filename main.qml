/*
Testing two webviews on top of eachother
*/

import QtQuick 2.7
import QtQuick.Window 2.3
import QtWebEngine 1.0
import QtGraphicalEffects 1.0

Window {
    visibility: Window.FullScreen

    Rectangle{
        id: viewSwitcher
        property int frontView: 0
        anchors.fill:parent

        WebEngineView {
            id: view0
            anchors.fill: parent
            url: "http://www.qt.io"
            opacity: 1.0
            layer.enabled: true
        }

        WebEngineView {
            id:view1
            anchors.fill: parent
            url: "http://www.google.com"
            opacity: 0.0
            layer.enabled: true
        }

        Timer {
            id:transitionDone
            interval: 1000; running: true; repeat: false
            onTriggered: viewSwitcher.frontView=(viewSwitcher.frontView==1)?0:1
        }

        states: [
            State {
                when: viewSwitcher.frontView == 0
                PropertyChanges { target: view1; opacity: 0.0; }
            },

            State {
                when: viewSwitcher.frontView == 1
                PropertyChanges { target: view1; opacity: 1.0; }
            }
        ]
        transitions: [
            Transition {
                NumberAnimation {property: "opacity"; duration: 1000}
                onRunningChanged: {
                    if (!running){
                        transitionDone.restart()
                    }
                }
            }
        ]
    }
}
