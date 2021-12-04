import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import Qt.labs.qmlmodels 1.0
import QtQuick.Controls.Styles 1.4

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
ApplicationWindow {
    width: 640
    height: 480
    title: qsTr("Dental Service")
    id: mainWindow
    menuBar: mainWindowMenu
    MenuBar {
        id: mainWindowMenu
        Menu {
            title: "Помощь"
            MenuItem {
                id: referenceButton
                text: "Справка"
                shortcut: "f1"
                onTriggered: {
                    helpWindow.show()
                }
            }
        }
    }

    RowLayout {
        id: rowLayout
        anchors.top: mainWindowMenu.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 5

        Button {
            text: qsTr("Новый пациент")
            onClicked: {
                registrationWindow.open()
            }
        }


    }
    TextField {
        id: searchField
        anchors.top: rowLayout.top
        anchors.right: searchButton.left
    }

    Button {
        id: searchButton
        anchors.top: rowLayout.top
        anchors.right: rowLayout.right
        text: qsTr("Поиск")
        onClicked: {
            myModel.nameSearch(searchField.text)
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
            role: "sname"
            title: "Фамилия"
        }
        TableViewColumn {
            role: "fname"
            title: "Имя"
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

        model: myModel


        rowDelegate: Rectangle {
            anchors.fill: parent
            color: styleData.selected ? 'skyblue' : (styleData.alternate ? 'whitesmoke' : 'white');
            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.RightButton | Qt.LeftButton
                onClicked: {
                    if(searchField.text == ""){
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
    }

    Menu {
        id: contextMenu

        MenuItem {
            text: qsTr("Удалить")
            onTriggered: {
                deleteWindow.open()
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
                appointmentViewWindow.openWithDestination(database.getAppointment(myModel.getId(tableView.currentRow)))
            }
        }
    }

    MyDialogWindow {
        id: registrationWindow
    }

    MyUpdateWindow {
        id: updateWindow
    }

    MyAppointmentWindow {
        id: appointmentWindow

    }

    MyCurrentAppointmentViewWindow {
        id: currentAppointmentViewWindow
    }

    MyAppointmentViewWindow {
        id: appointmentViewWindow
    }

    Dialog {
        id: deleteWindow
        title: "Подтвердите удаление"
        Label {
            text: "Вы действительно хотите удалить запись?"
        }

        standardButtons: Dialog.Ok | Dialog.Cancel
        onAccepted: {
            database.removeRecord(myModel.getId(tableView.currentRow))
            myModel.updateModel();
        }
    }

    MyReferenceWindow {
        id: referenceWindow
    }

    MyHelpWindow {
        id: helpWindow
    }

}
}

