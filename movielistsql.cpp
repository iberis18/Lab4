#include "movielistsql.h"
#include "QObject"

movieListSQL::movieListSQL(QObject *parent) :
    QSqlQueryModel(parent)
{

    db = QSqlDatabase::addDatabase("QPSQL");
    db.setDatabaseName("Movie");
    db.setPort(5432);
    db.setPassword("1111");
    db.setUserName("postgres");

    QSqlQuery query(db);
    //db.open();

     _isConnectionOpen = true;

    if(!db.open())
    {
        qDebug() << db.lastError().text();
        _isConnectionOpen = false;
    }

    /*QString m_schema = QString( "CREATE TABLE IF NOT EXISTS movies (Id SERIAL PRIMARY KEY, Name text, Genre text, Year text, Director text, Age text);" );
    QSqlQuery qry(m_schema, db);

    if( !qry.exec() )
    {
        qDebug() << db.lastError().text();
        _isConnectionOpen = false;
    }

    add("tdryubkjnlm", "gvhbjkn", "dfcghvjbkn", "chvjb", "vhbnj");*/

    refresh();
}

QSqlQueryModel* movieListSQL::getModel(){
    return this;
}
bool movieListSQL::isConnectionOpen(){
    return _isConnectionOpen;
}
QHash<int, QByteArray> movieListSQL::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[Qt::UserRole + 2] = "NameOfMovie";
    roles[Qt::UserRole + 3] = "GenreOfMovie";
    roles[Qt::UserRole + 4] = "YearOfMovie";
    roles[Qt::UserRole + 5] = "DirectorOfMovie";
    roles[Qt::UserRole + 6] = "AgeOfMovie";
    roles[Qt::UserRole + 1] = "Id_movie";

    return roles;
}

QVariant movieListSQL::data(const QModelIndex &index, int role) const
{
    QVariant value = QSqlQueryModel::data(index, role);
    if(role < Qt::UserRole-1)
    {
        value = QSqlQueryModel::data(index, role);
    }
    else
    {
        int columnIdx = role - Qt::UserRole - 1;
        QModelIndex modelIndex = this->index(index.row(), columnIdx);
        value = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
    }
    return value;
}

const char* movieListSQL::SQL_SELECT =
        "SELECT *"
        "FROM movies";

void movieListSQL::refresh()
{
    this->setQuery(movieListSQL::SQL_SELECT,db);
    qDebug() << db.lastError().text();
}

void movieListSQL::add(const QString& nameMov, const QString& genreMov, const QString& yearMov, const QString& directorMov, const QString& ageMov){

    QSqlQuery query(db);
    QString strQuery= QString("INSERT INTO movies (Name,Genre,Year,Director,Age) VALUES ('%1', '%2', '%3', '%4', '%5')")
            .arg(nameMov)
            .arg(genreMov)
            .arg(yearMov)
            .arg(directorMov)
            .arg(ageMov);
    bool a = query.exec(strQuery);
    qDebug() << a;

    refresh();
}

void movieListSQL::edit(const QString& nameMov, const QString& genreMov, const QString& yearMov, const QString& directorMov, const QString& ageMov, const int Id_movie){

    QSqlQuery query(db);
    QString strQuery= QString("UPDATE movies SET Name = '%1',Genre = '%2',Year = '%3',Director = '%4', Age = '%5'  WHERE Id = %6")
            .arg(nameMov)
            .arg(genreMov)
            .arg(yearMov)
            .arg(directorMov)
            .arg(ageMov)
            .arg(Id_movie);
    bool a = query.exec(strQuery);
    qDebug() << a;

    refresh();
}

void movieListSQL::del(const int Id_movie){

    QSqlQuery query(db);
    QString strQuery= QString("DELETE FROM movies WHERE Id = %1")
            .arg(Id_movie);
    bool a = query.exec(strQuery);
    qDebug() << a;

    refresh();
}
