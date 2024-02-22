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

    // ModelFetch {
    //     id: modelFetchPage
    // }
    // import "ModelFetch.qml" as ModelFetch


    header: PageHeader {
        id: header
        title: i18n.tr('Local LLM test')

        /* the menu on the right side */
        trailingActionBar.actions: [

             Action {
                iconName: "help"
                text: i18n.tr("Models")
                onTriggered:{
                    pageStack.push(Qt.resolvedUrl("ModelFetch.qml"));
                    // pageStack.push(modelFetchPage);
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

        Item {
            Layout.fillHeight: true
        }
    }

    Connections {
        target: ModelFetch // Assuming 'modelFetchPage' is the ID or object name of ModelFetch.qml

        // Signal received from ModelFetch.qml
        onFileSelected: {
            // Handle the selected file information
            selectedFile = fileName;
            console.log("RECEIVED THE FILE: ", selectedFile);
            pageStack.pop();
            // Pop the ModelFetch.qml page from the stack
        }
    }

}