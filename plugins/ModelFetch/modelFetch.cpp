#include <QDebug>
#include <QUrl>
#include <QStandardPaths>
#include <QDir>

#include "modelFetch.h"

ModelFetch::ModelFetch() {
    qDebug() << "[ModelFetch::ModelFetch] initialization";
}

void ModelFetch::speak(const QString &text) {
    qDebug() << "[ModelFetch::speak]" << text;
}

void ModelFetch::saveModel(const QString &source_file){
    
    QUrl source_uri = QUrl(source_file);
    QString destination_dir = QStandardPaths::writableLocation(QStandardPaths::DataLocation);
    QUrl destination_uri = destination_dir + QDir::separator() + source_uri.fileName();
    QString destination_file = QString(destination_uri.toString());

    qDebug() << "[ModelFetch::saveModel] SRC: " << source_file;
    qDebug() << "[ModelFetch::saveModel] filename" << source_uri.fileName();
    qDebug() << "[ModelFetch::saveModel] destination" << destination_dir;
    qDebug() << "[ModelFetch::saveModel] DST: " << destination_file;

    if (!QFile::exists(destination_file)){
        if (QFile::copy(source_file, destination_file))
        {
            // File moved successfully, now delete the source file
            if(QFile::remove(source_file)){
                qDebug() << "[ModelFetch::saveModel] succesffully removed file";    
            }
            else {
                qDebug() << "[ModelFetch::saveModel] Error deleting file";
            }
        }
        else
        {
            // Handle error if the file couldn't be moved
            qDebug() << "[ModelFetch::saveModel] Error copying file";
        }
    }
    else {
        qDebug() << "[ModelFetch::saveModel] File already exists";
    }
}

// http://0.0.0.0:8080/