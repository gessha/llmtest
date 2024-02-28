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

import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

import Lomiri.Components 1.3

import Example 1.0
import Model 1.0

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'llmtest.georgi'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    PageStack {
        id: pageStack
        Component.onCompleted: pageStack.push(homePage);

        Home {
            id: homePage
            visible: false
        }

        ModelFetch {
            id: modelFetchPage
            visible: false
        }

        ModelSelect {
            id: modelSelectPage
            visible: false
        }
    }
}
