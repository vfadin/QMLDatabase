import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import Qt.labs.qmlmodels 1.0
Dialog {
    id: currentAppointmentViewWindow
    function openWithDestination(dest, _dest) {
        open()
        text = dest
        _text = _dest
        if (text)
            textAppointment.text = text
        if (_text)
            img.source = "file:/" + _text
    }
    property string text: ""
    property string _text: ""
    TextArea {
        id: textAppointment
        x: 8
        y: 8
        width: 423
        height: 464
    }
    standardButtons: Dialog.Ok
    Image {
        id: img
        x: 440
        y: 8
        width: 192
        height: 192
        //source: "file:/" + imgAWField.text
        visible: true
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1}D{i:2}
}
##^##*/
