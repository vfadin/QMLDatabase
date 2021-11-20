import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import Qt.labs.qmlmodels 1.0
Window {

    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    id: mainWindow
    RowLayout {
        id: rowLayout
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 5

        Button {
            text: qsTr("Добавить")
            onClicked: {
                registrationWindow.open()
            }
        }

    }

    TableView {
        id: tableView
        anchors.top: rowLayout.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 5

        TableViewColumn {
            role: "fname"
            title: "Имя"
        }
        TableViewColumn {
            role: "sname"
            title: "Фамилия"
        }
        TableViewColumn {
            role: "patronymic"
            title: "Отчество"
        }

        model: myModel


        rowDelegate: Rectangle {
            anchors.fill: parent
            color: styleData.selected ? 'skyblue' : (styleData.alternate ? 'whitesmoke' : 'white');
            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.RightButton | Qt.LeftButton
                onClicked: {
                    tableView.selection.clear()
                    tableView.selection.select(styleData.row)
                    tableView.currentRow = styleData.row
                    tableView.focus = true

                    switch(mouse.button) {
                        case Qt.RightButton:
                            contextMenu.popup()
                            break
                        default:
                            break
                    }
                }
            }
        }
    }

    Menu {
        id: contextMenu

        MenuItem {
            text: qsTr("Удалить")
            onTriggered: {
                database.removeRecord(myModel.getId(tableView.currentRow))
                myModel.updateModel();
            }
        }
        MenuItem {
            text: qsTr("Редактировать")
            onTriggered: {
//                database.updateRecord(myModel.getId(tableView.currentRow), )
//                myModel.updateModel();
                updateWindow.open()
            }
        }
    }

     /*MessageDialog {

        id: dialogDelete
        title: qsTr("Удаление записи")
        text: qsTr("Подтвердите удаление записи из журнала")
        icon: StandardIcon.Warning
        standardButtons: StandardButton.Ok | StandardButton.Cancel
        onAccepted: {
            console.log("remove")
            database.removeRecord(myModel.getId(tableView.currentRow))
            myModel.updateModel();
        }
        onRejected: {
            console.log("eee")
        }
    }*/

    MyDialogWindow {
        id: registrationWindow
    }

    MyUpdateWindow {
        id: updateWindow
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.75}
}
##^##*/
