#include <QtQml>
#include <QtQml/QQmlContext>

#include "plugin.h"
#include "modelFetch.h"

void ModelFetchPlugin::registerTypes(const char *uri) {
    //@uri Example
    qmlRegisterType<ModelFetch>(uri, 1, 0, "ModelFetch");
}
