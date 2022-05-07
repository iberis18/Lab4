import QtQuick 2.6
import QtQuick.Controls 2.5  // это версия библиотеки, содержащей Contol (аналоги виджетов) для версии Qt 5.6
import QtQuick.Layouts 1.2

Rectangle {
    id: movItem
    readonly property color evenBackgroundColor: "#E0FFFF"  // цвет для четных пунктов списка
    readonly property color oddBackgroundColor: "#B0C4DE"   // цвет для нечетных пунктов списка
    readonly property color selectedBackgroundColor: "#00FFFF"  // цвет выделенного элемента списка

    property bool isCurrent: movItem.ListView.view.currentIndex === index   // назначено свойство isCurrent истинно для текущего (выделенного) элемента списка
    property bool selected: movItemMouseArea.containsMouse || isCurrent // назначено свойство "быть выделенным",
    //которому присвоено значение "при наведении мыши,
    //или совпадении текущего индекса модели"

    property variant movieData: model // свойство для доступа к данным конкретного студента

    width: parent ? parent.width : movList.width
    height: 160

    // состояние текущего элемента (Rectangle)
    states: [
        State {
            when: selected
            // как реагировать, если состояние стало selected
            PropertyChanges { target: movItem;  // для какого элемента должно назначаться свойство при этом состоянии (selected)
                color: isCurrent ? palette.highlight : selectedBackgroundColor  /* какое свойство целевого объекта (Rectangle)
                                                                                                  и какое значение присвоить*/
            }
        },
        State {
            when: !selected
            PropertyChanges { target: movItem;  color: isCurrent ? palette.highlight : index % 2 == 0 ? evenBackgroundColor : oddBackgroundColor }
        }
    ]

    MouseArea {
        id: movItemMouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            movItem.ListView.view.currentIndex = index
            movItem.forceActiveFocus()
        }
    }
    Item {
            id: itemOfMovies
            width: parent.width
            height: 160
            Column{
                id: t2
                anchors.left: parent.left
                anchors.leftMargin: 10
                width: 240
                anchors.verticalCenter: parent.verticalCenter
                Text {
                    id: t0
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "ID:"
                    color: "DarkBlue"
                    font.pointSize: 12
                }
                Text {
                    id: textid
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: Id_movie
                    color: "DarkBlue"
                    font.pointSize: 18
                    font.bold: true
                }
                Text {
                    id: t1
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Название фильма:"
                    color: "DarkBlue"
                    font.pointSize: 12
                }
                Text {
                    id: textName
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: NameOfMovie
                    color: "DarkBlue"
                    font.pointSize: 18
                    font.bold: true
                }
            }
            Column{
                anchors.left: t2.right
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                Text {
                    text: "Жанр:"
                    color: "DarkBlue"
                    font.pointSize: 10
                }
                Text {
                    id: textLenght
                    text: GenreOfMovie
                    color: "DarkBlue"
                    font.pointSize: 12
                    font.bold: true
                }
                Text {
                    text: "Год выхода:"
                    color: "DarkBlue"
                    font.pointSize: 10
                }
                Text {
                    id: textFlow
                    color: "DarkBlue"
                    text: YearOfMovie
                    font.pointSize: 12
                    font.bold: true
                }
                Text {
                    text: "Режиссер:"
                    color: "DarkBlue"
                    font.pointSize: 10
                }
                Text {
                    id: textRunoff
                    text: DirectorOfMovie
                    color: "DarkBlue"
                    font.pointSize: 12
                    font.bold: true
                }
                Text {
                    text: "Возрастные ограничения:"
                    color: "DarkBlue"
                    font.pointSize: 10
                }
                Text {
                    id: textArea
                    color: "DarkBlue"
                    text: AgeOfMovie
                    font.pointSize: 12
                    font.bold: true
                }
            }

        }
}
