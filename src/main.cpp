#include <qglobal.h>

#if QT_VERSION >= 0x050000
#include <QQuickView>
#include <QGuiApplication>
#else
#include <QApplication>
#include <QDeclarativeView>
#endif

int main(int argc, char *argv[])
{

#if QT_VERSION >= 0x050000
    QScopedPointer<QGuiApplication> app(new QGuiApplication(argc, argv));
    QScopedPointer<QQuickView> view(new QQuickView());
    view->setSource(QUrl("qrc:/qml/qml/QtQuick2/main.qml"));
#else
    QScopedPointer<QApplication> app(new QApplication(argc, argv));
    QScopedPointer<QDeclarativeView> view(new QDeclarativeView());
    view->setSource(QUrl("qrc:/qml/qml/QtQuick1/main.qml"));
#endif
    
    view->show();

    return app->exec();
}
