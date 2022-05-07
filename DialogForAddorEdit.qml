import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.5   // это версия библиотеки, содержащей Contol (аналоги виджетов) для версии Qt 5.6
import QtQuick.Layouts 1.2


Window {
    id: root
    modality: Qt.ApplicationModal  // окно объявляется модальным
    title: qsTr("Добавление информации о фильме")
    minimumWidth: 400
    maximumWidth: 400
    minimumHeight: 200
    maximumHeight: 200

    property bool isEdit: false
    property int currentIndex: -1

    GridLayout {
        anchors { left: parent.left; top: parent.top; right: parent.right; bottom: buttonCancel.top; margins: 10 }
        columns: 2

        Label {
                Layout.alignment: Qt.AlignRight  // выравнивание по правой стороне
                text: qsTr("Название фильма:")
            }
            TextField {
                id: textName
                Layout.fillWidth: true
                placeholderText: qsTr("Введите название")
            }
            Label {
                Layout.alignment: Qt.AlignRight
                text: qsTr("Жанр:")
            }
            TextField {
                id: textGenre
                Layout.fillWidth: true
                placeholderText: qsTr("Введите жанр")
            }
            Label {
                Layout.alignment: Qt.AlignRight
                text: qsTr("Год выхода:")
            }
            TextField {
                id: textYear
                Layout.fillWidth: true
                placeholderText: qsTr("Введите год")
            }
            Label {
                Layout.alignment: Qt.AlignRight
                text: qsTr("Режиссер:")
            }
            TextField {
                id: textDirector
                Layout.fillWidth: true
                placeholderText: qsTr("Введите ФИО режиссера")
            }
            Label {
                Layout.alignment: Qt.AlignRight
                text: qsTr("Возрастные ограничения:")
            }
            TextField {
                id: textAge
                Layout.fillWidth: true
                placeholderText: qsTr("Введите возрастные ограничения")
            }
    }

    Button {
        anchors { right: buttonCancel.left; verticalCenter: buttonCancel.verticalCenter; rightMargin: 10 }
        text: qsTr("ОК")
        width: 100
        onClicked: {
            root.hide()
            if (currentIndex<0)
            {
                add(textName.text, textGenre.text, textYear.text, textDirector.text, textAge.text)
            }
            else
            {
                edit(textName.text, textGenre.text, textYear.text, textDirector.text, textAge.text, root.currentIndex)
            }

        }
    }

    Button {
        id: buttonCancel
        anchors { right: parent.right; bottom: parent.bottom; rightMargin: 10; bottomMargin: 10 }
        text: qsTr("Отменить")
        width: 100
        onClicked: {
             root.hide()
        }
    }

    // изменение статуса видимости окна диалога
    onVisibleChanged: {
      if (visible && currentIndex < 0) {
          textName.text = ""
          textGenre.text = ""
          textYear.text = ""
          textDirector.text = ""
          textAge.text = ""
      }
    }

    function execute(name, genre, year, director, age, index){
            textName.text = name
            textGenre.text = genre
            textYear.text = year
            textDirector.text = director
            textAge.text = age
            root.currentIndex = index

            root.show()
        }
 }
