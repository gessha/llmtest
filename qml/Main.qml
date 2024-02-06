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
import Lomiri.Components 1.3
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

import Example 1.0

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'llmtest.georgi'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    Page {
        anchors.fill: parent

        header: PageHeader {
            id: header
            title: i18n.tr('llmtest')
        }

        ColumnLayout {
            spacing: units.gu(2)
            anchors {
                margins: units.gu(2)
                top: header.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }

            Item {
                Layout.fillHeight: true
            }

            TextField {
                id: upperTextField
                Layout.fillWidth: true
                Layout.preferredHeight: parent.height * 0.25
                placeholderText: i18n.tr('Enter text here...')
            }

            TextField {
                id: lowerTextField
                Layout.fillWidth: true
                Layout.preferredHeight: parent.height * 0.25
                placeholderText: i18n.tr('Text will appear here...')
            }

            Button {
                Layout.alignment: Qt.AlignHCenter
                text: i18n.tr('Press here!')
                onClicked: Example.speak(upperTextField.text) 
            }

            Item {
                Layout.fillHeight: true
            }
        }
    }
}
