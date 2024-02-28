import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

import Lomiri.Components 1.3
import Lomiri.DownloadManager 1.2
import Qt.labs.folderlistmodel 2.12

import ModelFetch 1.0

Page {
    id: modelFetch
    objectName: 'modelFetch'

    anchors.fill: parent
    Component.onCompleted: {
            // console.log("Loaded");
        }

    header: PageHeader {
        id: header
        title: i18n.tr('Model Download page')
    }

    DownloadManager {
        id: manager
    }

    ModelFetch {
        id: modelFetchObj
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

        // Item {
        //     Layout.fillHeight: true
        // }

        RowLayout {

            Icon {
                id: battery_indicator
                // Layout.alignment: Qt.AlignHCenter
                width: units.gu(3)
                height: units.gu(3)
                name: 'network-server-symbolic'
            }

            Label {
                id: label
                // Layout.alignment: Qt.AlignHCenter
                text: i18n.tr('Server IP:')
            }

            TextField {
                id: upperTextField
                // Layout.fillWidth: true
                // Layout.preferredHeight: parent.height * 0.25
                placeholderText: i18n.tr('localhost:8080')
            }

        }

        Button {
            // Layout.alignment: Qt.AlignHCenter
            text: "Get models"
            onClicked: {
                modelLoader.active = true;

                console.log("QML:sending a request for server contents from URL: " + upperTextField.text);
                var url = upperTextField.text;

                var xhr = new XMLHttpRequest();
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === XMLHttpRequest.DONE) {
                        console.log("XHR: request status:", xhr.status, xhr.readyState, xhr.withCredentials);
                        
                        if (xhr.status === 200) {
                            var htmlContent = xhr.responseText.replace(/&#47;/g, '/');
                            var anchorRegex = /<a[^>]*href=['"](.*?)['"][^>]*>.*?<\/a>/gi;
                            var matches = htmlContent.match(anchorRegex);
                            var fileList = [];

                            if (matches) {
                                for (var i = 0; i < matches.length; ++i) {
                                    var anchorTag = matches[i];
                                    console.log("Found anchor tag:", anchorTag);

                                    // Extract href attribute from the matched anchor tag
                                    var hrefStartIndex = anchorTag.indexOf('href="') + 6;
                                    var hrefEndIndex = anchorTag.indexOf('"', hrefStartIndex);
                                    var href = anchorTag.substring(hrefStartIndex, hrefEndIndex);
                                    console.log("Extracted href:", href);
                                    fileList.push({ "fileName": href });
                                }
                            }

                            // Update the ListView model with the fetched data
                            listView.model.clear();
                            for (var j = 0; j < fileList.length; ++j) {
                                listView.model.append(fileList[j]);
                            }
                        } else {
                            console.error("Failed to fetch data:", xhr.statusText);

                            
                        }
                    }
                };
                xhr.open("GET", url, true);
                xhr.send();
            }


        }

        Loader {
            id: modelLoader
            active: false
            onLoaded: {
                console.log("Model loaded:", upperTextField.text);
            }

            sourceComponent: ListModel {}
        }


        ListView {
            id: listView
            width: parent.width
            height: parent.height
            model: modelLoader.item
            
            delegate: Item {
                width: parent.width
                height: 50

                Rectangle {
                    width: parent.width
                    height: 50
                    color: "lightblue"

                    Text {
                        anchors.centerIn: parent
                        text: model.fileName
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            // Emit signal when a file is selected
                            console.log("Clicky-click on: ", model.fileName);
                            var model_url = upperTextField.text + model.fileName;
                            console.log("Clicky-click on: ", model_url);
                            manager.download(model_url);
                        }
                    }
                }
            }
        }

        Connections {
            target: manager
            onDownloadFinished: {
                
                var pathParts = path.split("/");
                var fileName = pathParts[pathParts.length-1];
                var desitinationBasename = "/home/phablet/.local/share/llmtest.georgi";
                var targetFilename = desitinationBasename + "/" + fileName;
                
                console.log(path);
                console.log(fileName, targetFilename);
                console.log("fileSelected signal emitted with filePath:", path);
                
                modelFetchObj.saveModel(path);
                fileSelected(path);
            }
        }

        Item {
            Layout.fillHeight: true
        }

    }

    signal fileSelected(string fileName)    
}