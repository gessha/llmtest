#include <QDebug>

#include "modelFetch.h"

ModelFetch::ModelFetch() {

}

void ModelFetch::speak(const QString &text) {
    qDebug() << "[ModelFetch::speak]" << text;
}
