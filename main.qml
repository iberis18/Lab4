import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.5  // это версия библиотеки, содержащей Contol (аналоги виджетов) для версии Qt 5.6
import QtQuick.Layouts 1.2


Window {
    visible: true
    width: 800
    height: 550
    title: qsTr("Справочник фильмов")

    // объявляется системная палитра
    SystemPalette {
          id: palette;
          colorGroup: SystemPalette.Active
       }

    Rectangle{
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: btnAdd.top
        anchors.bottomMargin: 8
        border.color: "gray"
    ScrollView {
        anchors.fill: parent
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        //flickableItem.interactive: true  // сохранять свойство "быть выделенным" при потере фокуса мыши
        Text {
            anchors.fill: parent
            text: "Could not connect to SQL"
            color: "red"
            font.pointSize: 20
            font.bold: true
            visible: IsConnectionOpen === false
        }
        ListView {
            id: movList
            anchors.fill: parent
            model: movieModel // назначение модели, данные которой отображаются списком
            delegate: DelegateForMovie{}
            clip: true //
            activeFocusOnTab: true  // реагирование на перемещение между элементами ввода с помощью Tab
            focus: true  // элемент может получить фокус
            //opacity: {if (IsConnectionOpen === true) {100} else {0}}
        }
    }
   }

    Button {
        id: btnAdd
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.rightMargin: 8
        anchors.right:btnEdit.left
        text: "Добавить"
        width: 100

        onClicked: {
            windowAddEdit.currentIndex = -1
            windowAddEdit.show()
        }
    }

    Button {
        id: btnEdit
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.right: btnDel.left
        anchors.rightMargin: 8
        text: "Редактировать"
        width: 100
        onClicked: {
            var nameM = movList.currentItem.movieData.NameOfMovie
            var genreM = movList.currentItem.movieData.GenreOfMovie
            var yearM = movList.currentItem.movieData.YearOfMovie
            var directorM = movList.currentItem.movieData.DirectorOfMovie
            var ageM = movList.currentItem.movieData.AgeOfMovie
            var mID = movList.currentItem.movieData.Id_movie

            windowAddEdit.execute(nameM, genreM, yearM, directorM, ageM, mID)
        }
    }

    Button {
        id: btnDel
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.right:parent.right
        anchors.rightMargin: 8
        text: "Удалить"
        width: 100
        enabled: {
            if (movList.currentItem==null || movList.currentItem.movieData == null)
            {false}
            else
            {movList.currentItem.movieData.Id_movie >= 0} }
        onClicked: del(movList.currentItem.movieData.Id_movie)
    }

    DialogForAddorEdit {
        id: windowAddEdit
    }
}
