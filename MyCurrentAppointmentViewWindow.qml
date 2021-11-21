import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import Qt.labs.qmlmodels 1.0
Dialog {
    id: currentAppointmentViewWindow
    TextArea {
        id: textAppointment
        x: 8
        y: 8
        width: 423
        height: 464
//        text: database.getAppointment(myModel.getId(tableView.currentRow))
        text: "Дата: " + dateAWField.text +
              "\nПричина обращения: " + reasonAWField.text +
              "\nЛечащий врач: " + docAWField.text +
              "\nВремя: " + timeAWField.text +
              "\nКабинет: " + roomAWField.text +
              "\nНазначения: " + recipeAWField.text +
              "\nРентген: " + imgAWField.text +
              "\n\n"
    }

    Image {
        x: 440
        y: 8
        width: 192
        height: 192
        source: "file:/" + imgAWField.text
        visible: true
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1}D{i:2}
}
##^##*/
