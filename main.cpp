#include <QGuiApplication>
#include <QQuickView>
#include <QQmlEngine>
#include <QQmlContext>

#include "sailfishapplication.h"


Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QGuiApplication> app(Sailfish::createApplication(argc, argv));
    app->setApplicationName("sailfish-tiny-tools");
    QScopedPointer<QQuickView> view(Sailfish::createView());
    view->setTitle("Sailfish Tiny Tools");
    Sailfish::setSource(view.data(), "Main.qml");
    Sailfish::showView(view.data());
    return app->exec();
}
