import QtQml 2.0
import QtQuick 2.1
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.0
import QtWebEngine 1.4

Window {
    id: helpWindow
    title: qsTr("Справка")

    property int shorterDesktop: 768
    property int longerDesktop: 1024
    property int shorterMin: 360
    property int longerMin: 480
    property bool isPortrait: Screen.primaryOrientation === Qt.PortraitOrientation
    width: {
        640
    }
    height: {
        480
    }
    minimumWidth: isPortrait ? shorterMin : longerMin
    minimumHeight: isPortrait ? longerMin : shorterMin

    RowLayout {
        id: container
        anchors.fill: parent
        spacing: 0

        RecipeList {
            id: recipeList
            Layout.minimumWidth: 124
            Layout.preferredWidth: parent.width / 3
            Layout.maximumWidth: 300
            Layout.fillWidth: true
            Layout.fillHeight: true
            focus: true
            activeFocusOnTab: true
            onRecipeSelected: function(url) {
                webView.showRecipe(url)
            }
        }

        WebEngineView {
            id: webView
            Layout.preferredWidth: 2 * parent.width / 3
            Layout.fillWidth: true
            Layout.fillHeight: true
            // Make sure focus is not taken by the web view, so user can continue navigating
            // recipes with the keyboard.
            settings.focusOnNavigationEnabled: false

            onContextMenuRequested: function(request) {
                request.accepted = true
            }

            property bool firstLoadComplete: false
            onLoadingChanged: function(loadRequest) {
                if (loadRequest.status === WebEngineView.LoadSucceededStatus
                    && !firstLoadComplete) {
                    // Debounce the showing of the web content, so images are more likely
                    // to have loaded completely.
                    showTimer.start()
                }
            }

            Timer {
                id: showTimer
                interval: 500
                repeat: false
                onTriggered: {
                    webView.show(true)
                    webView.firstLoadComplete = true
                    recipeList.showHelp()
                }
            }

            Rectangle {
                id: webViewPlaceholder
                anchors.fill: parent
                z: 1
                color: "white"

                BusyIndicator {
                    id: busy
                    anchors.centerIn: parent
                }
            }

            function showRecipe(url) {
                webView.url = url
            }

            function show(show) {
                if (show === true) {
                    busy.running = false
                    webViewPlaceholder.visible = false
                } else {
                    webViewPlaceholder.visible = true
                    busy.running = true
                }
            }
        }
    }
}
