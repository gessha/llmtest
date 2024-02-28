#ifndef MODELFETCH_H
#define MODELFETCH_H

#include <QObject>

class ModelFetch: public QObject {
    Q_OBJECT

public:
    ModelFetch();
    ~ModelFetch() = default;

    Q_INVOKABLE void speak(const QString &text);
    Q_INVOKABLE void saveModel(const QString &uri);
//     Q_INVOKABLE void capitalizeAndDisplay(const QString &text);

// signals:
//     // Signal to emit the capitalized text
//     void displayCapitalizedText(const QString &text);

// public slots:
};

#endif
