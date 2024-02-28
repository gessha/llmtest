import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

import Lomiri.Components 1.3

import Example 1.0
import Model 1.0

Page {
    id: homePage
    anchors.fill: parent
    property string selectedFile: ""

    Model {
        id: ml_model
    }

    header: PageHeader {
        id: header
        title: i18n.tr('Local LLM test')

        /* the menu on the right side */
        trailingActionBar.actions: [

            Action {
               iconName: "import"
               text: i18n.tr("Model Fetch")
               onTriggered:{
                   pageStack.push(modelFetchPage);
               }
            },

            Action {
               iconName: "select"
               text: i18n.tr("Model Select")
               onTriggered:{
                   pageStack.push(modelSelectPage);
               }
            }
            
        ]
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

        Text {
            id: statusText
            text: "Status: "
        }

        Text {
            id: modelName
            text: "No model loaded..."
        }

        Button {
            id: modelLoadButton
            text: "Load model"
            onClicked: {
                ml_model.load_model("/home/phablet/.local/share/ggml-model.bin");
            }
        }

        TextField {
            id: promptField
            placeholderText: i18n.tr('Prompt >')
        }

        Button {
            id: promptButton
            text: "Send"
            onClicked: {
                ml_model.prompt(promptField.text);
            }
        }

        Item {
            Layout.fillHeight: true
        }
    }

    Connections {
        target: modelFetchPage

        // Signal received from ModelFetch.qml
        onFileSelected: {
            // Handle the selected file information
            selectedFile = fileName;
            console.log("RECEIVED THE FILE: ", selectedFile);
            modelName.text = selectedFile;
            pageStack.pop();
        }
    }

}