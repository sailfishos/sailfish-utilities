#include "utiltools.h"

#include <QDir>
#include <QDebug>
#include <qqmlinfo.h>

static QString SystemTool("sailfish_tools_system_action");

UtilTools::UtilTools(QObject *parent)
    : QObject(parent)
{
}

UtilTools::~UtilTools()
{
}

void UtilTools::cleanRpmDb(QJSValue successCallback, QJSValue errorCallback)
{
    execute(SystemTool, QStringList("repair_rpm_db"), successCallback, errorCallback);
}

void UtilTools::cleanTrackerDb(QJSValue successCallback, QJSValue errorCallback)
{
    execute(SystemTool, QStringList("tracker_reindex"), successCallback, errorCallback);
}

void UtilTools::restartNetwork(QJSValue successCallback, QJSValue errorCallback)
{
    execute(SystemTool, QStringList("restart_network"), successCallback, errorCallback);
}

void UtilTools::restartLipstick(QJSValue successCallback, QJSValue errorCallback)
{
    execute(SystemTool, QStringList("restart_lipstick"), successCallback, errorCallback);
}

void UtilTools::resetAliendalvik(QJSValue successCallback, QJSValue errorCallback)
{
    execute(SystemTool, QStringList("reset_aliendalvik"), successCallback, errorCallback);
}

bool UtilTools::dirExists(const QString &path)
{
    return QDir(path).exists();
}

void UtilTools::handleProcessExit(int exitCode, QProcess::ExitStatus status)
{
    QProcess *process = qobject_cast<QProcess*>(sender());

    if (!m_pendingCalls.contains(process)) {
        qmlInfo(this) << "Exit from unknown process";
        return;
    }

    QPair<QJSValue, QJSValue> callbacks = m_pendingCalls.take(process);

    if (status == QProcess::NormalExit && exitCode == 0) {
        if (callbacks.first.isCallable()) {
            QJSValue result = callbacks.first.call();
            if (result.isError()) {
                qmlInfo(this) << "Error executing callback";
            }
        }
    } else if (callbacks.second.isCallable()) {
        QJSValue result = callbacks.second.call(QJSValueList() << QJSValue(exitCode));
        if (result.isError()) {
            qmlInfo(this) << "Error executing error callback";
        }
    }
}

void UtilTools::execute(const QString &command, const QStringList &arguments, QJSValue successCallback, QJSValue errorCallback)
{
    QProcess *process = new QProcess;
    connect(process, SIGNAL(finished(int,QProcess::ExitStatus)), this, SLOT(handleProcessExit(int,QProcess::ExitStatus)));
    m_pendingCalls.insert(process, QPair<QJSValue,QJSValue>(successCallback, errorCallback));
    process->start(command, arguments);
}
