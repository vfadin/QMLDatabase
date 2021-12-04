import QtQuick 2.1
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.0

FocusScope {
    id: root
    signal recipeSelected(url url)

    ColumnLayout {
        spacing: 0
        anchors.fill: parent

        ToolBar {
            id: headerBackground
            Layout.fillWidth: true
            implicitHeight: headerText.height + 20

            Label {
                id: headerText
                width: parent.width
                text: qsTr("Список")
                padding: 10
                anchors.centerIn: parent
            }
        }

        ListView {
            id: listView
            Layout.fillWidth: true
            Layout.fillHeight: true
            keyNavigationWraps: true
            clip: true
            focus: true
            ScrollBar.vertical: ScrollBar { }

            model: recipeModel

            delegate: ItemDelegate {
                width: parent.width
                text: model.name
                contentItem: Text {
                    text: parent.text
                    font: parent.font
                    color: parent.enabled ? parent.Material.primaryTextColor
                                          : parent.Material.hintTextColor
                    elide: Text.ElideRight
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.Wrap
                }

                property url url: model.url
                highlighted: ListView.isCurrentItem

                onClicked: {
                    listView.forceActiveFocus()
                    listView.currentIndex = model.index
                }
            }

            onCurrentItemChanged: {
                root.recipeSelected(currentItem.url)
            }

            ListModel {
                id: recipeModel

                ListElement {
                    name: "Главное окно"
                    url: "qrc:///pages/main.html"
                }
                ListElement {
                    name: "Окно добавления пациента"
                    url: "qrc:///pages/add.html"
                }
                ListElement {
                    name: "Окно редактирования пациента"
                    url: "qrc:///pages/update.html"
                }
                ListElement {
                    name: "Окно 'Новый приём'"
                    url: "qrc:///pages/new.html"
                }
                ListElement {
                    name: "Окно 'Все приёмы'"
                    url: "qrc:///pages/all.html"
                }

            }

            ToolTip {
                id: help
                implicitWidth: root.width - padding * 3
                y: root.y + root.height
                delay: 1000
                timeout: 5000
                text: qsTr("Use keyboard, mouse, or touch controls to navigate through the\
                            items.")

                contentItem: Text {
                    text: help.text
                    font: help.font
                    color: help.Material.primaryTextColor
                    wrapMode: Text.Wrap
                }
            }
        }
    }

    function showHelp() {
        help.open()
    }
}

