import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import Qt.labs.qmlmodels 1.0
Dialog {
    id: appointmentViewWindow
    standardButtons: Dialog.Ok | Dialog.Cancel
    title: "Все приемы"
    TextArea {
        text: database.getAppointment(myModel.getId(tableView.currentRow))
    }

}
