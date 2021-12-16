import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import Qt.labs.qmlmodels 1.0
Dialog {
    width: 640
    height: 480
    id: appointmentViewWindow

    standardButtons: /*Dialog.Help |*/ Dialog.Ok
    title: "Все приемы"
    function openWithDestination(dest) {
        open()
        text = dest
        if (text)
            textAreaAllView.text = text
    }
    property string text: ""
    TextArea {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 5
        id: textAreaAllView
        x: 0
        y: 0
        height: 420
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.75}D{i:1}
}
##^##*/
