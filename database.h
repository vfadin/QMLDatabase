#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QSql>
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlDatabase>
#include <QFile>
#include <QDate>
#include <QDebug>

#define DATABASE_HOSTNAME   "NameDataBase"
#define DATABASE_NAME       "Name.db"

#define TABLE                   "NameTable"         // Название таблицы
#define TABLE_FNAME             "FisrtName"         // Вторая колонка
#define TABLE_SNAME             "SurName"           // Третья колонка
#define TABLE_PATRONYMIC               "Nik"               // Четвертая колонка

class DataBase : public QObject
{
    Q_OBJECT
public:
    explicit DataBase(QObject *parent = 0);
    ~DataBase();
    void connectToDataBase();

private:
    QSqlDatabase    db;

private:
    bool openDataBase();
    bool restoreDataBase();
    void closeDataBase();
    bool createTable();

public slots:
    bool inserIntoTable(const QVariantList &data);
    bool inserIntoTable(const QString &fname, const QString &sname, const QString &patronymic);
    bool removeRecord(const int id);
    bool updateRecord(const int id, const QString &fname, const QString &sname, const QString &patronymic);
};

#endif // DATABASE_H
