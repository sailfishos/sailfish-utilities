
#ifndef SAILFISHAPPLICATION_H
#define SAILFISHAPPLICATION_H

class QString;
class QGuiApplication;
class QQuickView;

namespace Sailfish {

QGuiApplication *createApplication(int &argc, char **argv);
QQuickView *createView(const QString & = QString::null);
void setSource(QQuickView *view, const QString &file);
void showView(QQuickView* view);

}

#endif // SAILFISHAPPLICATION_H

