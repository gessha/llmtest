/*
 * Copyright (C) 2024  Georgi Georgiev
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * llmtest is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef MODEL_H
#define MODEL_H

#include <QObject>

class Model: public QObject {
    Q_OBJECT

public:
    Model();
    ~Model() = default;

    Q_INVOKABLE void speak(const QString &text);
//     Q_INVOKABLE void capitalizeAndDisplay(const QString &text);

// signals:
//     // Signal to emit the capitalized text
//     void displayCapitalizedText(const QString &text);

// public slots:
};

#endif
