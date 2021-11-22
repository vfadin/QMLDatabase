import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import Qt.labs.qmlmodels 1.0
Dialog {
    id: appointmentWindow
    width: 640
    height: 480
    title: "Новый приём"
//    Button {
    onAccepted: {
        database.insertAppointment(myModel.getId(tableView.currentRow), "Дата: " + dateAWField.text +
                                   "\nПричина обращения: " + reasonAWField.text +
                                   "\nЛечащий врач: " + docAWField.text +
                                   "\nВремя: " + timeAWField.text +
                                   "\nКабинет: " + roomAWField.text +
                                   "\nНазначения: " + recipeAWField.text +
                                   "\nРентген: " + imgAWField.text +
                                   "\n\n")
        myModel.updateModel();
        currentAppointmentViewWindow.openWithDestination("Дата: " + dateAWField.text +
                                                              "\nПричина обращения: " +  reasonAWField.text +
                                                              "\nЛечащий врач: " +  docAWField.text +
                                                              "\nВремя: " +  timeAWField.text +
                                                              "\nКабинет: " +  roomAWField.text +
                                                              "\nНазначения: " +  recipeAWField.text, imgAWField.text)
//        currentAppointmentViewWindow.openWithDestination(qsTr("Date"))
//        currentAppointmentViewWindow.open()
//    }
    }
    standardButtons: Dialog.Ok | Dialog.Cancel
    Text { x: 8; y: 8; width: 29; height: 16;text: qsTr("Дата")}
    TextField {id: dateAWField ;x: 73;y: 10}
    Text { x: 197; y: 8;text: qsTr("Причина обращения")}
    TextField { id: reasonAWField ;x: 197;y: 30;width: 412;height: 123}
    Text { x: 8; y: 94; width: 58; height: 31;text: qsTr("Лечащий\nврач")}
    TextField {id: docAWField ;x: 73;y: 94}
    Text { x: 9; y: 127; width: 58; height: 31;text: qsTr("Путь\nк снимку")}
    TextField {id: imgAWField ;x: 73;y: 127}
    Text { x: 8; y: 38; width: 41; height: 20;text: qsTr("Время")}
    TextField {id: timeAWField ;x: 73;y: 38;width: 102;height: 22}
    Text { x: 8; y: 64;text: qsTr("Кабинет")}
    TextField { id: roomAWField ;x: 73;y: 66;width: 102;height: 22}
    Text { x: 9; y: 174; width: 58; height: 31;text: qsTr("Назначения")}
    TextField {id: recipeAWField ;x: 9;y: 195;width: 600;height: 235}
}


