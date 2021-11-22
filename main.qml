import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import Qt.labs.qmlmodels 1.0
Window {
    id: splash
    color: "transparent"
    title: "Splash Window"
    modality: Qt.ApplicationModal
    flags: Qt.SplashScreen
    property int timeoutInterval: 2000
    signal timeout
    x: (Screen.width - splashImage.width) / 2
    y: (Screen.height - splashImage.height) / 2
    width: splashImage.width
    height: splashImage.height

    Image {
        id: splashImage
        source: "file://home/boss/trash/sender.png"
    }
    Timer {
        interval: timeoutInterval; running: true; repeat: false
        onTriggered: {
            visible = false
            splash.timeout()
            mainWindow.show()
        }
    }

    Component.onCompleted: visible = true
Window {
    width: 640
    height: 480
    title: qsTr("Dental Service")
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

        TextField {
            id: searchField
        }

        Button {
            text: qsTr("Искать по ФИО")
            onClicked: {
                myModel.nameSearch(searchField.text)
            }
        }

        Button {
            text: qsTr("Поиск по врачу")
            onClicked: {
                myModel.doctorSearch(searchField.text)
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
        TableViewColumn {
            role: "address"
            title: "Адрес"
        }
        TableViewColumn {
            role: "regdate"
            title: "Дата регистрации"
        }
        TableViewColumn {
            role: "info"
            title: "Информация о приёме"
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
                updateWindow.open()

            }
        }
        MenuItem {
            text: qsTr("Новый приём")
            onTriggered: {
                appointmentWindow.open()
            }
        }
        MenuItem {
            text: qsTr("Все приёмы")
            onTriggered: {
                myModel.updateModel();
                appointmentViewWindow.open()
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

    MyAppointmentWindow {
        id: appointmentWindow
        MyCurrentAppointmentViewWindow {
            id: currentAppointmentViewWindow
        }
    }

    MyAppointmentViewWindow {
        id: appointmentViewWindow
    }


}
}
/*##^##
Designer {
    D{i:0;formeditorZoom:0.75}
}
##^##*/
