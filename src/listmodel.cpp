#include "../header/listmodel.h"
#include "../header/database.h"

ListModel::ListModel(QObject *parent) :
    QSqlQueryModel(parent)
{
    this->updateModel();
}

QVariant ListModel::data(const QModelIndex & index, int role) const {

    // Определяем номер колонки, адрес так сказать, по номеру роли
    int columnId = role - Qt::UserRole - 1;
    // Создаём индекс с помощью новоиспечённого ID колонки
    QModelIndex modelIndex = this->index(index.row(), columnId);

    /* И с помощью уже метода data() базового класса
     * вытаскиваем данные для таблицы из модели
     * */
    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}

// Метод для получения имен ролей через хешированную таблицу.
QHash<int, QByteArray> ListModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[FNameRole] = "fname";
    roles[SNameRole] = "sname";
    roles[PatronymicRole] = "patronymic";
    roles[Address] = "address";
    roles[RegDate] = "regdate";
    roles[Info] = "info";
    return roles;
}

void ListModel::updateModel()
{
    this->setQuery("SELECT id, " TABLE_FNAME ", " TABLE_SNAME ", " TABLE_PATRONYMIC ", " TABLE_ADDRESS ", " TABLE_REGDATE ", " TABLE_INFO " FROM " TABLE);
}

int ListModel::getId(int row)
{
    return this->data(this->index(row, 0), IdRole).toInt();
}

void ListModel::nameSearch(const QString &search) {
    qDebug() << search;
    int fnameend = search.indexOf(" ");
    int snameend = search.indexOf(" ", fnameend);
    qDebug() << search.mid(0, fnameend) + " " + search.mid(fnameend + 1, snameend) + search.mid(snameend + 1, search.size());
    this->setQuery("SELECT * FROM " TABLE " WHERE " TABLE_SNAME " LIKE '" + search.mid(0, fnameend) +
                   "%' OR " TABLE_FNAME " LIKE '" + search.mid(fnameend + 1, snameend) +
                   "%' OR " TABLE_PATRONYMIC " LIKE '" + search.mid(snameend + 1, search.size()) +
                   "%' OR " TABLE_INFO " LIKE '%Лечащий врач: " + search + "%'");
}

void ListModel::doctorSearch(const QString &search) {
    qDebug() << search;
    this->setQuery("SELECT * FROM " TABLE " WHERE " TABLE_INFO " LIKE '%Лечащий врач: " + search + "%'");
}
