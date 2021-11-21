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
        qDebug() << "Не удалось создать базу данных";
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
                            TABLE_PATRONYMIC       " VARCHAR(255)    NOT NULL,"
                            TABLE_ADDRESS       " VARCHAR(255)    NOT NULL,"
                            TABLE_REGDATE       " VARCHAR(255)    NOT NULL"
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
                                             TABLE_PATRONYMIC ", "
                                             TABLE_ADDRESS ", "
                                             TABLE_REGDATE " ) "
                  "VALUES (:FName, :SName, :Patronymic, :Address, :RegDate)");
    query.bindValue(":FName",       data[0].toString());
    query.bindValue(":SName",       data[1].toString());
    query.bindValue(":Patronymic",  data[2].toString());
    query.bindValue(":Address",     data[3].toString());
    query.bindValue(":RegDate",     data[4].toString());

    if(!query.exec()){
        qDebug() << "error insert into " << TABLE;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}

bool DataBase::inserIntoTable(const QString &fname, const QString &sname, const QString &patronymic, const QString &address, const QString &regdate)
{
    QVariantList data;
    data.append(fname);
    data.append(sname);
    data.append(patronymic);
    data.append(address);
    data.append(regdate);
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

bool DataBase::updateRecord(const int id, const QString &fname, const QString &sname, const QString &patronymic, const QString &address, const QString &regdate)
{
    QSqlQuery query;
    query.prepare("UPDATE " TABLE " SET " TABLE_FNAME "= :FName , " TABLE_SNAME "= :SName , " TABLE_PATRONYMIC "= :Patronymic , " TABLE_ADDRESS "= :Address , " TABLE_REGDATE "= :RegDate WHERE id= :ID ;");
    query.bindValue(":ID", id);
    query.bindValue(":FName",       fname);
    query.bindValue(":SName",       sname);
    query.bindValue(":Patronymic",  patronymic);
    query.bindValue(":Address",  address);
    query.bindValue(":RegDate",  regdate);

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
