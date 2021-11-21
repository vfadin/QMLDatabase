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
                            TABLE_PATRONYMIC" VARCHAR(255)    NOT NULL,"
                            TABLE_ADDRESS   " VARCHAR(255)    NOT NULL,"
                            TABLE_REGDATE   " VARCHAR(255)    NOT NULL,"
                            TABLE_INFO      " VARCHAR(255)    NOT NULL"
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
    qDebug() << query.lastError().text();
    query.prepare("INSERT INTO " TABLE " ( " TABLE_FNAME ", "
                                             TABLE_SNAME ", "
                                             TABLE_PATRONYMIC ", "
                                             TABLE_ADDRESS ", "
                                             TABLE_REGDATE ", "
                                             TABLE_INFO " ) "
                  "VALUES (:FName, :SName, :Patronymic, :Address, :RegDate, :Info)");
    query.bindValue(":FName",       data[0].toString());
    query.bindValue(":SName",       data[1].toString());
    query.bindValue(":Patronymic",  data[2].toString());
    query.bindValue(":Address",     data[3].toString());
    query.bindValue(":RegDate",     data[4].toString());
    query.bindValue(":Info",        data[5].toString());

    qDebug() << query.lastError().text();
    if(!query.exec()){
        qDebug() << "error insert into " << TABLE;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}

bool DataBase::inserIntoTable(const QString &fname, const QString &sname, const QString &patronymic, const QString &address, const QString &regdate, const QString &info)
{
    QVariantList data;
    data.append(fname);
    data.append(sname);
    data.append(patronymic);
    data.append(address);
    data.append(regdate);
    data.append(info);

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

bool DataBase::insertAppointment(const int id, const QString &info) {
    QSqlQuery query;
    qDebug() << info;
    query.prepare("UPDATE " TABLE " SET " TABLE_INFO " = " TABLE_INFO " || :Info WHERE id= :ID ;");
    query.bindValue(":ID",  id);
    query.bindValue(":Info",info);
    qDebug() << query.lastQuery();
    if(!query.exec()){
        qDebug() << "error update row " << TABLE;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}

QString DataBase::getAppointment(const int id) {
    QSqlQuery query;
    query.prepare("SELECT " TABLE_INFO " FROM " TABLE " WHERE id= :ID ;");
    query.bindValue(":ID",  id);
    query.exec();
    query.next();
    qDebug() << id;
//    qDebug() << query.lastError().text();
//    qDebug() << query.value(0).toString();
//    qDebug() << query.size();
    return query.value(0).toString();
}

QString DataBase::getImgSource(const QString &info) {
    int from = info.indexOf("Рентген: ") + 9;
    int to = info.indexOf("\n", from) - from;
    qDebug() << info.mid(from, to);
    return info.mid(from, to);
}
