#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QSql>
#include <QString>
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlDatabase>
#include <QFile>
#include <QDate>
#include <QDebug>

#define DATABASE_HOSTNAME   "NameDataBase"
#define DATABASE_NAME       "Name2.db"

#define TABLE                   "NameTable"         // Название таблицы
#define TABLE_FNAME             "FisrtName"         // Вторая колонка
#define TABLE_SNAME             "SurName"           // Третья колонка
#define TABLE_PATRONYMIC        "Patronymic"        // Четвертая колонка
#define TABLE_ADDRESS           "Address"           // Пятая колонка
#define TABLE_REGDATE           "Regdate"           // Шестая колонка
#define TABLE_INFO              "Info"              // Седьмая колонка


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
    bool inserIntoTable(const QString &fname, const QString &sname, const QString &patronymic, const QString &address, const QString &regdate, const QString &info);
    bool insertAppointment(const int id, const QString &info);
    QString getAppointment(const int id);
    QString getImgSource(const QString &info);
    bool removeRecord(const int id);
    bool updateRecord(const int id, const QString &fname, const QString &sname, const QString &patronymic, const QString &address, const QString &regdate);
};

#endif // DATABASE_H
