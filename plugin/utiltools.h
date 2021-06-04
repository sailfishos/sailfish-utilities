#include <QObject>
#include <QJSValue>
#include <QProcess>
#include <QHash>
#include <QPair>

class UtilTools: public QObject
{
    Q_OBJECT

public:
    UtilTools(QObject *parent = 0);
    virtual ~UtilTools();

    Q_INVOKABLE void cleanRpmDb(QJSValue successCallback = QJSValue::UndefinedValue,
                                QJSValue errorCallback = QJSValue::UndefinedValue);

    Q_INVOKABLE void cleanTrackerDb(QJSValue successCallback = QJSValue::UndefinedValue,
                                    QJSValue errorCallback = QJSValue::UndefinedValue);

    Q_INVOKABLE void restartNetwork(QJSValue successCallback = QJSValue::UndefinedValue,
                                    QJSValue errorCallback = QJSValue::UndefinedValue);

    Q_INVOKABLE void restartLipstick(QJSValue successCallback = QJSValue::UndefinedValue,
                                     QJSValue errorCallback = QJSValue::UndefinedValue);

    Q_INVOKABLE void resetAliendalvik(QJSValue successCallback = QJSValue::UndefinedValue,
                                     QJSValue errorCallback = QJSValue::UndefinedValue);

    Q_INVOKABLE bool dirExists(const QString &path);

private slots:
    void handleProcessExit(int exitCode, QProcess::ExitStatus status);

private:
    void execute(const QString &command, const QStringList &arguments,
                 QJSValue successCallback, QJSValue errorCallback);

    QHash<QProcess*, QPair<QJSValue, QJSValue> > m_pendingCalls;
};
