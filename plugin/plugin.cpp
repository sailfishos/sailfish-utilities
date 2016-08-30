#include <QQmlExtensionPlugin>
#include <QTranslator>
#include <QGuiApplication>
#include <QQmlEngine>
#include <QLocale>
#include <QDebug>

#include <qqml.h>

#include "utiltools.h"

static QObject *utilFactory(QQmlEngine *, QJSEngine *)
{
    return new UtilTools;
}

class UtilitiesPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "Sailfish.Utilities")

public:
    void initializeEngine(QQmlEngine *engine, const char *uri)
    {
        Q_UNUSED(uri)
        Q_UNUSED(engine)
        Q_ASSERT(QLatin1String(uri) == QLatin1String("Sailfish.Utilities"));
    }

    virtual void registerTypes(const char *uri)
    {
        Q_UNUSED(uri)
        Q_ASSERT(QLatin1String(uri) == QLatin1String("Sailfish.Utilities"));

        qmlRegisterSingletonType<UtilTools>("Sailfish.Utilities", 1, 0, "UtilTools", &utilFactory);
    }
};

#include "plugin.moc"
