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

#include <QDebug>

#include "example.h"

Example::Example() {

}

void Example::speak(const QString &text) {
    qDebug() << "[Example::speak]" << text;
}

// void Example::capitalizeAndDisplay(const QString &text) {
//     qDebug() << "Original text: " << text;

//     // Capitalize the text
//     QString capitalizedText = text.toUpper();
//     qDebug() << "New text: " << capitalizedText;

//     // Emit the signal with the capitalized text
//     emit displayCapitalizedText(capitalizedText);
// }