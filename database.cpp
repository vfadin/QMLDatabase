#include "database.h"

DataBase::DataBase(QObject *parent) : QObject(parent)
{

}

DataBase::~DataBase()
{

}

void DataBase::connectToDataBase()
{
    if(!QFile("/home/boss/repos/untitled/" DATABASE_NAME).exists()){
        this->restoreDataBase();
    } else {
        this->openDataBase();
    }
}

bool DataBase::restoreDataBase()
{
    if(this->openDataBase()){
        return (this->createTable()) ? true : false;
    } else {
        qDebug() << "Не удалось восстановить базу данных";
        return false;
    }
    return false;
}

bool DataBase::openDataBase()
{
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setHostName(DATABASE_HOSTNAME);
    db.setDatabaseName("/home/boss/repos/untitled/" DATABASE_NAME);
    if(db.open()){
        return true;
    } else {
        return false;
    }
}

void DataBase::closeDataBase()
{
    db.close();
}

bool DataBase::createTable()
{
    QSqlQuery query;
    if(!query.exec( "CREATE TABLE " TABLE " ("
                            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                            TABLE_FNAME     " VARCHAR(255)    NOT NULL,"
                            TABLE_SNAME     " VARCHAR(255)    NOT NULL,"
                            TABLE_PATRONYMIC       " VARCHAR(255)    NOT NULL"
                        " )"
                    )){
        qDebug() << "DataBase: error of create " << TABLE;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}

bool DataBase::inserIntoTable(const QVariantList &data)
{
    QSqlQuery query;
    query.prepare("INSERT INTO " TABLE " ( " TABLE_FNAME ", "
                                             TABLE_SNAME ", "
                                             TABLE_PATRONYMIC " ) "
                  "VALUES (:FName, :SName, :Patronymic)");
    query.bindValue(":FName",       data[0].toString());
    query.bindValue(":SName",       data[1].toString());
    query.bindValue(":Patronymic",         data[2].toString());

    if(!query.exec()){
        qDebug() << "error insert into " << TABLE;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}

bool DataBase::inserIntoTable(const QString &fname, const QString &sname, const QString &patronymic)
{
    QVariantList data;
    data.append(fname);
    data.append(sname);
    data.append(patronymic);

    if(inserIntoTable(data))
        return true;
    else
        return false;
}

bool DataBase::removeRecord(const int id)
{
    QSqlQuery query;
    query.prepare("DELETE FROM " TABLE " WHERE id= :ID ;");
    query.bindValue(":ID", id);

    if(!query.exec()){
        qDebug() << "error delete row " << TABLE;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}

bool DataBase::updateRecord(const int id, const QString &fname, const QString &sname, const QString &patronymic)
{
    QSqlQuery query;
    query.prepare("UPDATE " TABLE " SET " TABLE_FNAME "= :FName , " TABLE_SNAME "= :SName , " TABLE_PATRONYMIC "= :Patronymic  WHERE id= :ID ;");
    query.bindValue(":ID", id);
    query.bindValue(":FName",       fname);
    query.bindValue(":SName",       sname);
    query.bindValue(":Patronymic",         patronymic);

    qDebug() << query.lastError().text() << '\n';
    if(!query.exec()){
        qDebug() << "error update row " << TABLE;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}
