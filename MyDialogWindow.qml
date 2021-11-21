import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import Qt.labs.qmlmodels 1.0
Dialog {
    id: registrationWindow
    title: "Новый пациент"
    standardButtons: Dialog.Ok | Dialog.Cancel
    onAccepted: {
        database.inserIntoTable(fnameField.text , snameField.text, nikField.text, addressField.text, regDateField.text, " ")
        myModel.updateModel()
    }
    Text { x: 8; y: 8; width: 29; height: 16;text: qsTr("Имя")}
    TextField {id: fnameField ;x: 49;y: 8}
    Text { x: 189; y: 8;text: qsTr("Фамилия")}
    TextField { id: snameField ;x: 260;y: 8}
    Text { x: 396; y: 8;text: qsTr("Отчество")}
    TextField {id: nikField ;x: 464;y: 8}
    Text { x: 8; y: 45; width: 50; height: 20;text: qsTr("Адрес")}
    TextField {id: addressField ;x: 49;y: 45;width: 184;height: 22}
    Text { x: 8; y: 81;text: qsTr("Дата регистрации")}
    TextField { id: regDateField ;x: 131;y: 81}



}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1}D{i:2}D{i:3}D{i:4}D{i:5}D{i:6}D{i:7}
D{i:8}D{i:9}D{i:10}
}
##^##*/
